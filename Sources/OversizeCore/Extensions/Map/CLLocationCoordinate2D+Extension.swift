//
// Copyright © 2022 Alexander Romanov
// CLLocationCoordinate2D+Extension.swift
//

import MapKit

extension CLLocationCoordinate2D: @retroactive Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
