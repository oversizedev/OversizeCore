//
// Copyright © 2024 Alexander Romanov
// Coordinate2DData.swift, created on 13.06.2024
//

import MapKit

public struct Coordinate2DData: Codable {
    public let latitude: Double
    public let longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    public init(_ location: CLLocationCoordinate2D) {
        latitude = location.latitude
        longitude = location.longitude
    }

    public var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
