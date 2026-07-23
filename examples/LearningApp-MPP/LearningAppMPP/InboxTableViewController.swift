//
//  InboxTableViewController.swift
//  LearningApp
//
//  Created by Brian Criscuolo on 6/5/19.
//  Copyright © 2019 Salesforce. All rights reserved.
//

import UIKit
import MarketingCloudSDK

class InboxTableViewController: UITableViewController {
    
    private var dataSourceArray = [[String: Any]]()
    private var inboxRefreshObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Inbox"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(done)
        )
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        // Setup refresh control
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        inboxRefreshObserver = NotificationCenter.default.addObserver(
            forName: NSNotification.Name.SFMCInboxMessagesRefreshComplete,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.refreshControl?.endRefreshing()
            self?.reloadData()
        }
        
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    deinit {
        if let observer = inboxRefreshObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    @objc private func done() {
        dismiss(animated: true)
    }
    
    @objc private func refresh() {
        MarketingCloudSdk.requestSdk { [weak self] mp in
            if mp?.refreshMessages() == false {
                DispatchQueue.main.async {
                    self?.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    private func reloadData() {
        MarketingCloudSdk.requestSdk { [weak self] mp in
            if let inboxArray = mp?.getAllMessages() as? [[String: Any]] {
                self?.dataSourceArray = inboxArray.sorted {
                    guard let date1 = $0["sendDateUtc"] as? Date,
                          let date2 = $1["sendDateUtc"] as? Date else {
                        return true
                    }
                    return date1 > date2
                }
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.title = "Inbox (\(self?.dataSourceArray.count ?? 0))"
                }
            }
        }
    }
    
    // MARK: - Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InboxCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "InboxCell")
        let inboxMessage = dataSourceArray[indexPath.row]
        
        var messageTitle = ""
        if let subject = inboxMessage["subject"] as? String {
            messageTitle = subject
        } else if let message = inboxMessage["inboxMessage"] as? String {
            messageTitle = message
        } else if let title = inboxMessage["title"] as? String {
            messageTitle = title
        }
        
        cell.textLabel?.text = messageTitle
        cell.textLabel?.numberOfLines = 2
        cell.accessoryType = .disclosureIndicator
        
        // Set detail text to show send date
        if let sendDateUtc = inboxMessage["sendDateUtc"] as? Date {
            cell.detailTextLabel?.text = sendDateUtc.description
        } else {
            cell.detailTextLabel?.text = nil
        }
        
        if inboxMessage["read"] as? Bool == true {
            cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
        } else {
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let inboxMessage = dataSourceArray[indexPath.row]
        
        // Track analytics
        MarketingCloudSdk.requestSdk { mp in
            mp?.trackMessageOpened(inboxMessage)
            _ = mp?.markMessageRead(inboxMessage)
        }
        
        // Open URL if available
        if let urlString = inboxMessage["url"] as? String,
           !urlString.isEmpty,
           let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
        
        reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let inboxMessage = dataSourceArray[indexPath.row]
            
            MarketingCloudSdk.requestSdk { [weak self] mp in
                _ = mp?.markMessageDeleted(inboxMessage)
                DispatchQueue.main.async {
                    self?.reloadData()
                }
            }
        }
    }
}
