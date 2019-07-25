//
//  RegistrationViewController.swift
//  LearningApp
//
//  Created by Brian Criscuolo on 6/5/19.
//  Copyright © 2019 Salesforce. All rights reserved.
//

import UIKit
import MarketingCloudSDK

class RegistrationViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(done))
        self.navigationItem.title = "Registration"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var sdkStateJSON = MarketingCloudSDK.sharedInstance().sfmc_getSDKState() ?? "{}"
        guard let data = sdkStateJSON.data(using: .utf8) else { self.textView.text = sdkStateJSON
            return
        }
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject] else { self.textView.text = sdkStateJSON
                return
            }
            guard let general = json["MarketingCloudSDK General Information"] else { self.textView.text = sdkStateJSON
                return
            }
            guard let registration = general["Registration Details"] else { self.textView.text = sdkStateJSON
                return
            }
            guard let registrationData = try? JSONSerialization.data(withJSONObject: registration!, options: .prettyPrinted) else { self.textView.text = sdkStateJSON
                return
            }
            sdkStateJSON = String(data: registrationData, encoding: .utf8) ?? "No Registration Data"
        } catch {
            print("Something went wrong")
        }
        
        self.textView.text = sdkStateJSON
    }
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
