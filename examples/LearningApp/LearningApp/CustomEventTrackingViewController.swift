//
//  CustomEventTrackingViewController.swift
//  LearningApp
//
//  Copyright © 2025 Salesforce. All rights reserved.
//

import UIKit
import SFMCSDK

// MARK: - Custom Event Model

struct SavedCustomEvent: Codable {
    let id: String
    let name: String
    let attributes: [String: String]
    
    init(id: String = UUID().uuidString, name: String, attributes: [String: String] = [:]) {
        self.id = id
        self.name = name
        self.attributes = attributes
    }
}

// MARK: - Custom Event Storage

class CustomEventStorage {
    static let shared = CustomEventStorage()
    private let key = "SavedCustomEvents"
    
    func save(_ events: [SavedCustomEvent]) {
        if let encoded = try? JSONEncoder().encode(events) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func load() -> [SavedCustomEvent] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let events = try? JSONDecoder().decode([SavedCustomEvent].self, from: data) else {
            return []
        }
        return events
    }
}

// MARK: - Custom Event Tracking View Controller

class CustomEventTrackingViewController: UIViewController {
    
    // MARK: - Properties
    
    private var tableView: UITableView!
    private var savedEvents: [SavedCustomEvent] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Track Custom Event"
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupTableView()
        loadSavedEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSavedEvents()
    }
    
    // MARK: - Setup
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(createNewEvent)
        )
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SubtitleCell.self, forCellReuseIdentifier: "SubtitleCell")
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadSavedEvents() {
        savedEvents = CustomEventStorage.shared.load()
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @objc private func createNewEvent() {
        let vc = CustomEventViewController()
        vc.onSave = { [weak self] event in
            self?.savedEvents.append(event)
            CustomEventStorage.shared.save(self?.savedEvents ?? [])
            self?.loadSavedEvents()
        }
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    private func editEvent(at index: Int) {
        let event = savedEvents[index]
        let vc = CustomEventViewController(event: event)
        vc.onSave = { [weak self] updatedEvent in
            self?.savedEvents[index] = updatedEvent
            CustomEventStorage.shared.save(self?.savedEvents ?? [])
            self?.loadSavedEvents()
        }
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    private func trackEvent(_ event: SavedCustomEvent) {
        guard let customEvent = CustomEvent(name: event.name, attributes: event.attributes) else {
            showAlert(title: "Error", message: "Failed to create event")
            return
        }
        
        SFMCSdk.track(event: customEvent)
        
        let attributeInfo = event.attributes.isEmpty ? "" : " with \(event.attributes.count) attribute\(event.attributes.count == 1 ? "" : "s")"
        showAlert(title: "Event Tracked", message: "Successfully tracked '\(event.name)'\(attributeInfo)")
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension CustomEventTrackingViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubtitleCell", for: indexPath) as? SubtitleCell else {
            return UITableViewCell()
        }
        
        let event = savedEvents[indexPath.row]
        let attributeCount = event.attributes.count
        let subtitle = attributeCount == 0 ? "Tap to track" : "\(attributeCount) attribute\(attributeCount == 1 ? "" : "s") • Tap to track"
        
        cell.configure(title: event.name, subtitle: subtitle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return savedEvents.isEmpty ? nil : "Saved Events"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if savedEvents.isEmpty {
            return "No saved events. Tap '+' to create custom events for quick tracking."
        }
        return "Tap an event to track it. Swipe right to edit. Swipe left to delete."
    }
}

// MARK: - UITableViewDelegate

extension CustomEventTrackingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        trackEvent(savedEvents[indexPath.row])
    }
    
    // Swipe right to edit
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] _, _, completionHandler in
            self?.editEvent(at: indexPath.row)
            completionHandler(true)
        }
        editAction.backgroundColor = UIColor(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0)
        
        let configuration = UISwipeActionsConfiguration(actions: [editAction])
        return configuration
    }
    
    // Swipe left to delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completionHandler in
            self?.savedEvents.remove(at: indexPath.row)
            CustomEventStorage.shared.save(self?.savedEvents ?? [])
            self?.tableView.reloadData()
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
