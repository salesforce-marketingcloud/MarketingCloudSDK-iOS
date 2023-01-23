//
//  InboxTableViewController.swift
//  LearningApp
//
//  Created by Brian Criscuolo on 6/5/19.
//  Copyright © 2019 Salesforce. All rights reserved.
//

import UIKit
import MarketingCloudSDK
import SafariServices

class InboxTableViewController: UITableViewController {

    var dataSourceArray = [[String:Any]]()
    var inboxRefreshObserver: NSObjectProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(done))
        navigationItem.title = "Inbox"

        refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        reloadData()
        
        navigationItem.rightBarButtonItem = editButtonItem
    }

    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(inboxRefreshObserver as Any)
        inboxRefreshObserver = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        if inboxRefreshObserver == nil {
            inboxRefreshObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.SFMCInboxMessagesRefreshComplete, object: nil, queue: OperationQueue.main) {(_ note: Notification) -> Void in
                self.refreshControl?.endRefreshing()
                self.reloadData()
            }
        }

        reloadData()
    }

    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    // This example refresh method, used by the refresh control, will call the SDK's sfmc_refreshMessages
    // method to fetch inbox messages from the server.
    @objc func refresh(_ sender: Any) {
        if SFMCSdk.mp.refreshMessages() == false {
            refreshControl?.endRefreshing()
        }
    }
    
    // This method will fetch already-downloaded messages from the SDK, sort by the sendDateUtc value
    // into the data source for this UITableViewController.
    func reloadData() {
        
        if let inboxArray = SFMCSdk.mp.getAllMessages() as? [[String : Any]] {
            dataSourceArray = inboxArray.sorted {
            
                if $0["sendDateUtc"] == nil {
                    return true
                }
                if $1["sendDateUtc"] == nil {
                    return true
                }

                let s1 = $0["sendDateUtc"] as! Date
                let s2 = $1["sendDateUtc"] as! Date
                
                return s1 < s2
            }
            tableView.reloadData()
            navigationItem.title = String(format: "Number of Messages: %d", dataSourceArray.count)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return dataSourceArray.count
        }
        else {
            return 0
        }
    }

    // This method illustrates populating a basic UITableViewCell based on the inbox message's
    // subject, sendDateUtc value and its read state.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InboxCell", for: indexPath)

        let inboxMessage = dataSourceArray[indexPath.row]
        if (inboxMessage["subject"] != nil) {
            let subject = inboxMessage["subject"] as! String
            cell.textLabel!.text = subject
        }
        if (inboxMessage["sendDateUtc"] != nil) {
            let sendDateUtc = inboxMessage["sendDateUtc"] as! Date
            cell.detailTextLabel!.text = sendDateUtc.description
        }
        
        if (inboxMessage["read"] as! Bool == true) {
            cell.textLabel!.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        }
        else {
            cell.textLabel!.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        }
        
        cell.accessoryType = .disclosureIndicator;
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let inboxMessage = dataSourceArray[indexPath.row]

        // In a basic inbox implementation, the application should call the methods below to ensure that
        // analytics are being tracked correctly and that the SDK and Marketing Cloud accurately reflect
        // the read state of the message.
        SFMCSdk.mp.trackMessageOpened(inboxMessage)
        SFMCSdk.mp.markMessageRead(inboxMessage)

        // If the inbox message has a URL, it would be appropriate to open the URL when the inbox item is selected.
        // This is a simple example using SFSafariViewController.
        let urlString = inboxMessage["url"] as! String
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: false)
            present(vc, animated: true)
        }        
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // If the inbox implementation allows for deleting messages, call the method in the SDK to reflect the deletion.
            let inboxMessage = dataSourceArray[indexPath.row]
            
            SFMCSdk.mp.markMessageDeleted(inboxMessage)
            
            // Then, reload the data in the data source and table view.
            reloadData()
        }
    }
}
