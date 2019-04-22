//
//  LogInViewController.swift
//  Energion_Consumer
//
//  Created by Lakshay Chhabra on 30/03/18.
//  Copyright © 2018 Lakshay Chhabra. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LogInViewController: UIViewController {

    static var token = "1"
    var output : JSON = []
    
    @IBOutlet var usernameTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    var checkCleared = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
    }
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
     
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if usernameTextField.text == "" || passwordTextField.text == "" {
            
            displayAlert(title: "Missing Info", message: "Must Enter Email and Password")
            
        }
        else{
            //spinners
            
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            
            //spinners end
            
            if let username = usernameTextField.text {
                if let password = passwordTextField.text{
                    let parameters : [String : String] = ["id" : username, "password" : password]
                    let url = "https://energion.appgroceries.com/api/auth/login"
                   
                    Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON { response in
                       
                        
                        print(response)
                        if let data : JSON = JSON(response.result.value) {
                       // print(data)
                            self.output = data["token"]
                            
                       // print("heyyyyyy \(self.token)")
                      //  print(output)
                            if self.output != JSON.null  {
                                
                                if let token1 = self.output.rawString() {
                                    LogInViewController.token = token1
                            //        print(self.token)
                                }
                               self.performSegue(withIdentifier: "afterLoginSegue", sender: nil)
                                
                                activityIndicator.stopAnimating()
                                UIApplication.shared.endIgnoringInteractionEvents()
                                print("AAAAA")
                             //   print(self.token)
                        }
                            else{
                                self.displayAlert(title: "Unable To Sign In", message: "Wrong Username or Password")
                                activityIndicator.stopAnimating()
                                UIApplication.shared.endIgnoringInteractionEvents()
                                
                        }
                        
                       }
                    }
                        
                    
                 //  print(token)
                }
            }
            
        }
     
    
        

    }
    
    

    



}
