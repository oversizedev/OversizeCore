//
// Copyright © 2022 Alexander Romanov
// CLLocationCoordinate2D+Extension.swift
//

import MapKit

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}
