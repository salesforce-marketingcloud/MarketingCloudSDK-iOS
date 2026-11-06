//
//  InboxTableViewController.swift
//  LearningAppBundle
//
//  Created by Brian Criscuolo on 6/5/19.
//  Copyright © 2019 Salesforce. All rights reserved.
//

import SafariServices
import UIKit
import SFMCSDK
import InboxFeatureSDK

final class InboxTableViewController: UITableViewController {

    private enum MessageFilter: Int, CaseIterable {
        case all
        case unread
        case read
        case deleted

        var title: String {
            switch self {
            case .all: return "All"
            case .unread: return "Unread"
            case .read: return "Read"
            case .deleted: return "Deleted"
            }
        }

        var emptyStateText: String {
            switch self {
            case .all: return "No inbox messages."
            case .unread: return "No unread messages."
            case .read: return "No read messages."
            case .deleted: return "No deleted messages."
            }
        }
    }

    private var dataSourceArray = [InboxMessage]()

    private lazy var moreActionsButtonItem: UIBarButtonItem = {
        if #available(iOS 13.0, *) {
            return UIBarButtonItem(
                image: UIImage(systemName: "ellipsis.circle"),
                style: .plain,
                target: self,
                action: #selector(showBulkActions)
            )
        }
        return UIBarButtonItem(
            title: "More",
            style: .plain,
            target: self,
            action: #selector(showBulkActions)
        )
    }()

    private lazy var filterControl: UISegmentedControl = {
        let control = UISegmentedControl(items: MessageFilter.allCases.map { $0.title })
        control.selectedSegmentIndex = MessageFilter.all.rawValue
        control.addTarget(self, action: #selector(filterChanged), for: .valueChanged)
        return control
    }()

    private var selectedFilter: MessageFilter {
        MessageFilter(rawValue: filterControl.selectedSegmentIndex) ?? .all
    }

    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 0
        label.text = "No inbox messages."
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Inbox"

        navigationItem.rightBarButtonItem = moreActionsButtonItem

        tableView.register(
            InboxMessageTableViewCell.self,
            forCellReuseIdentifier: InboxMessageTableViewCell.reuseIdentifier
        )
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72

        setupFilterControl()

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showMessageDetails(_:)))
        tableView.addGestureRecognizer(longPress)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }

    @objc private func refresh() {
        InboxFeature.requestSdk { [weak self] inboxSdk in
            guard let inboxSdk else {
                DispatchQueue.main.async {
                    self?.refreshControl?.endRefreshing()
                }
                return
            }
            inboxSdk.refreshMessages { [weak self] _, _ in
                self?.refreshControl?.endRefreshing()
                self?.reloadData()
            }
        }
    }

    @objc private func filterChanged() {
        reloadData()
    }

    private func setupFilterControl() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 52))
        filterControl.frame = CGRect(x: 16, y: 10, width: headerView.bounds.width - 32, height: 32)
        filterControl.autoresizingMask = [.flexibleWidth]
        headerView.addSubview(filterControl)
        tableView.tableHeaderView = headerView
    }

    private func reloadData() {
        let filter = selectedFilter

        InboxFeature.requestSdk { [weak self] inboxSdk in
            let inboxArray: [InboxMessage]
            switch filter {
            case .all:
                inboxArray = inboxSdk?.getAllMessages() ?? []
            case .unread:
                inboxArray = inboxSdk?.getUnreadMessages() ?? []
            case .read:
                inboxArray = inboxSdk?.getReadMessages() ?? []
            case .deleted:
                inboxArray = inboxSdk?.getDeletedMessages() ?? []
            }

            let sortedMessages = inboxArray.sorted {
                ($0.sendDate ?? .distantPast) > ($1.sendDate ?? .distantPast)
            }

            DispatchQueue.main.async {
                guard self?.filterControl.selectedSegmentIndex == filter.rawValue else { return }

                self?.dataSourceArray = sortedMessages
                self?.tableView.reloadData()
                self?.emptyStateLabel.text = filter.emptyStateText
                self?.tableView.backgroundView = sortedMessages.isEmpty ? self?.emptyStateLabel : nil
                self?.title = "Inbox (\(sortedMessages.count))"
            }
        }
    }

    @objc private func showBulkActions() {
        InboxFeature.requestSdk { [weak self] inboxSdk in
            let unreadCount = inboxSdk?.getUnreadMessagesCount() ?? 0
            let activeCount = inboxSdk?.getAllMessagesCount() ?? 0

            DispatchQueue.main.async {
                guard let self else { return }

                let actionSheet = UIAlertController(
                    title: "Inbox Actions",
                    message: "These actions apply to all Inbox messages.",
                    preferredStyle: .actionSheet
                )

                let markAllRead = UIAlertAction(title: "Mark All as Read", style: .default) { [weak self] _ in
                    self?.markAllMessagesRead()
                }
                markAllRead.isEnabled = unreadCount > 0
                actionSheet.addAction(markAllRead)

                let deleteAll = UIAlertAction(title: "Delete All", style: .destructive) { [weak self] _ in
                    self?.deleteAllMessages()
                }
                deleteAll.isEnabled = activeCount > 0
                actionSheet.addAction(deleteAll)

                actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                actionSheet.popoverPresentationController?.barButtonItem = self.moreActionsButtonItem
                self.present(actionSheet, animated: true)
            }
        }
    }

    private func markAllMessagesRead() {
        InboxFeature.requestSdk { [weak self] inboxSdk in
            let succeeded = inboxSdk?.markAllMessagesRead() == true
            DispatchQueue.main.async {
                self?.completeBulkAction(
                    succeeded: succeeded,
                    failureMessage: "Messages could not be marked as read."
                )
            }
        }
    }

    private func deleteAllMessages() {
        InboxFeature.requestSdk { [weak self] inboxSdk in
            let succeeded = inboxSdk?.markAllMessagesDeleted() == true
            DispatchQueue.main.async {
                self?.completeBulkAction(
                    succeeded: succeeded,
                    failureMessage: "Messages could not be deleted."
                )
            }
        }
    }

    private func completeBulkAction(succeeded: Bool, failureMessage: String) {
        reloadData()

        guard !succeeded else { return }
        let alert = UIAlertController(title: "Action Incomplete", message: failureMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return selectedFilter != .deleted
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: InboxMessageTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? InboxMessageTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(with: dataSourceArray[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let inboxMessage = dataSourceArray[indexPath.row]
        let url = messageActionURL(for: inboxMessage)

        InboxFeature.requestSdk { [weak self] inboxSdk in
            inboxSdk?.trackMessageOpenEvent(inboxMessage)
            _ = inboxSdk?.markMessageRead(message: inboxMessage)

            if url != nil {
                let interaction = InboxMessageInteraction(type: .cta, id: nil)
                inboxSdk?.trackMessageInteractionEvent(inboxMessage, interaction: interaction)
            }

            DispatchQueue.main.async {
                guard let self else { return }

                if let url {
                    self.open(url)
                } else {
                    self.presentMessageDetails(inboxMessage)
                }
                self.reloadData()
            }
        }
    }

    @objc private func showMessageDetails(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }

        let location = gesture.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: location),
              dataSourceArray.indices.contains(indexPath.row) else {
            return
        }

        let inboxMessage = dataSourceArray[indexPath.row]
        presentMessageDetails(inboxMessage)
    }

    private func presentMessageDetails(_ inboxMessage: InboxMessage) {
        let details = InboxMessageDetailsViewController(message: inboxMessage)
        details.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissMessageDetails)
        )

        let navigationController = UINavigationController(rootViewController: details)
        navigationController.modalPresentationStyle = .pageSheet
        present(navigationController, animated: true)
    }

    @objc private func dismissMessageDetails() {
        dismiss(animated: true)
    }

    private func messageActionURL(for message: InboxMessage) -> URL? {
        let actionType = message.action.type.trimmingCharacters(in: .whitespacesAndNewlines)
        let urlActionTypes = [InboxActionType.webUrl, InboxActionType.landingPage, InboxActionType.appUrl]

        guard urlActionTypes.contains(actionType),
              let value = message.action.value?.trimmingCharacters(in: .whitespacesAndNewlines),
              !value.isEmpty,
              let url = URL(string: value),
              url.scheme != nil else {
            return nil
        }
        return url
    }

    private func open(_ url: URL) {
        let scheme = url.scheme?.lowercased()
        if scheme == "http" || scheme == "https" {
            present(SFSafariViewController(url: url), animated: true)
        } else if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

    override func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        guard selectedFilter != .deleted,
              dataSourceArray.indices.contains(indexPath.row),
              !dataSourceArray[indexPath.row].read else {
            return nil
        }

        let message = dataSourceArray[indexPath.row]
        let readAction = UIContextualAction(style: .normal, title: "Read") { [weak self] _, _, completion in
            InboxFeature.requestSdk { inboxSdk in
                let succeeded = inboxSdk?.markMessageRead(id: message.messageId) == true
                DispatchQueue.main.async {
                    if succeeded {
                        self?.reloadData()
                    }
                    completion(succeeded)
                }
            }
        }
        readAction.backgroundColor = .systemBlue

        let configuration = UISwipeActionsConfiguration(actions: [readAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let inboxMessage = dataSourceArray[indexPath.row]

            InboxFeature.requestSdk { [weak self] inboxSdk in
                _ = inboxSdk?.markMessageDeleted(id: inboxMessage.messageId)
                DispatchQueue.main.async {
                    self?.reloadData()
                }
            }
        }
    }
}
