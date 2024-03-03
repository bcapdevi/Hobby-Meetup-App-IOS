//
//  MapViewController.swift
//  FinalProject
//
//  Created by Turing on 12/5/23.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

var events : [Event] = []
var pinLatitude : Double = 0
var pinLongitude : Double = 0

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a gesture recognizer to the map view
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
                mapLocations.addGestureRecognizer(tapGesture)
                
                // Set the view controller as the map view's delegate
                mapLocations.delegate = self
        let austin = MKPointAnnotation()
        austin.coordinate = CLLocationCoordinate2DMake(30.2672, -97.7431)
        
        let region = MKCoordinateRegion(center: austin.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
       mapLocations.setRegion(region, animated: true)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        events = []
        
        var data = [Event]()
        
        do{
            data = try context.fetch(Event.fetchRequest())
            
            for existingEvent in data{
                events.append(existingEvent)
            }
        }catch{}
        
        
        for item in events{
            let pinpoint = MKPointAnnotation()
            pinpoint.coordinate = CLLocationCoordinate2DMake(item.latitude, item.longitude)
            pinpoint.title = item.title
            
            mapLocations.addAnnotation(pinpoint)
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    

    
    var locationManager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation : CLLocation = locations[0]
        
        locationManager.stopUpdatingLocation()
        
        let here = MKPointAnnotation()
        
        here.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        
        //here.title = "hello I am here"
        
        //mapLocations.addAnnotation(here)
        
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        mapLocations.setRegion(region, animated: true)
        
        
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        // Get the location where the user tapped on the map
        let location = mapLocations.convert(gestureRecognizer.location(in: mapLocations), toCoordinateFrom: mapLocations)
            
        // Create a pin annotation and add it to the map
        let pin = MKPointAnnotation()
        pin.coordinate = location
        //mapLocations.addAnnotation(pin)
        
        pinLatitude = pin.coordinate.latitude
        pinLongitude = pin.coordinate.longitude
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "creation") as UIViewController
        
        self.present(vc, animated: true, completion: nil)
            
        
          
        }

    @IBOutlet weak var mapLocations: MKMapView!
}
