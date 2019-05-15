//
//  UIMapViewController.swift
//  Places
//
//  Created by Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit
import MapKit

class UIMapViewController: UIViewController {
    private var annotations: [String: MKPointAnnotation] = [:]
    
    @IBOutlet private weak var mapView: MKMapView!
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        return locationManager
    }()
}

// MARK: - Lifecycle
extension UIMapViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
    }
}

extension UIMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView) {
        
        
    }
}

// MARK: - Public API
extension UIMapViewController {
    func set(places: [UIMapViewPlace]) {
        var markers: [MKPointAnnotation] = []
        
        places.forEach {
            let marker = annotation(from: $0)
            markers.append(marker)
            annotations[$0.id] = marker
        }
        
        mapView.addAnnotations(markers)
    }
    
    func move(to place: UIMapViewPlace) {
        let userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = locationManager.location!.coordinate
        
        let marker = annotations[place.id] ?? annotation(from: place)
        mapView.showAnnotations([userAnnotation, marker], animated: true)
        mapView.selectAnnotation(marker, animated: true)
    }
}

// MARK: - Helper Methods
private extension UIMapViewController {
    func annotation(from place: UIMapViewPlace) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        return annotation
    }
}
