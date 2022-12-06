//
//  MapView.swift
//  countries
//
//  Created by Ricardo Granja Chávez on 05/12/22.
//

import SwiftUI
import MapKit

struct City: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    var annotationItem: City
    private let spanValue: Double = 15.0
    
    var body: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: self.annotationItem.coordinate,
                                                           span: MKCoordinateSpan(latitudeDelta: self.spanValue,
                                                                                  longitudeDelta: self.spanValue))),
            showsUserLocation: true,
            annotationItems: [self.annotationItem]) {
            MapMarker(coordinate: $0.coordinate)
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle(self.annotationItem.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(annotationItem: City(name: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0)))
    }
}
