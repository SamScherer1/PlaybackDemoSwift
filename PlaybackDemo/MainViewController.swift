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
    
    @IBOutlet weak var connectStatusLabel: UILabel!
    @IBOutlet weak var modelNameLabel: UILabel!
    @IBOutlet weak var connectButton: UIButton!
    
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
        self.modelNameLabel.isHidden = true
        //Disable the connect button by default
        self.connectButton.isEnabled = false
    }
    
    func productConnected(_ product: DJIBaseProduct?) {
        if let product = product {
            self.product = product
            self.connectButton.isEnabled = true
        }
        self.updateStatusBasedOn(product: product)
        
        ///If this demo is used in China, it's required to login to your DJI account to activate the application. Also you need to use DJI Go app to bind the aircraft to your DJI account. For more details, please check this demo's tutorial.
        DJISDKManager.userAccountManager().logIntoDJIUserAccount(withAuthorizationRequired: false) {(state: DJIUserAccountState, error: Error?) in
            if let error = error {
                DemoUtility.showResult(result: NSString.init(format: "Login failed: %@", error.localizedDescription))
            }
        }
    }
    
    func updateStatusBasedOn(product:DJIBaseProduct?) {
        self.connectStatusLabel.text = NSLocalizedString("Status: Product Connected", comment: "")
        if let product = product {
            self.modelNameLabel.text = NSString.init(format: "Model: %@", product.model!) as String
            self.modelNameLabel.isHidden = false
        } else {
            //TODO: use localized string
            self.connectStatusLabel.text = "Status: Product Not Connected"
            self.modelNameLabel.text = "Model Unknown"
        }
    }
    
    func appRegisteredWithError(_ error: Error?) {
        if let error = error {
            DemoUtility.showResult(result: NSString.init(format: "Registration Error %@", error.localizedDescription))
        } else {
            DemoUtility.showResult(result: "Registration Success")
            DJISDKManager.startConnectionToProduct()
        }
    }
    
    func didUpdateDatabaseDownloadProgress(_ progress: Progress) {
        print("Never called...")
    }
}
