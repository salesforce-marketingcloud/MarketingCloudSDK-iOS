//
//  InboxMessageTableViewCell.swift
//  LearningAppBundle
//
//  Copyright © 2026 Salesforce. All rights reserved.
//

import UIKit
import InboxFeatureSDK

final class InboxMessageTableViewCell: UITableViewCell {

    static let reuseIdentifier = "InboxMessageCell"

    private let unreadIndicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 4
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14)
        if #available(iOS 13.0, *) {
            label.textColor = .secondaryLabel
        } else {
            label.textColor = .gray
        }
        return label
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14)
        if #available(iOS 13.0, *) {
            label.textColor = .secondaryLabel
        } else {
            label.textColor = .gray
        }
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        if #available(iOS 13.0, *) {
            label.textColor = .tertiaryLabel
        } else {
            label.textColor = .lightGray
        }
        label.textAlignment = .left
        return label
    }()

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        nil
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        bodyLabel.text = nil
        dateLabel.text = nil
        unreadIndicator.isHidden = false
    }

    func configure(with message: InboxMessage) {
        let title = firstNonEmptyValue([message.subject?.text]) ?? "No subject"

        let subtitle = firstNonEmptyValue([message.subtitle?.text])

        let body = firstNonEmptyValue([message.message?.text])

        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 16, weight: message.read ? .regular : .semibold)
        if #available(iOS 13.0, *) {
            titleLabel.textColor = message.read ? .secondaryLabel : .label
        } else {
            titleLabel.textColor = message.read ? .gray : .black
        }

        subtitleLabel.text = subtitle
        subtitleLabel.isHidden = subtitle == nil

        bodyLabel.text = body
        bodyLabel.isHidden = bodyLabel.text == nil

        dateLabel.text = message.sendDate.map(Self.dateFormatter.string(from:))
        unreadIndicator.isHidden = message.read
    }

    private func setupView() {
        accessoryType = .disclosureIndicator

        let textStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, bodyLabel, dateLabel])
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.axis = .vertical
        textStack.spacing = 4

        contentView.addSubview(unreadIndicator)
        contentView.addSubview(textStack)

        NSLayoutConstraint.activate([
            unreadIndicator.widthAnchor.constraint(equalToConstant: 8),
            unreadIndicator.heightAnchor.constraint(equalToConstant: 8),
            unreadIndicator.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            unreadIndicator.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),

            textStack.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 4),
            textStack.leadingAnchor.constraint(equalTo: unreadIndicator.trailingAnchor, constant: 8),
            textStack.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            textStack.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -4),
        ])
    }

    private func firstNonEmptyValue(_ values: [String?]) -> String? {
        values.compactMap { value in
            guard let value, !value.isEmpty else { return nil }
            return value
        }.first
    }
}
