//
// Copyright © 2026 Alexander Romanov
// CLLocationCoordinate2DTests.swift
//

#if canImport(MapKit)
import MapKit
@testable import OversizeCore
import Testing

struct CLLocationCoordinate2DExtensionTests {
    @Test func id_combinesLatitudeAndLongitude() {
        let coordinate = CLLocationCoordinate2D(latitude: 1.5, longitude: 2.5)
        #expect(coordinate.id == "1.5-2.5")
    }

    @Test func id_differsForDifferentCoordinates() {
        let first = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let second = CLLocationCoordinate2D(latitude: 2, longitude: 1)
        #expect(first.id != second.id)
    }

    @Test func equality_comparesBothComponents() {
        #expect(CLLocationCoordinate2D(latitude: 1, longitude: 2) == CLLocationCoordinate2D(latitude: 1, longitude: 2))
        #expect(CLLocationCoordinate2D(latitude: 1, longitude: 2) != CLLocationCoordinate2D(latitude: 1, longitude: 3))
    }
}
#endif
