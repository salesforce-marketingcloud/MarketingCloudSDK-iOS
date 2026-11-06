//
//  AttributeCell.swift
//  LearningApp
//
//  Copyright © 2025 Salesforce. All rights reserved.
//

import UIKit
class AttributeCell: UITableViewCell {
    
    private let keyTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Key"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.returnKeyType = .next
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let valueTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Value"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.returnKeyType = .done
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let deleteButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("✕", for: .normal)
        btn.tintColor = .red
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private var onKeyChange: ((String) -> Void)?
    private var onValueChange: ((String) -> Void)?
    private var onDelete: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(keyTextField)
        contentView.addSubview(valueTextField)
        contentView.addSubview(deleteButton)
        
        keyTextField.delegate = self
        valueTextField.delegate = self
        
        keyTextField.addTarget(self, action: #selector(keyChanged), for: .editingChanged)
        valueTextField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            keyTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            keyTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            keyTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.35),
            keyTextField.heightAnchor.constraint(equalToConstant: 32),
            
            valueTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            valueTextField.leadingAnchor.constraint(equalTo: keyTextField.trailingAnchor, constant: 8),
            valueTextField.heightAnchor.constraint(equalToConstant: 32),
            
            deleteButton.centerYAnchor.constraint(equalTo: valueTextField.centerYAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: valueTextField.trailingAnchor, constant: 8),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            deleteButton.widthAnchor.constraint(equalToConstant: 30),
            
            contentView.bottomAnchor.constraint(equalTo: keyTextField.bottomAnchor, constant: 8)
        ])
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(key: String, value: String, onKeyChange: @escaping (String) -> Void, onValueChange: @escaping (String) -> Void, onDelete: @escaping () -> Void) {
        keyTextField.text = key
        valueTextField.text = value
        self.onKeyChange = onKeyChange
        self.onValueChange = onValueChange
        self.onDelete = onDelete
    }
    
    func focusKeyField() {
        keyTextField.becomeFirstResponder()
    }
    
    @objc private func keyChanged() {
        onKeyChange?(keyTextField.text ?? "")
    }
    
    @objc private func valueChanged() {
        onValueChange?(valueTextField.text ?? "")
    }
    
    @objc private func deleteTapped() {
        onDelete?()
    }
}

extension AttributeCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == keyTextField {
            valueTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
