//
// Copyright © 2024 Alexander Romanov
// Coordinate2DData.swift, created on 13.06.2024
//

#if canImport(MapKit)
import MapKit
#endif

public struct Coordinate2DData: Codable {
    public let latitude: Double
    public let longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

#if canImport(MapKit)
public extension Coordinate2DData {
    init(_ location: CLLocationCoordinate2D) {
        latitude = location.latitude
        longitude = location.longitude
    }

    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
#endif
