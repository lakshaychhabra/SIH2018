//
//  SignUPViewController.swift
//  Energion_Consumer
//
//  Created by Lakshay Chhabra on 31/03/18.
//  Copyright © 2018 Lakshay Chhabra. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUPViewController: UIViewController {

    let url = "https://api-egn.nvixion.tech/auth/register"
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var enterPassword: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var username: UITextField!
    @IBOutlet var phoneNo: UITextField!
    @IBOutlet var fullName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    

    @IBAction func Register(_ sender: Any) {
        
        if confirmPassword.text == "" || enterPassword.text == "" || email.text == "" || username.text == "" || phoneNo.text == "" || fullName.text == "" {
            
            displayAlert(title: "Enter Everything", message: "All Fields Are neccessary")
            
        }
//        else if confirmPassword.text != enterPassword.text {
//            displayAlert(title: "Passwords Different", message: "Please enter Same passwords")
//        }
        else {
            let params : [String : AnyObject] = ["fullName" : fullName.text! as AnyObject, "username" : username.text! as AnyObject, "email" : email.text! as AnyObject, "passEnter" : enterPassword.text! as AnyObject, "passConfirm" : confirmPassword.text! as AnyObject]
            
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody).responseJSON(completionHandler: { (response) in
                print(response)
                let data : JSON = JSON(response.result.value!)
                
                    print(data)
                    self.performSegue(withIdentifier: "signin", sender: nil)
                
            })
            
        }
        
    }
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
        
        
        
    }

  //  fullName, userName, email, phone, passEnter, passConfirm
}
