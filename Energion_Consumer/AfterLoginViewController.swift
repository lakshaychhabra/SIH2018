//
//  AfterLoginViewController.swift
//  Energion_Consumer
//
//  Created by Lakshay Chhabra on 30/03/18.
//  Copyright © 2018 Lakshay Chhabra. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON
class AfterLoginViewController: UIViewController, CLLocationManagerDelegate
 {
     let url = "https://api-egn.nvixion.tech/auth/logout"
     var locationManager = CLLocationManager()
     var userLocation = CLLocationCoordinate2D()
    
    @IBOutlet var map: MKMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
     
        

    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        userLocation = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
    }
    
    @IBAction func logout(_ sender: Any) {
        print("hello")
        let t = LogInViewController.token
        print("hello")
        print(t)
        //print("hello \(token1)"))
        
       let header : [String : String] = ["x-access-token" : LogInViewController.token]
        //spinners
        
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        //spinners end

        Alamofire.request(url, method: .get, headers: header).responseString { (response) in
            print(response)
            
        }

        performSegue(withIdentifier: "logout", sender: self)
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
     
        
    }

    
}
