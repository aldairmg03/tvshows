//
//  LoginViewController.swift
//  tvshows
//
//  Created by Aldair Martínez on 02/12/22.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    
    private var subscriptions = Set<AnyCancellable>()
    private let viewModelInput = LoginViewModelInput()
    private let viewModel: LoginViewModelProtocol

    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "banner")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var theMovieDBImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "themoviedb")
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var userTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "username".localized
        tf.autocapitalizationType = .none
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor.white
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
        
    }()
        
    private lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "password".localized
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor.white
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
        
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("login".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 3
        button.backgroundColor = UIColor.lightGray
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .red
        label.text = "error_message".localized
        label.numberOfLines = 2
        label.isHidden = true
        return label
    }()
    
    private lazy var backgrounLoading: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "navigationColor")
        view.layer.cornerRadius = 6
        view.isHidden = true
        return view
    }()
    
    private lazy var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        indicator.color = .lightGray
        indicator.startAnimating()
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
        return indicator
    }()
    
    init() {
        viewModel = LoginViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotificationObserver()
        setup()
        bind()
    }
    
}

private extension LoginViewController {
    
    func bind() {
        let output = viewModel.bind(input: viewModelInput)
        output.loadingPublisher.sink { [weak self] show in
            self?.displayLoading(show: show)
        }.store(in: &subscriptions)
        
        output.showErrorMessagePublisher.sink { [weak self] errorMessage in
            self?.showErrorMessage(errorMessage: errorMessage)
        }.store(in: &subscriptions)
        
        output.navigateToMainPublisher.sink { [weak self] in
            /*let navigationController = UINavigationController(rootViewController: MainViewController())
            guard let window = self?.view.window else {
                return
            }
            window.switchRootViewController(navigationController, animated: true)*/
        }.store(in: &subscriptions)
    }
    
    func setup() {
        view.backgroundColor = UIColor(named: "mainColor")
        self.hideKeyboardWhenTappedAround()
        addViews()
        setConstraints()
    }
    
    func addViews() {
        stackView.addArrangedSubview(userTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(errorLabel)
        
        backgrounLoading.addSubview(loadingActivityIndicator)
        
        view.addSubview(bannerImageView)
        view.addSubview(theMovieDBImageView)
        view.addSubview(stackView)
        view.addSubview(backgrounLoading)
        
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height / 3))
        ])
        
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height / 3))
        ])
        
        NSLayoutConstraint.activate([
            theMovieDBImageView.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 20),
            theMovieDBImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            theMovieDBImageView.widthAnchor.constraint(equalToConstant: 100),
            theMovieDBImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: theMovieDBImageView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            stackView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            backgrounLoading.heightAnchor.constraint(equalToConstant: 100),
            backgrounLoading.widthAnchor.constraint(equalToConstant: 100),
            backgrounLoading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgrounLoading.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loadingActivityIndicator.centerYAnchor.constraint(equalTo: backgrounLoading.centerYAnchor),
            loadingActivityIndicator.centerXAnchor.constraint(equalTo: backgrounLoading.centerXAnchor)
        ])
    
    }
    
}

extension LoginViewController {
    
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - (UIScreen.main.bounds.height / 4)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc private func handleLogin() {
        validateForm()
    }
    
    @objc private func handleTextChange() {
        let usernameText = userTextField.text!
        let passwordText = passwordTextField.text!
        let isFormFilled = !usernameText.isEmpty && !passwordText.isEmpty
        
        loginButton.backgroundColor = isFormFilled ? UIColor.darkGray : UIColor.lightGray
        loginButton.isEnabled = isFormFilled
    }
    
    private func validateForm() {
        guard let usernameText = userTextField.text, !usernameText.isEmpty else { return }
        guard let passwordText = passwordTextField.text, !passwordText.isEmpty else { return }
        startLogin(username: usernameText, password: passwordText)
    }
    
    private func startLogin(username: String, password: String) {
        viewModelInput.startLoginPublisher.send(User(username: username, password: password))
    }
    
    private func displayLoading(show: Bool) {
        if show {
            loadingActivityIndicator.startAnimating()
        } else {
            loadingActivityIndicator.stopAnimating()
        }
        backgrounLoading.isHidden = !show
    }
    
    func showErrorMessage(errorMessage: String) {
        errorLabel.text = errorMessage
        errorLabel.isHidden = false
    }

    
}
