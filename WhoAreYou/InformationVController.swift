//
//  InformationVController.swift
//  WhoAreYou
//
//  Created by The GORDEEVS on 15.03.2022.
//

import UIKit

class InformationVController: UIViewController {
    
    var age: String?
    var gender: String?
    var nationality: String?
    
    var labelArray: [UILabel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        

        
        layout()

        
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
        
        

        let stackView = stackViewMaker(labelsArray: makeArrayOfLabels())
        
        view.addSubview(stackView)
        
        // stackView constraints
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            stackView.widthAnchor.constraint(equalToConstant: 200),
//            stackView.heightAnchor.constraint(equalToConstant: 500),
        ])
        
        view.addSubview(resetBtn)
        
        // resetBtn constraints
        NSLayoutConstraint.activate([
            resetBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetBtn.centerYAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            resetBtn.widthAnchor.constraint(equalToConstant: 200),
            resetBtn.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        
        
    }
    
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
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func makeArrayOfLabels() -> [UILabel]{
        var array = [UILabel]()
        
        guard let age = age, let nationality = nationality, let gender = gender else { return [] }
        
        array.append(makeInfoLabel(text: "You are \(age) years old."))
        array.append(makeInfoLabel(text: "You are \(nationality)."))
        array.append(makeInfoLabel(text: "Your gender is \(gender)."))
        return array
    }
    
    private func stackViewMaker(labelsArray: [UILabel])-> UIStackView{
        let stackView = UIStackView(arrangedSubviews: labelsArray)
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
