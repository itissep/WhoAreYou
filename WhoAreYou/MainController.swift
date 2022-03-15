//
//  ViewController.swift
//  WhoAreYou
//
//  Created by The GORDEEVS on 14.03.2022.
//

import UIKit

class MainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupKeyboardHiding()
        self.hideKeyboardWhenTappedAround()
        layout()
        
    }
    
    
    
    //MARK: - Layout
    private func layout(){
        
        view.addSubview(titleLabel)
        view.addSubview(labelForSearch)
        view.addSubview(textField)
        view.addSubview(searchButton)
        
        
        
        // labelForSearch constraints
        NSLayoutConstraint.activate([
            labelForSearch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelForSearch.centerYAnchor.constraint(equalTo: textField.topAnchor, constant: -60),
            labelForSearch.widthAnchor.constraint(equalToConstant: 250),
            labelForSearch.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // textField constraints
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: 350),
            textField.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // searchButton constraints
        NSLayoutConstraint.activate([
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.centerYAnchor.constraint(equalTo: textField.bottomAnchor, constant: 50),
            searchButton.widthAnchor.constraint(equalToConstant: 350),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // titleLabel constraints
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: labelForSearch.topAnchor, constant: -50),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }



    lazy var imageView: UIImageView = {
        let image = UIImage(systemName: "phone")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 16
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func buttonAction(){
        print("wow")
    }
    
    
    lazy var labelForSearch: UILabel = {
        let labelForSearch = UILabel()
        labelForSearch.text = "We need your name to figure out who you are"
        labelForSearch.textColor = .systemGray
        labelForSearch.lineBreakMode = .byWordWrapping
        labelForSearch.numberOfLines = 0
        labelForSearch.textAlignment = .center
        
        labelForSearch.translatesAutoresizingMaskIntoConstraints = false
        return labelForSearch
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Who are you?"
        
        titleLabel.textColor = .systemRed
        titleLabel.font = UIFont.boldSystemFont(ofSize: 35.0)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        
        textField.attributedPlaceholder = NSAttributedString(string: "your name", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.2459555462)])
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemRed.cgColor
        textField.layer.cornerRadius = 16
        textField.clearButtonMode = .whileEditing
        textField.textColor = .systemRed
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
}






//MARK: - Keyboard setup
extension MainController {
    
    
// in viewDidLoad ------>
    
//              setupKeyboardHiding()
//              self.hideKeyboardWhenTappedAround()
    
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(MainController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc func keyboardWillShow(sender: NSNotification) {
            guard let userInfo = sender.userInfo,
                  let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
                  let currentTextField = UIResponder.currentFirst() as? UITextField else { return }

        // check if the top of the keyboard is above the bottom of the currently focused textbox
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        // if textField bottom is below keyboard bottom - bump the frame up
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }

    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        view.frame.origin.y = 0
    }
}
