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
    var sdkInitCompleteObserver: NSObjectProtocol?
    @IBOutlet weak var analyticsToggle: UISwitch!
    @IBOutlet weak var piAnalyticsToggle: UISwitch!
    @IBOutlet weak var locationToggle: UISwitch!
    @IBOutlet weak var inboxToggle: UISwitch!
    
    deinit {
        NotificationCenter.default.removeObserver(locationUpdateObserver as Any)
        NotificationCenter.default.removeObserver(sdkInitCompleteObserver as Any)
        locationUpdateObserver = nil
        sdkInitCompleteObserver = nil
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
        
        
        SFMCSdk.requestPushSdk { mp in
            DispatchQueue.main.async {
                self.analyticsToggle.setOn(mp.isAnalyticsEnabled(), animated: false)
                self.piAnalyticsToggle.setOn(mp.isPiAnalyticsEnabled(), animated: false)
                self.locationToggle.setOn(mp.isLocationEnabled(), animated: false)
                self.inboxToggle.setOn(mp.isInboxEnabled(), animated: false)
            }
        }
        
        // Track a custom event
        //
        // These events can be used to orchestrate journeys or
        // trigger in-app messages based on real-time user behavior
        guard let customEvent = CustomEvent(name: "OnViewControllerLoad", attributes: ["learning": "fun"]) else {
            return
        }
        
        SFMCSdk.track(event: customEvent)
    }
    
    func updateLocationLabel(location: String) {
        SFMCSdk.requestPushSdk { [weak self] mp in
            DispatchQueue.main.async {
                if mp.watchingLocation() {
                    guard let _ = mp.lastKnownLocation() else {
                        self?.locationLabel.text = "Not watching location"
                        return
                    }
                    self?.locationLabel.text = String(format: "Watching location - current location:\n %@", location)
                } else {
                    self?.locationLabel.text = "Not watching location"
                }
            }
        }
    }
    
    @IBAction func showDocs(_ sender: Any) {
        if let url = URL.init(string: "https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = false
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }

    @IBAction func setRegistrationValues(_ sender: Any) {
        SFMCSdk.requestPushSdk { mp in
            SFMCSdk.identity.setProfileId("yourusername@example.com")
            SFMCSdk.identity.setProfileAttributes(["LastName": "Smith"])
            let isTagAddedSuccessfully = mp.addTag("Camping")
            if(!isTagAddedSuccessfully) {
                debugPrint("setRegistrationValues: Tag not added successfully!")
            }
        }
    }
    
    @IBAction func piToggleChanged(_ sender: UISwitch) {
        SFMCSdk.requestPushSdk { mp in
            mp.setPiAnalyticsEnabled(sender.isOn)
        }
    }
    
    @IBAction func analyticsToggleChanged(_ sender: UISwitch) {
        SFMCSdk.requestPushSdk { mp in
            mp.setAnalyticsEnabled(sender.isOn)
        }
    }
    
    @IBAction func locationToggleChanged(_ sender: UISwitch) {
        SFMCSdk.requestPushSdk { mp in
            mp.setLocationEnabled(sender.isOn)
        }
    }
    
    @IBAction func inboxToggleChanged(_ sender: UISwitch) {
        SFMCSdk.requestPushSdk { mp in
            mp.setInboxEnabled(sender.isOn)
        }
    }
}

