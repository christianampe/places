//
//  UIMapViewController.swift
//  Places
//
//  Created by Christian Ampe on 5/14/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit
import MapKit

protocol UIMapViewDataSource: class {
    func mapView(_ mapView: MKMapView,
                 placesIn region: MKCoordinateRegion) -> [UIMapViewPlace]
}

protocol UIMapViewDelegate: class {
    func mapView(_ mapView: MKMapView,
                 didSelect place: UIMapViewPlace)
}

extension UIMapViewDelegate {
    func mapView(_ mapView: MKMapView,
                 didSelect place: UIMapViewPlace) {}
}

class UIMapViewController: UIViewController {
    
    @IBOutlet private weak var mapView: MKMapView!
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        return locationManager
    }()
    
    private var annotationsHash: [String: MKPointAnnotation] = [:]
    private var placesHash: [MKPointAnnotation: UIMapViewPlace] = [:]
    
    weak var dataSource: UIMapViewDataSource?
    weak var delegate: UIMapViewDelegate?
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
        
        guard let annotation = view.annotation as? MKPointAnnotation else {
            return
        }
        
        guard let place = placesHash[annotation] else {
            return
        }
        
        delegate?.mapView(mapView,
                          didSelect: place)
    }
    
    func mapView(_ mapView: MKMapView,
                 regionDidChangeAnimated animated: Bool) {
                
        guard let places = dataSource?.mapView(mapView, placesIn: mapView.region) else {
            return
        }

        set(places: places)
    }
}

// MARK: - Public API
extension UIMapViewController {
    func set(places: [UIMapViewPlace]) {
        guard !places.isEmpty else {
            return
        }
        
        var markers: [MKPointAnnotation] = []
        
        places.forEach {
            let marker = annotation(from: $0)
            markers.append(marker)
            annotationsHash[$0.id] = marker
            placesHash[marker] = $0
        }
        
        mapView.addAnnotations(markers)
    }
    
    func move(to place: UIMapViewPlace) {
        let userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = locationManager.location!.coordinate
        
        guard let marker = annotationsHash[place.id] else {
            return
        }

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
