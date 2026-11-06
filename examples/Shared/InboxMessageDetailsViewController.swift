//
//  InboxMessageDetailsViewController.swift
//  LearningAppBundle
//
//  Copyright © 2026 Salesforce. All rights reserved.
//

import UIKit
import InboxFeatureSDK
import SFMCSDK

final class InboxMessageDetailsViewController: UIViewController {

    private let message: InboxMessage

    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.alwaysBounceVertical = true
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)
        return textView
    }()

    private static let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()

    init(message: InboxMessage) {
        self.message = message
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Message Properties"

        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }

        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        textView.attributedText = messageDetails()
    }

    private func messageDetails() -> NSAttributedString {
        let text = NSMutableAttributedString()

        text.append(NSAttributedString(
            string: "Diagnostic view of public InboxMessage properties; presentation is app-defined.\n",
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .footnote),
                .foregroundColor: secondaryTextColor
            ]
        ))

        appendSection("Message", to: text)
        appendProperty("ID", value: message.messageId, to: text)
        appendProperty("Type", value: message.messageType.rawValue, to: text)
        appendProperty("Source", value: message.source, to: text)
        appendProperty("Audience", value: message.audienceType, to: text)
        appendProperty("Deleted", value: message.deleted, to: text)
        appendProperty("Start date", value: dateValue(message.startDate), to: text)
        appendProperty("End date", value: dateValue(message.endDate), to: text)
        appendProperty("Send date", value: dateValue(message.sendDate), to: text)

        appendSection("Content", to: text)
        appendProperty("Subject", value: message.subject?.text, to: text)
        appendProperty("Subtitle", value: message.subtitle?.text, to: text)
        appendProperty("Message", value: message.message?.text, to: text)
        appendProperty("Custom", value: message.custom, to: text)
        appendProperty("Custom keys", value: message.customKeys, to: text)
        appendProperty("Sound", value: message.sound, to: text)
        appendProperty("Notification message", value: message.notificationMessage, to: text)

        if !message.action.type.isEmpty || message.action.value != nil {
            appendSection("Action", to: text)
            appendProperty("Type", value: message.action.type, to: text)
            appendProperty("Value", value: message.action.value, to: text)
        }

        if let media = message.media,
           [media.url, media.altText, media.type, media.mimeType]
            .compactMap({ $0 })
            .contains(where: { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }) {
            appendSection("Media", to: text)
            appendProperty("URL", value: media.url, to: text)
            appendProperty("Alt text", value: media.altText, to: text)
            appendProperty("Type", value: media.type, to: text)
            appendProperty("MIME type", value: media.mimeType, to: text)
        }

        if let buttons = message.buttons, !buttons.isEmpty {
            appendSection("Buttons", to: text)
            for (position, button) in buttons.enumerated() {
                let details = [
                    "id=\(button.id)",
                    "index=\(button.index)",
                    "action=\(button.action.type)",
                    "value=\(button.action.value ?? "nil")"
                ].joined(separator: ", ")
                appendProperty("\(position + 1). \(button.text)", value: details, to: text)
            }
        }

        return text
    }

    private func appendSection(_ title: String, to text: NSMutableAttributedString) {
        let paragraph = NSMutableParagraphStyle()
        paragraph.paragraphSpacingBefore = 16
        paragraph.paragraphSpacing = 4

        text.append(NSAttributedString(
            string: "\(title)\n",
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .headline),
                .foregroundColor: primaryTextColor,
                .paragraphStyle: paragraph
            ]
        ))
    }

    private func appendProperty(_ title: String, value: Any?, to text: NSMutableAttributedString) {
        guard let value else { return }
        let displayValue = String(describing: value)
        guard !displayValue.isEmpty else { return }

        text.append(NSAttributedString(
            string: "\(title): ",
            attributes: [
                .font: UIFont.systemFont(ofSize: 14, weight: .semibold),
                .foregroundColor: primaryTextColor
            ]
        ))

        text.append(NSAttributedString(
            string: "\(displayValue)\n",
            attributes: [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: primaryTextColor
            ]
        ))
    }

    private func dateValue(_ date: Date?) -> String? {
        date.map(Self.dateFormatter.string(from:))
    }

    private var primaryTextColor: UIColor {
        if #available(iOS 13.0, *) {
            return .label
        }
        return .black
    }

    private var secondaryTextColor: UIColor {
        if #available(iOS 13.0, *) {
            return .secondaryLabel
        }
        return .gray
    }
}
