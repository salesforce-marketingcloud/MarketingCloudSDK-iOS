//
//  RegistrationViewController.swift
//  LearningApp
//
//  Created by Brian Criscuolo on 6/5/19.
//  Copyright © 2019 Salesforce. All rights reserved.
//

import UIKit
import SFMCSDK
import MarketingCloudSDK

class RegistrationViewController: UIViewController {
    
    // MARK: - Properties
    
    private var tableView: UITableView!
    
    private enum Section: Int, CaseIterable {
        case identityInformation
        case customAttributes
        case actions
        
        var title: String? {
            switch self {
            case .identityInformation: return "Identity Information"
            case .customAttributes: return "Custom Attributes"
            case .actions: return nil
            }
        }
        
        var footer: String? {
            switch self {
            case .identityInformation: return "Configure user identity and party identification"
            case .customAttributes: return "Add custom key-value attributes"
            case .actions: return nil
            }
        }
    }
    
    // Data storage
    private var profileId: String = ""
    private var partyIdNumber: String = ""
    private var partyIdName: String = ""
    private var partyIdType: String = ""
    private var customAttributes: [(key: String, value: String)] = []
    
    // Save button state
    private var saveButtonCell: UITableViewCell?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Set Identity"
        view.backgroundColor = .groupTableViewBackground
        
        setupTableView()
        loadCurrentValues()
        setupKeyboardObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        tableView.contentInset = contentInset
        tableView.scrollIndicatorInsets = contentInset
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset = .zero
        tableView.scrollIndicatorInsets = .zero
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .interactive
        
        // Register cells
        tableView.register(TextFieldCell.self, forCellReuseIdentifier: "TextFieldCell")
        tableView.register(AttributeCell.self, forCellReuseIdentifier: "AttributeCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Keyboard dismiss
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Load Current Values
    
    private func loadCurrentValues() {
        let identity = SFMCSdk.identity.get()
        
        profileId = identity?.profileId ?? ""
        partyIdNumber = identity?.partyIdentificationNumber ?? ""
        partyIdName = identity?.partyIdentificationName ?? ""
        partyIdType = identity?.partyIdentificationType ?? ""
        
        if let attributes = identity?.attributes {
            customAttributes = attributes
                .filter { !$0.value.isEmpty }
                .sorted(by: { $0.key < $1.key })
                .map { ($0.key, $0.value) }
        }
        
        tableView.reloadData()
        updateSaveButtonState()
    }
    
    // MARK: - Validation
    
    private func hasAnyValue() -> Bool {
        if !profileId.isEmpty { return true }
        if !partyIdNumber.isEmpty { return true }
        if !partyIdName.isEmpty { return true }
        if !partyIdType.isEmpty { return true }
        
        // Check custom attributes
        for (key, value) in customAttributes {
            if !key.isEmpty && !value.isEmpty {
                return true
            }
        }
        return false
    }
    
    private func updateSaveButtonState() {
        guard let buttonCell = saveButtonCell else { return }
        
        let hasValue = hasAnyValue()
        buttonCell.isUserInteractionEnabled = hasValue
        
        if hasValue {
            buttonCell.textLabel?.textColor = .white
            buttonCell.backgroundColor = UIColor(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0)
        } else {
            if #available(iOS 13.0, *) {
                buttonCell.textLabel?.textColor = UIColor.label.withAlphaComponent(0.3)
                buttonCell.backgroundColor = UIColor.systemGray5
            } else {
                buttonCell.textLabel?.textColor = UIColor.lightGray
                buttonCell.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func addAttributeTapped() {
        customAttributes.append(("", ""))
        
        let indexPath = IndexPath(row: customAttributes.count - 1, section: Section.customAttributes.rawValue)
        tableView.insertRows(at: [indexPath], with: .automatic)
        updateSaveButtonState()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            if let cell = self.tableView.cellForRow(at: indexPath) as? AttributeCell {
                cell.focusKeyField()
            }
        }
    }
    
    private func deleteAttribute(at index: Int) {
        customAttributes.remove(at: index)
        let indexPath = IndexPath(row: index, section: Section.customAttributes.rawValue)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        updateSaveButtonState()
    }
    
    private func saveRegistration() {
        guard hasAnyValue() else { return }
        
        dismissKeyboard()
        
        // Build attributes dictionary
        var attributesDict: [String: String] = [:]
        for (key, value) in customAttributes {
            if !key.isEmpty && !value.isEmpty {
                attributesDict[key] = value
            }
        }
        let existingAttributes = SFMCSdk.identity.get()?.attributes ?? [:]
        let keysToDelete = existingAttributes.keys.filter { !attributesDict.keys.contains($0) }
        
        SFMCSdk.identity.edit { [self] model in
            model.profileId = self.profileId.isEmpty ? "" : self.profileId
            model.partyIdentificationNumber = self.partyIdNumber.isEmpty ? nil : self.partyIdNumber
            model.partyIdentificationName = self.partyIdName.isEmpty ? nil : self.partyIdName
            model.partyIdentificationType = self.partyIdType.isEmpty ? nil : self.partyIdType
            
            if !keysToDelete.isEmpty {
                model.clearAttributes(keys: Array(keysToDelete))
            }
            if !attributesDict.isEmpty {
                model.addAttributes(attributes: attributesDict)
            }
            
            return model
        }
        
        // Show success
        let alert = UIAlertController(title: "Saved", message: "Registration values saved successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension RegistrationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sec = Section(rawValue: section) else { return 0 }
        
        switch sec {
        case .identityInformation: return 4
        case .customAttributes: return customAttributes.count + 1
        case .actions: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .identityInformation:
            return configureIdentityCell(for: indexPath)
            
        case .customAttributes:
            return configureAttributeCell(for: indexPath)
            
        case .actions:
            return configureActionCell(for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section(rawValue: section)?.title
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return Section(rawValue: section)?.footer
    }
    
    // MARK: - Cell Configuration
    
    private func configureIdentityCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as? TextFieldCell else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0:
            cell.configure(placeholder: "Profile ID", text: profileId) { [weak self] newValue in
                self?.profileId = newValue
                self?.updateSaveButtonState()
            }
        case 1:
            cell.configure(placeholder: "Party Identification Number", text: partyIdNumber) { [weak self] newValue in
                self?.partyIdNumber = newValue
                self?.updateSaveButtonState()
            }
        case 2:
            cell.configure(placeholder: "Party Identification Name", text: partyIdName) { [weak self] newValue in
                self?.partyIdName = newValue
                self?.updateSaveButtonState()
            }
        case 3:
            cell.configure(placeholder: "Party Identification Type", text: partyIdType) { [weak self] newValue in
                self?.partyIdType = newValue
                self?.updateSaveButtonState()
            }
        default:
            break
        }
        
        return cell
    }
    
    private func configureAttributeCell(for indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == customAttributes.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
            cell.textLabel?.text = "+ Add Attribute"
            cell.textLabel?.textColor = .systemBlue
            cell.textLabel?.textAlignment = .center
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AttributeCell", for: indexPath) as? AttributeCell else {
            return UITableViewCell()
        }
        
        let attribute = customAttributes[indexPath.row]
        
        cell.configure(
            key: attribute.key,
            value: attribute.value,
            onKeyChange: { [weak self, weak cell] newKey in
                guard let self = self,
                      let cell = cell,
                      let currentIndexPath = self.tableView.indexPath(for: cell),
                      currentIndexPath.row < self.customAttributes.count else { return }
                self.customAttributes[currentIndexPath.row].key = newKey
                self.updateSaveButtonState()
            },
            onValueChange: { [weak self, weak cell] newValue in
                guard let self = self,
                      let cell = cell,
                      let currentIndexPath = self.tableView.indexPath(for: cell),
                      currentIndexPath.row < self.customAttributes.count else { return }
                self.customAttributes[currentIndexPath.row].value = newValue
                self.updateSaveButtonState()
            },
            onDelete: { [weak self, weak cell] in
                guard let self = self,
                      let cell = cell,
                      let currentIndexPath = self.tableView.indexPath(for: cell),
                      currentIndexPath.row < self.customAttributes.count else { return }
                self.deleteAttribute(at: currentIndexPath.row)
            }
        )
        
        return cell
    }
    
    private func configureActionCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        cell.textLabel?.text = "Save Registration Values"
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        saveButtonCell = cell
        updateSaveButtonState()
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension RegistrationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let section = Section(rawValue: indexPath.section) else { return }
        
        if section == .customAttributes && indexPath.row == customAttributes.count {
            addAttributeTapped()
        } else if section == .actions {
            saveRegistration()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
