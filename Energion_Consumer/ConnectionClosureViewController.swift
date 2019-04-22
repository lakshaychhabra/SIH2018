//
//  ConnectionClosureViewController.swift
//  Energion_Consumer
//
//  Created by Lakshay Chhabra on 30/03/18.
//  Copyright © 2018 Lakshay Chhabra. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ConnectionClosureViewController: UIViewController {

    @IBOutlet var reasonOfClosure: UITextField!
    @IBOutlet var lastBillNumber: UITextField!
    @IBOutlet var lastBillAmount: UITextField!
    var email : JSON = []
    
    let closeUrl = "https://energion.appgroceries.com/api/connection/closure"
    let getUrl = "https://energion.appgroceries.com/api/auth/status"
    let myconUrl = "https://energion.appgroceries.com/api/connection/mycon"
    let headers : [String : String] = ["x-access-token" : LogInViewController.token]
   
    override func viewDidLoad() {
        super.viewDidLoad()

       
        Alamofire.request(getUrl, method: .get, headers: headers).responseString { (response) in
            print("hello \(response)")
            if let data : JSON = JSON(response.result.value!) {
               print(data)
                //self.email = data["data.username"]
                print(self.email)
                
                
            }
            
        }
        
        self.hideKeyboardWhenTappedAround()
        
        
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
    
    //display alerts
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
   
    @IBAction func submit(_ sender: Any) {
        
        if reasonOfClosure.text == "" || lastBillNumber.text == "" || lastBillAmount.text == "" {
            displayAlert(title: "Missing Fields", message: "All Fields are Neccessary!")
        }
        else {
            
            
            
            //clearing text fields
            reasonOfClosure.text = ""
            lastBillNumber.text = ""
            lastBillAmount.text = ""
           }
       }
    
}
