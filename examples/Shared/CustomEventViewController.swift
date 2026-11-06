//
//  CustomEventViewController.swift
//  LearningApp
//
//  Copyright © 2025 Salesforce. All rights reserved.
//

import UIKit

class CustomEventViewController: UIViewController {
    
    // MARK: - Properties
    
    var onSave: ((SavedCustomEvent) -> Void)?
    private var existingEvent: SavedCustomEvent?
    
    private var tableView: UITableView!
    private var eventName: String = ""
    private var attributes: [(key: String, value: String)] = []
    
    private enum Section: Int, CaseIterable {
        case eventName
        case attributes
        
        var title: String? {
            switch self {
            case .eventName: return "Event Name"
            case .attributes: return "Custom Attributes (Optional)"
            }
        }
    }
    
    // MARK: - Initializers
    
    init(event: SavedCustomEvent? = nil) {
        self.existingEvent = event
        super.init(nibName: nil, bundle: nil)
        
        if let event = event {
            self.eventName = event.name
            self.attributes = event.attributes.sorted(by: { $0.key < $1.key }).map { ($0.key, $0.value) }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = existingEvent == nil ? "Create Event" : "Edit Event"
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupTableView()
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
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelTapped)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(saveTapped)
        )
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .interactive
        
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
    }
    
    // MARK: - Actions
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func saveTapped() {
        view.endEditing(true)
        
        let trimmedName = eventName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else {
            showAlert(title: "Missing Event Name", message: "Please enter an event name")
            return
        }
        
        let attributesDict = Dictionary(uniqueKeysWithValues:
                                            attributes
            .filter { !$0.key.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .map { ($0.key.trimmingCharacters(in: .whitespacesAndNewlines),
                    $0.value.trimmingCharacters(in: .whitespacesAndNewlines)) }
        )
        
        let event = SavedCustomEvent(
            id: existingEvent?.id ?? UUID().uuidString,
            name: trimmedName,
            attributes: attributesDict
        )
        onSave?(event)
        dismiss(animated: true)
    }
    
    private func addAttribute() {
        attributes.append((key: "", value: ""))
        let indexPath = IndexPath(row: attributes.count - 1, section: Section.attributes.rawValue)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            if let cell = self?.tableView.cellForRow(at: indexPath) as? AttributeCell {
                cell.focusKeyField()
            }
        }
    }
    
    private func removeAttribute(at index: Int) {
        attributes.remove(at: index)
        let indexPath = IndexPath(row: index, section: Section.attributes.rawValue)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension CustomEventViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sec = Section(rawValue: section) else { return 0 }
        
        switch sec {
        case .eventName: return 1
        case .attributes: return attributes.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .eventName:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as? TextFieldCell else {
                return UITableViewCell()
            }
            cell.configure(placeholder: "e.g., ProductViewed", text: eventName) { [weak self] newText in
                self?.eventName = newText
            }
            return cell
        case .attributes:
            if indexPath.row == attributes.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
                cell.textLabel?.text = "+ Add Attribute"
                cell.textLabel?.textColor = .systemBlue
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "AttributeCell", for: indexPath) as? AttributeCell else {
                    return UITableViewCell()
                }
                
                let attribute = attributes[indexPath.row]
                
                cell.configure(
                    key: attribute.key,
                    value: attribute.value,
                    onKeyChange: { [weak self, weak cell] newKey in
                        guard let self = self,
                              let cell = cell,
                              let currentIndexPath = self.tableView.indexPath(for: cell),
                              currentIndexPath.row < self.attributes.count else { return }
                        self.attributes[currentIndexPath.row].key = newKey
                    },
                    onValueChange: { [weak self, weak cell] newValue in
                        guard let self = self,
                              let cell = cell,
                              let currentIndexPath = self.tableView.indexPath(for: cell),
                              currentIndexPath.row < self.attributes.count else { return }
                        self.attributes[currentIndexPath.row].value = newValue
                    },
                    onDelete: { [weak self, weak cell] in
                        guard let self = self,
                              let cell = cell,
                              let currentIndexPath = self.tableView.indexPath(for: cell),
                              currentIndexPath.row < self.attributes.count else { return }
                        self.removeAttribute(at: currentIndexPath.row)
                    }
                )
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section(rawValue: section)?.title
    }
}

// MARK: - UITableViewDelegate

extension CustomEventViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let section = Section(rawValue: indexPath.section) else { return }
        
        if section == .attributes && indexPath.row == attributes.count {
            addAttribute()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

