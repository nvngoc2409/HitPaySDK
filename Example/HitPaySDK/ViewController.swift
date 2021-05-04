//
//  ViewController.swift
//  HitPaySDK
//
//  Created by Kevin on 04/28/2021.
//  Copyright (c) 2021 Kevin. All rights reserved.
//

import UIKit
import HitPaySDK

class ViewController: UIViewController {
    var isBlinking = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: Any) {
        HPManager.shared.login(self)
    }
}

