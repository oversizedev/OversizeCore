//
// Copyright © 2026 Alexander Romanov
// Coordinate2DDataTests.swift
//

import Foundation
@testable import OversizeCore
import Testing
#if canImport(MapKit)
import MapKit
#endif

struct Coordinate2DDataTests {
    @Test func init_storesComponents() {
        let data = Coordinate2DData(latitude: 55.75, longitude: 37.61)
        #expect(data.latitude == 55.75)
        #expect(data.longitude == 37.61)
    }

    @Test func codable_roundTrips() throws {
        let original = Coordinate2DData(latitude: 55.75, longitude: 37.61)
        let encoded = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Coordinate2DData.self, from: encoded)
        #expect(decoded.latitude == original.latitude)
        #expect(decoded.longitude == original.longitude)
    }

    #if canImport(MapKit)
    @Test func initFromCoordinate_copiesComponents() {
        let coordinate = CLLocationCoordinate2D(latitude: 55.75, longitude: 37.61)
        let data = Coordinate2DData(coordinate)
        #expect(data.latitude == coordinate.latitude)
        #expect(data.longitude == coordinate.longitude)
    }

    @Test func location_roundTripsThroughCoordinate() {
        let coordinate = CLLocationCoordinate2D(latitude: -33.87, longitude: 151.21)
        #expect(Coordinate2DData(coordinate).location == coordinate)
    }
    #endif
}
