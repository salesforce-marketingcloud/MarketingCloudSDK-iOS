//
//  ViewController.swift
//  LearningApp
//
//  Created by Brian Criscuolo on 6/4/19.
//  Copyright © 2019 Salesforce. All rights reserved.
//

import UIKit
import MarketingCloudSDK
import SafariServices
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    var locationUpdateObserver: NSObjectProtocol?

    deinit {
        NotificationCenter.default.removeObserver(locationUpdateObserver as Any)
        locationUpdateObserver = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "MobilePush SDK LearningApp"
        
        locationLabel.preferredMaxLayoutWidth = self.view.bounds.size.width;
        locationLabel.text = "Location not yet updated";
        
        if locationUpdateObserver == nil {
            locationUpdateObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.SFMCLocationDidReceiveLocationUpdate, object: nil, queue: OperationQueue.main) {(_ note: Notification) -> Void in
                let location = note.userInfo?["lastLocation"] as! CLLocation
                self.updateLocationLabel(location: location.description)
            }
        }
    }
    
    func updateLocationLabel(location: String) {
        if MarketingCloudSDK.sharedInstance().sfmc_watchingLocation() {
            guard let _ = MarketingCloudSDK.sharedInstance().sfmc_lastKnownLocation() else { locationLabel.text = "Not watching location"
                return
                }
            locationLabel.text = String(format: "Watching location - current location:\n %@", location)
        }
        else {
            locationLabel.text = "Not watching location"
        }
    }
    
    @IBAction func showDocs(_ sender: Any) {
        if let url = URL.init(string: "https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/") {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: false)
            present(vc, animated: true)
        }
    }

    @IBAction func setRegistrationValues(_ sender: Any) {
        MarketingCloudSDK.sharedInstance().sfmc_setContactKey("yourusername@example.com")
        MarketingCloudSDK.sharedInstance().sfmc_setAttributeNamed("LastName", value: "Smith")
        MarketingCloudSDK.sharedInstance().sfmc_addTag("Camping")
    }

}

