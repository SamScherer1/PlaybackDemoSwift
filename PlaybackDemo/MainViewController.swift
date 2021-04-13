//
//  MainViewController.swift
//  PlaybackDemo
//
//  Created by Samuel Scherer on 4/13/21.
//  Copyright © 2021 DJI. All rights reserved.
//

import Foundation
import UIKit
import DJIUXSDK

class MainViewController: UIViewController, DJISDKManagerDelegate {
    
    var product : DJIBaseProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DJISDKManager.registerApp(with: self)
        self.initUI()
        if let product = self.product {
            self.updateStatusBasedOn(product:product);
        }
    }
    
    func initUI() {
        print("todo: initUI")
    }
    
    func updateStatusBasedOn(product:DJIBaseProduct) {
        print("todo: updateStatusBasedOn:")
    }
    
    func appRegisteredWithError(_ error: Error?) {
        print("todo: appRegisteredWithError called")
    }
    
    func didUpdateDatabaseDownloadProgress(_ progress: Progress) {
        print("todo: didUpdateDatabaseDownloadProgress called")
    }
}
