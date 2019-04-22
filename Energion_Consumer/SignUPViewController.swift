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

    let url = "https://energion.appgroceries.com/api/auth/register"
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

        if confirmPassword.text == "" || enterPassword.text == "" || email.text == "" || phoneNo.text == "" || fullName.text == "" {

            displayAlert(title: "Enter Everything", message: "All Fields Are neccessary")

        }
//        else if confirmPassword.text != enterPassword.text {
//            displayAlert(title: "Passwords Different", message: "Please enter Same passwords")
//        }
        else {
            let params : [String : AnyObject] = ["fullname" : fullName.text! as AnyObject,  "email" : email.text! as AnyObject, "password" : enterPassword.text! as AnyObject, "passwordConfirm" : confirmPassword.text! as AnyObject, "phone" : phoneNo.text! as AnyObject]


            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody).responseJSON(completionHandler: { (response) in
                print(response)
                let data : JSON = JSON(response.result.value!)

                    print(data["success"])
                if data["success"] == false {
                    let out = data["msg"]
                    self.displayAlert(title: "Sign Up Failed", message: out.rawString() ?? "Please Check the form again")
                }
                else{
                    self.performSegue(withIdentifier: "signin", sender: nil)
                }
            })

        }

    }
    func displayAlert(title: String, message: String) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)


    }


}
