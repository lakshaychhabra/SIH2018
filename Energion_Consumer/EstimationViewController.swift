//
//  EstimationViewController.swift
//  Energion_Consumer
//
//  Created by Lakshay Chhabra on 09/04/19.
//  Copyright © 2019 Lakshay Chhabra. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class EstimationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var loadRequired: UITextField!
    @IBOutlet var view2: UIView!
    @IBOutlet var view1: UIView!
    @IBOutlet var estimateButton: UIButton!
    @IBOutlet var distance: UILabel!
    @IBOutlet var totalAmount: UILabel!
    @IBOutlet var trenchAmount: UILabel!
    @IBOutlet var trenchRate: UILabel!
    @IBOutlet var trenchQuant: UILabel!
    @IBOutlet var terminationAmount: UILabel!
    @IBOutlet var terminationRate: UILabel!
    @IBOutlet var terminationQuant: UILabel!
    @IBOutlet var jointsAmount: UILabel!
    @IBOutlet var jointsRate: UILabel!
    @IBOutlet var jointsQuant: UILabel!
    @IBOutlet var cableAmount: UILabel!
    @IBOutlet var cableRate: UILabel!
    @IBOutlet var cableQuant: UILabel!
    @IBOutlet var current: UILabel!
    @IBOutlet var voltage: UILabel!
    @IBOutlet var load: UILabel!
    
    let url = "https://energion.appgroceries.com/api/estimate/evaluate"
    var locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    var lat : Double = 29.3909
    var lon : Double = 76.9635
    var currentLocation: CLLocation!
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    override func viewDidLoad() {
        super.viewDidLoad()
        locationPredefaults()
        view2.alpha = 0;
        view1.alpha = 0;
        estimateButton.alpha = 0.5;
        estimateButton.isEnabled = false;
        loadRequired.text = "";
        self.hideKeyboardWhenTappedAround()
    }
    
    func activityIndicatorFunc() {
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
    }
    
    //keyboard hide
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func estimate(_ sender: Any) {
        if(loadRequired.text == ""){
            displayAlert(title: "Empty Values", message: "Please enter the Power Required")
            view1.alpha = 0
            view2.alpha = 0
        }
        else{
        activityIndicatorFunc()
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let params : [String : AnyObject] = ["location" : ["lat" : lat, "lng" : lon] as AnyObject, "load" : loadRequired.text! as AnyObject]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody).responseJSON(completionHandler: { (response) in
            //print(response)
            let data : JSON = JSON(response.result.value!)
            print(data["success"])
            print(data)
            
            if(!data["success"].boolValue){
                let value = data["msg"].rawString()
                self.displayAlert(title: "Unsuccessful", message: value ?? "Please try again with new load")
                self.view2.alpha = 0
                self.view2.alpha = 0
            }
            else{
                self.view2.alpha = 1;
                self.view1.alpha = 1;
                
                self.distance.text = data["data"]["substation"]["distance"].rawString()
              
                let electrical = data["data"]["electrical"]
                let load = electrical["load"]
                let voltage = electrical["voltage"]
                let current = electrical["current"]
                
                self.load.text = load.rawString();
                self.voltage.text = voltage.rawString()
                self.current.text = current.rawString()
                
                
                //TECHNICAL
                let technical = data["data"]["technical"]
                let length = technical["length"]
                let cablesize = technical["cableSize"]
                let joints = technical["joints"]
                let termination = "2"
                self.cableQuant.text = cablesize.rawString()
                self.jointsQuant.text = joints.rawString()
                self.terminationQuant.text = termination
                self.trenchQuant.text = length.rawString()
                
                
                //CHARTS
                let rate = data["data"]["chart"]
                let jointRate = rate["joint"]
                let cableRate = rate["cable"]
                let terminationRate = rate["termination"]
                let trenchCost = "200"
                
                self.cableRate.text = cableRate.rawString()
                self.jointsRate.text = jointRate.rawString()
                self.terminationRate.text = terminationRate.rawString()
                self.trenchRate.text = trenchCost
                
                
                
                let totalCost = data["data"]["total"]
                self.totalAmount.text = totalCost.rawString()
                
                
                //Costs
                let costs = data["data"]["costs"]
                let terminationCost = costs["termination"]
                let cablingCosts = costs["cabling"]
                let trenchCosts = costs["trench"]
                let jointCosts = costs["joints"]
                
                self.cableAmount.text = cablingCosts.rawString()
                self.terminationAmount.text = terminationCost.rawString()
                self.trenchAmount.text = trenchCosts.rawString()
                self.jointsAmount.text = jointCosts.rawString()
                
                //print(data["data"]["substation"].rawString())
            }
            
        })
        
        
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }

        
    }
    // Print out the location to the console
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location.coordinate)
            estimateButton.alpha = 1;
            estimateButton.isEnabled = true;
            lat = location.coordinate.latitude
            lon = location.coordinate.longitude
        }
    }
    
    // If we have been deined access give the user the option to change it
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    // Show the popup to the user if we have been deined access
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: "In order to deliver pizza we need your location",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func locationPredefaults(){
       
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        else{
            displayAlert(title: "Location Error", message: "Please turn the location on from the privacy")
        }
    }
}
