
//
//  newConnectionViewController.swift
//  Energion_Consumer
//
//  Created by Lakshay Chhabra on 30/03/18.
//  Copyright © 2018 Lakshay Chhabra. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class newConnectionViewController: UIViewController {

    let url = "https://energion.appgroceries.com/api/connection/new"
   
    
    @IBOutlet var connectionAddress: UITextField!
    @IBOutlet var applicantNameText: UITextField!
    @IBOutlet var voltageSupply: UITextField!
    @IBOutlet var loadDemand: UITextField!
    @IBOutlet var connectionType: UITextField!
    @IBOutlet var connectionCategory: UITextField!
    @IBOutlet var aadhar: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var contactNumber: UITextField!
    @IBOutlet var fathersNameText: UITextField!
     @IBOutlet var permanentAddress: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
       
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    

    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
   
    }

    @IBAction func Submit(_ sender: Any) {
        if connectionAddress.text=="" || applicantNameText.text=="" || voltageSupply.text=="" || loadDemand.text=="" || connectionType.text=="" || connectionCategory.text=="" || aadhar.text=="" || email.text=="" || contactNumber.text=="" || fathersNameText.text=="" || permanentAddress.text=="" {
            
            displayAlert(title: "Missing Fields", message: "All Fields are Neccessary!")
        }
        else {
            
            let params : [String : String] = [
                "applicantName" : applicantNameText.text!,
                "fatherhusbandName" : fathersNameText.text!,
                 "connectionAddress" : connectionAddress.text!,
                 "contactNumber" : contactNumber.text!,
                 "email" : email.text!,
                 "permanentAddress" : permanentAddress.text!,
                 "aadharNumber" : aadhar.text!,
                 "connectionCategory" : connectionCategory.text!,
                 "connectionType" : connectionType.text!,
                 "loadDemand" : loadDemand.text!,
                 "voltageSupply" : voltageSupply.text!,
                  "token" : LogInViewController.token
                 ]
            
            let header : [String : String] = ["x-access-token" : LogInViewController.token]
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: header).responseJSON{ response in
                print(response)
            }

                  //clearing the text fields
                    applicantNameText.text = ""
                    fathersNameText.text = ""
                   connectionAddress.text = ""
                    contactNumber.text = ""
                    email.text = ""
                    permanentAddress.text = ""
                    aadhar.text = ""
                    connectionCategory.text = ""
                    connectionType.text = ""
                    loadDemand.text = ""
                    voltageSupply.text = ""
                }
    
    }

}
