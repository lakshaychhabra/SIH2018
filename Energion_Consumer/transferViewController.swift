//
//  transferViewController.swift
//  Energion_Consumer
//
//  Created by Lakshay Chhabra on 31/03/18.
//  Copyright © 2018 Lakshay Chhabra. All rights reserved.
//

import UIKit

class transferViewController: UIViewController {

    @IBOutlet var address: UITextField!
    @IBOutlet var aadhar: UITextField!
    @IBAction func aadharNumber(_ sender: Any) {
    }
    
    @IBOutlet var transferringTo: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func submit(_ sender: Any) {
        
        transferringTo.text = ""
        aadhar.text = ""
        address.text = ""
    }
  

}
