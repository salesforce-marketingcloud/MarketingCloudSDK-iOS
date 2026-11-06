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

    private enum Section: Int, CaseIterable {
        case savedEvents
        case eventActions

        var title: String? {
            switch self {
            case .savedEvents: return nil
            case .eventActions: return "Event Actions"
            }
        }
    }

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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")

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

    /// Presents an action sheet allowing the user to choose between standard track
    /// and send immediate (high-priority) for the selected event.
    private func showTrackOptions(for event: SavedCustomEvent) {
        let sheet = UIAlertController(
            title: "Track '\(event.name)'",
            message: "Choose how to send this event",
            preferredStyle: .actionSheet
        )

        sheet.addAction(UIAlertAction(title: "Track (Standard)", style: .default) { [weak self] _ in
            self?.trackEvent(event)
        })

        // SFMCSdk.sendImmediate(event:) converts the event to high-priority
        // and triggers an immediate flush so it is sent without waiting for
        // normal batching.
        sheet.addAction(UIAlertAction(title: "Send Immediate (High Priority)", style: .default) { [weak self] _ in
            self?.sendImmediateEvent(event)
        })

        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(sheet, animated: true)
    }

    /// Tracks the event using the standard SFMCSdk.track(event:) method.
    /// Events tracked this way have low priority and are batched per normal trigger rules.
    private func trackEvent(_ event: SavedCustomEvent) {
        guard let customEvent = CustomEvent(name: event.name, attributes: event.attributes) else {
            showAlert(title: "Error", message: "Failed to create event")
            return
        }

        SFMCSdk.track(event: customEvent)

        let attributeInfo = event.attributes.isEmpty ? "" : " with \(event.attributes.count) attribute\(event.attributes.count == 1 ? "" : "s")"
        showAlert(title: "Event Tracked", message: "Successfully tracked '\(event.name)'\(attributeInfo)\n\nPriority: Low (standard batching)")
    }

    /// Sends the event immediately using SFMCSdk.sendImmediate(event:).
    /// The SDK converts this to a high-priority CustomEvent and triggers an
    /// immediate flush so it is sent without waiting for normal batching.
    private func sendImmediateEvent(_ event: SavedCustomEvent) {
        guard let customEvent = CustomEvent(name: event.name, attributes: event.attributes) else {
            showAlert(title: "Error", message: "Failed to create event")
            return
        }

        SFMCSdk.sendImmediate(event: customEvent)

        let attributeInfo = event.attributes.isEmpty ? "" : " with \(event.attributes.count) attribute\(event.attributes.count == 1 ? "" : "s")"
        showAlert(title: "Event Sent Immediately", message: "Sent '\(event.name)'\(attributeInfo)\n\nPriority: High (immediate flush)")
    }

    /// Manually flushes all pending events in the SDK queue.
    /// This triggers all subscribing modules to send any batched events immediately.
    private func flushEvents() {
        SFMCSdk.flush()
        showAlert(title: "Events Flushed", message: "All pending events have been flushed.")
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
        return Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sec = Section(rawValue: section) else { return 0 }
        switch sec {
        case .savedEvents:
            return savedEvents.count
        case .eventActions:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }

        switch section {
        case .savedEvents:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubtitleCell", for: indexPath) as? SubtitleCell else {
                return UITableViewCell()
            }

            let event = savedEvents[indexPath.row]
            let attributeCount = event.attributes.count
            let subtitle = attributeCount == 0
                ? "Tap to track or send immediate"
                : "\(attributeCount) attribute\(attributeCount == 1 ? "" : "s") • Tap to track or send immediate"

            cell.configure(title: event.name, subtitle: subtitle)
            return cell

        case .eventActions:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubtitleCell", for: indexPath) as? SubtitleCell else {
                return UITableViewCell()
            }
            cell.configure(
                title: "Flush All Pending Events",
                subtitle: "Manually triggers SFMCSdk.flush() to send all batched events"
            )
            return cell
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sec = Section(rawValue: section) else { return nil }
        switch sec {
        case .savedEvents:
            return savedEvents.isEmpty ? nil : "Saved Events"
        case .eventActions:
            return sec.title
        }
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard let sec = Section(rawValue: section) else { return nil }
        switch sec {
        case .savedEvents:
            if savedEvents.isEmpty {
                return "No saved events. Tap '+' to create custom events for quick tracking."
            }
            return "Tap an event to choose: Track (standard/low priority) or Send Immediate (high priority). Swipe right to edit. Swipe left to delete."
        case .eventActions:
            return "Flush forces all subscribing SDK modules to send any queued events immediately, regardless of normal batching rules."
        }
    }
}

// MARK: - UITableViewDelegate

extension CustomEventTrackingViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let section = Section(rawValue: indexPath.section) else { return }

        switch section {
        case .savedEvents:
            showTrackOptions(for: savedEvents[indexPath.row])
        case .eventActions:
            flushEvents()
        }
    }

    // Swipe right to edit (saved events only)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard Section(rawValue: indexPath.section) == .savedEvents else { return nil }

        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] _, _, completionHandler in
            self?.editEvent(at: indexPath.row)
            completionHandler(true)
        }
        editAction.backgroundColor = UIColor(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0)

        let configuration = UISwipeActionsConfiguration(actions: [editAction])
        return configuration
    }

    // Swipe left to delete (saved events only)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard Section(rawValue: indexPath.section) == .savedEvents else { return nil }

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
