//
// Copyright © 2026 Alexander Romanov
// ServiceAPIKeyStorage.swift, created on 19.09.2026
//

#if canImport(Darwin)
import Foundation
import Security

// MARK: - ServiceAPIKey

public enum ServiceAPIKey: String, CaseIterable, Sendable {
    case openAI
    case sonar

    public var displayName: String {
        switch self {
        case .openAI: "OpenAI"
        case .sonar: "Sonar"
        }
    }

    public var environmentVariable: String {
        switch self {
        case .openAI: "OPENAI_API_KEY"
        case .sonar: "SONAR_API_KEY"
        }
    }

    public var keyPrefixHint: String {
        switch self {
        case .openAI: "sk-..."
        case .sonar: "sonar_..."
        }
    }

    public var consoleURL: URL? {
        switch self {
        case .openAI: URL(string: "https://platform.openai.com/api-keys")
        case .sonar: URL(string: "https://trysonar.app/settings/api")
        }
    }
}

// MARK: - ServiceAPIKeyStorage

/// Keychain-backed store for third-party API keys entered by the user in Settings.
///
/// A stored key always wins over `environmentVariable`, which stays as the development fallback
/// injected by the Dev schemes. Values are cached in memory because the pipeline asks for the key
/// on every request and a Keychain round trip per call is wasteful.
public struct ServiceAPIKeyStorage: Sendable {
    public enum StorageError: Error {
        case encodingFailed
        case keychain(OSStatus)
    }

    public static let shared = ServiceAPIKeyStorage()
    public static let service = "AppConnector.ServiceAPIKeys"

    private static let cache = Cache()

    public init() {}

    public func key(for key: ServiceAPIKey) -> String? {
        if let cached = Self.cache.value(for: key) {
            return cached.flatMap { $0.isEmpty ? nil : $0 } ?? environmentKey(for: key)
        }
        let stored = Self.isTestProcess ? nil : keychainValue(for: key)
        Self.cache.store(stored, for: key)
        guard let stored, !stored.isEmpty else { return environmentKey(for: key) }
        return stored
    }

    public func hasKey(for key: ServiceAPIKey) -> Bool {
        self.key(for: key)?.isEmpty == false
    }

    public func isStored(_ key: ServiceAPIKey) -> Bool {
        guard !Self.isTestProcess else { return false }
        if let cached = Self.cache.value(for: key) {
            return cached?.isEmpty == false
        }
        let stored = keychainValue(for: key)
        Self.cache.store(stored, for: key)
        return stored?.isEmpty == false
    }

    public func save(_ value: String, for key: ServiceAPIKey) throws {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            delete(key)
            return
        }
        guard let data = trimmed.data(using: .utf8) else {
            throw StorageError.encodingFailed
        }

        var addQuery = baseQuery(for: key)
        addQuery[kSecAttrAccessible] = kSecAttrAccessibleAfterFirstUnlock
        addQuery[kSecValueData] = data

        let addStatus = SecItemAdd(addQuery as CFDictionary, nil)
        switch addStatus {
        case errSecSuccess:
            break
        case errSecDuplicateItem:
            let updateStatus = SecItemUpdate(
                baseQuery(for: key) as CFDictionary,
                [kSecValueData: data] as CFDictionary,
            )
            guard updateStatus == errSecSuccess else {
                throw StorageError.keychain(updateStatus)
            }
        default:
            throw StorageError.keychain(addStatus)
        }

        Self.cache.store(trimmed, for: key)
    }

    public func delete(_ key: ServiceAPIKey) {
        SecItemDelete(baseQuery(for: key) as CFDictionary)
        Self.cache.store(nil, for: key)
    }

    public func deleteAll() {
        for key in ServiceAPIKey.allCases {
            delete(key)
        }
    }

    // MARK: - Private

    /// Development fallback only: the Dev schemes forward the keys from `Secrets.xcconfig`, while a
    /// TestFlight or App Store build must rely on what the user typed in Settings.
    private func environmentKey(for key: ServiceAPIKey) -> String? {
        #if DEBUG
        guard let value = ProcessInfo.processInfo.environment[key.environmentVariable],
              !value.isEmpty
        else { return nil }
        return value
        #else
        _ = key
        return nil
        #endif
    }

    /// Whether the resolved key comes from the environment rather than the Keychain — Settings
    /// shows it so a developer does not wonder why a service works with an empty field.
    public func isFromEnvironment(_ key: ServiceAPIKey) -> Bool {
        !isStored(key) && environmentKey(for: key) != nil
    }

    private func keychainValue(for key: ServiceAPIKey) -> String? {
        var query = baseQuery(for: key)
        query[kSecReturnData] = kCFBooleanTrue
        query[kSecMatchLimit] = kSecMatchLimitOne

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess, let data = result as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }

    private func baseQuery(for key: ServiceAPIKey) -> [CFString: Any] {
        [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: Self.service,
            kSecAttrAccount: key.rawValue,
        ]
    }

    /// A test host has no Keychain entitlement on macOS and would answer every lookup with a
    /// prompt or an error, so suites stay on the environment fallback only.
    private static var isTestProcess: Bool {
        if Bundle.main.bundleURL.pathExtension == "xctest" {
            return true
        }
        let environment = ProcessInfo.processInfo.environment
        if environment["XCTestConfigurationFilePath"] != nil || environment["XCTestBundlePath"] != nil {
            return true
        }
        return ProcessInfo.processInfo.arguments.contains { argument in
            argument.hasSuffix(".xctest") || argument.contains(".xctest/") || argument == "--testing-library"
        }
    }
}

// MARK: - Cache

private extension ServiceAPIKeyStorage {
    final class Cache: @unchecked Sendable {
        private let lock = NSLock()
        private var values: [ServiceAPIKey: String?] = [:]

        func value(for key: ServiceAPIKey) -> String?? {
            lock.lock()
            defer { lock.unlock() }
            return values[key]
        }

        func store(_ value: String?, for key: ServiceAPIKey) {
            lock.lock()
            defer { lock.unlock() }
            values[key] = value
        }
    }
}
#endif
