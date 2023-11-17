//  Created by Shazia Vohra on 2023-11-17.

import MapKit
import SwiftUI

enum mapDetail{
    static let startingLocation = CLLocationCoordinate2D(latitude: 43.744948781842666, longitude: -79.2196730206679)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    var locationManager: CLLocationManager?
    
    @Published public var region = MKCoordinateRegion(
        center: mapDetail.startingLocation,
        span: mapDetail.defaultSpan
    )
    
    func checkIfLocationServIsEnabled() {
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        }else{
            print("Show an alert that location is off and turn it on")
        }
    }
    
    func checkLocationAuthorization(){
        guard let locationManager = locationManager else {return}
        
        switch locationManager.authorizationStatus{
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to provincial control")
        case .denied:
            print("permission is denied please go and set in app setting")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: mapDetail.defaultSpan)
        @unknown default:
            break
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

