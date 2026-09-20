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
/// on every request and a Keychain round trip per call is wasteful; every cache fill and every
/// mutation runs under one lock, so a save from Settings cannot be overwritten by a read that
/// started before it.
public struct ServiceAPIKeyStorage: Sendable {
    public enum StorageError: Error {
        case encodingFailed
        case keychain(OSStatus)
    }

    public static let shared = ServiceAPIKeyStorage()
    public static let service = "AppConnector.ServiceAPIKeys"

    private static let store = Store()

    public init() {}

    public func key(for key: ServiceAPIKey) -> String? {
        guard let stored = storedKey(key), !stored.isEmpty else {
            return environmentKey(for: key)
        }
        return stored
    }

    public func hasKey(for key: ServiceAPIKey) -> Bool {
        self.key(for: key)?.isEmpty == false
    }

    public func isStored(_ key: ServiceAPIKey) -> Bool {
        storedKey(key)?.isEmpty == false
    }

    /// Whether the resolved key comes from the environment rather than the Keychain — Settings
    /// shows it so a developer does not wonder why a service works with an empty field.
    public func isFromEnvironment(_ key: ServiceAPIKey) -> Bool {
        !isStored(key) && environmentKey(for: key) != nil
    }

    public func save(_ value: String, for key: ServiceAPIKey) throws {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            try delete(key)
            return
        }
        guard let data = trimmed.data(using: .utf8) else {
            throw StorageError.encodingFailed
        }

        try Self.store.withLock { cache in
            if !Self.isTestProcess {
                try Self.write(data, for: key)
            }
            cache[key] = .value(trimmed)
        }
    }

    public func delete(_ key: ServiceAPIKey) throws {
        try Self.store.withLock { cache in
            if !Self.isTestProcess {
                let status = SecItemDelete(Self.baseQuery(for: key) as CFDictionary)
                guard status == errSecSuccess || status == errSecItemNotFound else {
                    throw StorageError.keychain(status)
                }
            }
            cache[key] = .missing
        }
    }

    public func deleteAll() throws {
        for key in ServiceAPIKey.allCases {
            try delete(key)
        }
    }

    // MARK: - Private

    /// The Keychain value, read through the cache. A read that fails for anything other than a
    /// missing item is not cached: the Keychain is simply unavailable before first unlock, and a
    /// negative cache entry would hide the key for the rest of the process lifetime.
    private func storedKey(_ key: ServiceAPIKey) -> String? {
        Self.store.withLock { cache in
            if let cached = cache[key] { return cached.value }
            guard !Self.isTestProcess else {
                cache[key] = .missing
                return nil
            }
            switch Self.keychainValue(for: key) {
            case let .success(value):
                cache[key] = value.map(CachedKey.value) ?? .missing
                return value
            case .failure:
                return nil
            }
        }
    }

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

    private static func write(_ data: Data, for key: ServiceAPIKey) throws {
        var addQuery = baseQuery(for: key)
        addQuery[kSecAttrAccessible] = kSecAttrAccessibleAfterFirstUnlock
        addQuery[kSecValueData] = data

        let addStatus = SecItemAdd(addQuery as CFDictionary, nil)
        switch addStatus {
        case errSecSuccess:
            return
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
    }

    private static func keychainValue(for key: ServiceAPIKey) -> Result<String?, StorageError> {
        var query = baseQuery(for: key)
        query[kSecReturnData] = kCFBooleanTrue
        query[kSecMatchLimit] = kSecMatchLimitOne

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        switch status {
        case errSecSuccess:
            guard let data = result as? Data else { return .success(nil) }
            return .success(String(data: data, encoding: .utf8))
        case errSecItemNotFound:
            return .success(nil)
        default:
            return .failure(.keychain(status))
        }
    }

    private static func baseQuery(for key: ServiceAPIKey) -> [CFString: Any] {
        [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key.rawValue,
        ]
    }

    /// A test host has no Keychain entitlement on macOS and would answer every lookup with a
    /// prompt or an error, so suites stay on the cache and the environment fallback only — writes
    /// included, or a suite exercising Settings would mutate the host's real Keychain.
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
    enum CachedKey {
        case missing
        case value(String)

        var value: String? {
            switch self {
            case .missing: nil
            case let .value(value): value
            }
        }
    }

    final class Store: @unchecked Sendable {
        private let lock = NSLock()
        private var cache: [ServiceAPIKey: CachedKey] = [:]

        func withLock<Value>(_ body: (inout [ServiceAPIKey: CachedKey]) throws -> Value) rethrows -> Value {
            lock.lock()
            defer { lock.unlock() }
            return try body(&cache)
        }
    }
}
#endif
