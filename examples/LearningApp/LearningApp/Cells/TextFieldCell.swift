//
//  TextFieldCell.swift
//  LearningApp
//
//  Copyright © 2025 Salesforce. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell {
    
    private let textField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.returnKeyType = .done
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private var onTextChange: ((String) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(textField)
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.delegate = self
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textField.text = nil
        textField.placeholder = nil
        onTextChange = nil
        backgroundColor = nil
        contentView.backgroundColor = nil
    }
    
    func configure(placeholder: String, text: String, onChange: @escaping (String) -> Void) {
        textField.placeholder = placeholder
        textField.text = text
        onTextChange = onChange
    }
    
    @objc private func textFieldDidChange() {
        onTextChange?(textField.text ?? "")
    }
}

extension TextFieldCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}