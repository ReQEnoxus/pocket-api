//
//  FieldCreatorViewController.swift
//  PocketAPI
//
//  Created by Enoxus on 27.06.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit

class FieldCreatorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private class Appearance {
        
        static let contentSpacing: CGFloat = 16
        
        static let contentLeftOffset = 32
        static let contentTopOffset = 32
        static let contentRightOffset = 32
        static let contentBottomOffset = 32
        
        static let containerViewCornerRadius: CGFloat = 16
        
        static let containerWidthMultiplier = 0.75
        
        static let cancelButtonTitle = "Cancel"
        static let submitButtonTitle = "Submit"
        static let selectTypeButtonTitle = "Select type"
        static let doneButtonTitle = "Done"
        
        static let animationTime = 0.5
        
        static let dimmingColor = UIColor(red: .zero, green: .zero, blue: .zero, alpha: 0.6)
        
        static let fieldNamePlaceholderText = "Enter field name"
        
        static let modalWindowTitle = "Create Field"
        static let modalWindowTitleFont = "Futura-Bold"
        static let modalWindowTitleFontSize: CGFloat = 20
    }
    
    var presenter: FieldCreatorViewOutput!
    
    private var selectedIndex: Int = .zero
    
    lazy var modalWindowTitle: UILabel = {
        
        let label = UILabel()
        label.font = UIFont(name: Appearance.modalWindowTitleFont, size: Appearance.modalWindowTitleFontSize)
        label.textColor = .systemGreen
        label.text = Appearance.modalWindowTitle
        
        return label
    }()
    
    lazy var pickerView: UIPickerView = {
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
    
        return pickerView
    }()
    
    lazy var nameTextField: UITextField = {
        
        let textField = UITextField()
        textField.tintColor = .systemGreen
        textField.placeholder = Appearance.fieldNamePlaceholderText
        textField.borderStyle = .none
        textField.keyboardType = .asciiCapable
        
        return textField
    }()
    
    lazy var containerView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = Appearance.containerViewCornerRadius
        
        return view
    }()
    
    lazy var containerStackView: UIStackView = {
        
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Appearance.contentSpacing
        view.alignment = .leading
        
        return view
    }()
    
    lazy var cancelButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.tintColor = .systemGreen
        button.setTitle(Appearance.cancelButtonTitle, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    lazy var typeTextField: UITextField = {
        
        let textField = UITextField()
        textField.inputAccessoryView = toolBar
        textField.placeholder = Appearance.selectTypeButtonTitle
        textField.inputView = pickerView
        textField.tintColor = .systemGreen
        textField.keyboardType = .asciiCapable
        
        textField.delegate = self
        
        return textField
    }()
    
    lazy var toolBar: UIToolbar = {
        
        let toolBar = UIToolbar()
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIBarButtonItem(title: Appearance.doneButtonTitle, style: .plain, target: self, action: #selector(endEditing))
        button.tintColor = .systemGreen
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }()
    
    lazy var submitButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.tintColor = .systemGreen
        button.setTitle(Appearance.submitButtonTitle, for: .normal)
        button.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    lazy var horizontalButtonStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Appearance.contentSpacing
        stackView.alignment = .firstBaseline
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        setupViewHierarchy()
        setupConstraints()
        
        pickerView.selectRow(.zero, inComponent: .zero, animated: true)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapOuterView))
        gesture.delegate = self
        
        let endEditingGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        
        containerView.addGestureRecognizer(endEditingGesture)
        
        view.addGestureRecognizer(gesture)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: Appearance.animationTime) { [unowned self] in
            self.view.backgroundColor = Appearance.dimmingColor
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: Appearance.animationTime) { [unowned self] in
            self.view.backgroundColor = .clear
        }
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: .none)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: .none)
    }
    
    func setupViewHierarchy() {
        
        view.addSubview(containerView)
        
        containerView.addSubview(containerStackView)
        
        horizontalButtonStackView.addArrangedSubview(cancelButton)
        horizontalButtonStackView.addArrangedSubview(submitButton)
        
        containerStackView.addArrangedSubview(modalWindowTitle)
        containerStackView.addArrangedSubview(nameTextField)
        containerStackView.addArrangedSubview(typeTextField)
        containerStackView.addArrangedSubview(horizontalButtonStackView)
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            
            make.centerX.equalTo(view.frame.width / 2)
            make.centerY.equalTo(view.frame.height / 2)
            make.width.equalToSuperview().multipliedBy(Appearance.containerWidthMultiplier)
        }
        
        containerStackView.snp.makeConstraints { make in
            
            make.left.equalToSuperview().offset(Appearance.contentLeftOffset)
            make.top.equalToSuperview().offset(Appearance.contentTopOffset)
            make.right.equalToSuperview().inset(Appearance.contentRightOffset)
            make.bottom.equalToSuperview().inset(Appearance.contentBottomOffset)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        typeTextField.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        horizontalButtonStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SupportedPrimitives.availableCases().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SupportedPrimitives.availableCases()[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedIndex = row
        typeTextField.text = SupportedPrimitives.availableCases()[row]
    }
    
    //MARK: - KeyboardObserver
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            let restScreenHeight = view.frame.height - keyboardHeight
            let destinationY = restScreenHeight / 2
            
            UIView.animate(withDuration: Appearance.animationTime) { [unowned self] in
                
                self.containerView.snp.updateConstraints { update in
                    update.centerY.equalTo(destinationY)
                }
                
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        containerView.snp.updateConstraints { update in
            update.centerY.equalTo(view.frame.height / 2)
        }
        
        UIView.animate(withDuration: Appearance.animationTime) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - objc selectors
    @objc func cancelButtonPressed() {
        presenter.didPressedCancel()
    }
    
    @objc func submitButtonPressed() {
        presenter.didPressedCreate(name: nameTextField.text, selectedIndex: pickerView.selectedRow(inComponent: .zero))
    }
    
    @objc func didTapOuterView() {
        presenter.didPressedCancel()
    }
    
    @objc func endEditing() {
        view.endEditing(true)
    }
}

extension FieldCreatorViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }
}

extension FieldCreatorViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if !textField.hasText {
            textField.text = SupportedPrimitives.availableCases()[pickerView.selectedRow(inComponent: .zero)]
        }
        
        return true
    }
}
