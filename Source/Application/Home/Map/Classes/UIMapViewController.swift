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
    private var routeOverlays: [MKOverlay] = []
    
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
    
    func mapView(_ mapView: MKMapView,
                 rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 5.0
        
        return renderer
    }
}

// MARK: - Public API
extension UIMapViewController {
    func set(places: [UIMapViewPlace],
             clearPrevious: Bool = false) {
        
        if clearPrevious {
            annotationsHash = [:]
            placesHash = [:]
            mapView.removeAnnotations(mapView.annotations)
        }
        
        guard !places.isEmpty else {
            return
        }
        
        var markers: [MKPointAnnotation] = []
        
        places.forEach {
            guard annotationsHash[$0.id] == nil else {
                return
            }
            
            let marker = annotation(from: $0)
            markers.append(marker)
            annotationsHash[$0.id] = marker
            placesHash[marker] = $0
        }
        
        mapView.addAnnotations(markers)
    }
    
    func move(to place: UIMapViewPlace) {
        guard let userLocation = locationManager.location else {
            return
        }
        
        let userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = userLocation.coordinate
        
        guard let marker = annotationsHash[place.id] else {
            return
        }

        mapView.removeOverlays(routeOverlays)
        mapView.showAnnotations([userAnnotation, marker], animated: true)
        mapView.selectAnnotation(marker, animated: true)
    }
    
    func routeTo(place placeID: String) {
        guard let annotation = annotationsHash[placeID] else {
            return
        }
        
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: annotation.coordinate))
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [weak self] (response, error) in
            guard let self = self else { return }
            
            if let response = response {
                self.showRoute(response)
            }
        }
    }
}

// MARK: - Helper Methods
private extension UIMapViewController {
    func annotation(from place: UIMapViewPlace) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude,
                                                       longitude: place.longitude)
        
        return annotation
    }
    
    func showRoute(_ response: MKDirections.Response) {
        mapView.removeOverlays(routeOverlays)
        
        response.routes.forEach {
            let overlay = $0.polyline
            
            routeOverlays.append(overlay)
            
            mapView.addOverlay(overlay,
                               level: MKOverlayLevel.aboveRoads)
        }
    }
}
