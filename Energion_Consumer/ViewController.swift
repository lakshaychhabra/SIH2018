//
//  ViewController.swift
//  Energion_Consumer
//
//  Created by Lakshay Chhabra on 30/03/18.
//  Copyright © 2018 Lakshay Chhabra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

   
    @IBAction func loginButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "loginSegue", sender: nil)
        
    }
    
}

