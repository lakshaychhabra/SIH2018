//
//  UpdateConnectionViewController.swift
//  Energion_Consumer
//
//  Created by Lakshay Chhabra on 31/03/18.
//  Copyright © 2018 Lakshay Chhabra. All rights reserved.
//

import UIKit

class UpdateConnectionViewController: UIViewController {

    @IBOutlet var requiredKV: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func request(_ sender: Any) {
        
        requiredKV.text = ""
        
    }
   

}
