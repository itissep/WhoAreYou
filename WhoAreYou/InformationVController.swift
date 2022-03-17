//
//  InformationVController.swift
//  WhoAreYou
//
//  Created by The GORDEEVS on 15.03.2022.
//

import UIKit

class InformationVController: UIViewController {
    
    var name: String?
    
    var genderManager = GenderManager()
    var ageManager = AgeManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
        
        if let name = name {
            genderManager.fetchGender(name: name) { gender in
                DispatchQueue.main.async {
                    self.genderLabel.text = "Your gender is \(gender.gender)."
                    self.spinner.stopAnimating()
                }
            }
            
            ageManager.fetchAge(name: name) { age in
                DispatchQueue.main.async {
                    self.ageLabel.text = "You are \(age.age) years old."
                    self.spinner.stopAnimating()
                }
            }
        }
    }
    
    
    //MARK: - Layout
    
    private func layout(){
        
        view.addSubview(titleLabel)
        
        // ageLabel constraints
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    
        let stackView = stackViewMaker()
        view.addSubview(stackView)

        // stackView constraints
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            stackView.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        view.addSubview(resetBtn)
        
        // resetBtn constraints
        NSLayoutConstraint.activate([
            resetBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetBtn.centerYAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 150),
            resetBtn.widthAnchor.constraint(equalToConstant: 200),
            resetBtn.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        view.addSubview(spinner)
        
        // spinner constraints
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
        ])
        spinner.startAnimating()
        
        
    }
    
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        
        spinner.style = .large
        spinner.hidesWhenStopped = true
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "My guess is... "
        
        titleLabel.textColor = .systemRed
        titleLabel.font = UIFont.boldSystemFont(ofSize: 35.0)
        titleLabel.textAlignment = .center
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    
    func makeInfoLabel(text: String) -> UILabel {
        let label = UILabel()
        let msg = text
        label.text = msg
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    
    lazy var ageLabel: UILabel = makeInfoLabel(text: "")
    lazy var genderLabel: UILabel = makeInfoLabel(text: "")
    
    private func stackViewMaker()-> UIStackView{
        let stackView = UIStackView(arrangedSubviews: [genderLabel, ageLabel])
        stackView.axis = .vertical
        
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    
    lazy var resetBtn: UIButton = {
        let button = UIButton()
        
        button.setTitle("Again", for: .normal)
        button.addTarget(self, action: #selector(buttonReset), for: .touchUpInside)
        
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 16
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    @objc private func buttonReset() {
        self.dismiss(animated: true, completion: nil)
    }

}



