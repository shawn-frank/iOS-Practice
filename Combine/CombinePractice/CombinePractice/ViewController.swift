//
//  ViewController.swift
//  CombinePractice
//
//  Created by Shawn Frank on 19/2/2023.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @Published private var username = ""
    @Published private var password = ""
    @Published private var repeatPassword = ""
    
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var repeatPasswordTextField: UITextField!
    var tcSwitch: UISwitch!
    var submitButton: UIButton!
    
    var signUpButtonStream: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupUserNameTextField()
        setupPasswordTextField()
        setupRepeatPasswordTextField()
        setupTermsAndConditions()
        setupSubmitButton()
        
        configureValidation()
    }
    
    private func setupUserNameTextField() {
        usernameTextField = createTextField()
        usernameTextField.placeholder = "Enter email"
        usernameTextField.addTarget(self, action: #selector(usernameFieldDidChange(_:)),
                                    for: .editingChanged)
        view.addSubview(usernameTextField)
        
        view.addConstraints([
            usernameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            usernameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupPasswordTextField() {
        passwordTextField = createTextField()
        passwordTextField.placeholder = "Enter password"
        passwordTextField.addTarget(self, action: #selector(passwordFieldDidChange(_:)),
                                    for: .editingChanged)
        view.addSubview(passwordTextField)
        
        view.addConstraints([
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupRepeatPasswordTextField() {
        repeatPasswordTextField = createTextField()
        repeatPasswordTextField.placeholder = "Repeat password"
        repeatPasswordTextField.addTarget(self, action: #selector(repeatPasswordFieldDidChange(_:)),
                                          for: .editingChanged)
        view.addSubview(repeatPasswordTextField)
        
        view.addConstraints([
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            repeatPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            repeatPasswordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureValidation() {
        let passwordVerification = configurePasswordValidation()
        let usernameVerification = configureUsernameValidation()
        
        let credentialVerification: AnyPublisher<(String, String)?, Never>
        = usernameVerification.combineLatest(passwordVerification) { username, password -> (String, String)? in
            guard let password = password, let username = username else { return nil }
            
            return (username, password)
        }
        .eraseToAnyPublisher()
        
        signUpButtonStream =
        credentialVerification.map {$0 != nil}
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: submitButton)
    }
    
    private func configurePasswordValidation() -> AnyPublisher<String?, Never> {
        let passwordVerification = $password.combineLatest($repeatPassword) { password, repeatPassword -> String? in
            guard password == repeatPassword, password.count >= 8 else {
                return nil
            }
            
            return password
        }
        .eraseToAnyPublisher()
        
        return passwordVerification
    }
    
    private func configureUsernameValidation() -> AnyPublisher<String?, Never> {
        let usernameVerification =
        $username.debounce(for: 1, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { username in
                Future { promise in
                    NetworkService.shared.verifyUserName(username) { available in
                        promise(.success(available ? username : nil))
                    }
                }
            }
            .eraseToAnyPublisher()
        
        return usernameVerification
    }
    
    private func setupTermsAndConditions() {
        let label = UILabel()
        label.text = "Agree with terms & conditions"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        view.addConstraints([
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 10),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        tcSwitch = UISwitch()
        tcSwitch.setOn(false, animated: false)
        tcSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tcSwitch)
        
        view.addConstraints([
            tcSwitch.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tcSwitch.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 10),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupSubmitButton() {
        submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(didTapSubmit(_:)), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.isEnabled = false
        view.addSubview(submitButton)
        
        view.addConstraints([
            submitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            submitButton.topAnchor.constraint(equalTo: tcSwitch.bottomAnchor, constant: 10),
            submitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func createTextField() -> UITextField {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }
    
    @objc private func passwordFieldDidChange(_ textField: UITextField) {
        password = textField.text ?? ""
    }
    
    @objc private func repeatPasswordFieldDidChange(_ textField: UITextField) {
        repeatPassword = textField.text ?? ""
    }
    
    @objc private func usernameFieldDidChange(_ textField: UITextField) {
        submitButton.isEnabled = false
        username = textField.text ?? ""
    }

    @objc private func didTapSubmit(_ sender: UIButton) {
        print("Submit!")
    }
}

