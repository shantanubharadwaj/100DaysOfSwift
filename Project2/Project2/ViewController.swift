//
//  ViewController.swift
//  Project2
//
//  Created by Shantanu Dutta on 13/03/19.
//  Copyright © 2019 Shantanu Dutta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var vcmodel: VCModel = VCModel()
    
    let buttonA: UIButton = {
        let button = UIButton()
        button.tag = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleFlagButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    let buttonB: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleFlagButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    let buttonC: UIButton = {
        let button = UIButton()
        button.tag = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleFlagButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private func updateLayout() {
        view.addSubview(buttonA)
        view.addSubview(buttonB)
        view.addSubview(buttonC)
        
        NSLayoutConstraint.activate([
            buttonA.widthAnchor.constraint(equalToConstant: 200),
            buttonA.heightAnchor.constraint(equalToConstant: 100),
            buttonA.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            buttonA.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonB.widthAnchor.constraint(equalToConstant: 200),
            buttonB.heightAnchor.constraint(equalToConstant: 100),
            buttonB.topAnchor.constraint(equalTo: buttonA.bottomAnchor, constant: 100),
            buttonB.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonC.widthAnchor.constraint(equalToConstant: 200),
            buttonC.heightAnchor.constraint(equalToConstant: 100),
            buttonC.topAnchor.constraint(equalTo: buttonB.bottomAnchor, constant: 100),
            buttonC.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func updateQuestion() {
        let countryimages = vcmodel.askQuestion()
        buttonA.setImage(UIImage(named: countryimages[0]), for: .normal)
        buttonB.setImage(UIImage(named: countryimages[1]), for: .normal)
        buttonC.setImage(UIImage(named: countryimages[2]), for: .normal)
        title = "\(vcmodel.answerCountryName) (Score : \(vcmodel.score))"
    }
    
    @objc func handleFlagButtonTapped(_ sender: UIButton) {
        var title: String
        var message: String = ""
        if sender.tag == vcmodel.correctAnswer {
            title = "Correct"
            vcmodel.updateScore(with: true)
        }else {
            title = "Wrong Answer!"
            message = "Wrong! That's the flag of \(vcmodel.getCountryName(for: sender.tag)) ! "
            vcmodel.updateScore(with: false)
        }
        if vcmodel.isRoundComplete{
            message += "\n Your final score is \(vcmodel.score)"
            showAlert(with: title, message: message, shouldRetryOption: true)
        }else{
            showAlert(with: title, message: message)
        }
    }
    
    func showAlert(with title: String, message: String, shouldRetryOption: Bool = false) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if shouldRetryOption {
            alert.addAction(UIAlertAction(title: "Stop !", style: .destructive, handler: { (action) in
                exit(0)
            }))
            alert.addAction(UIAlertAction(title: "Continue Again?", style: .default, handler: { [weak self](action) in
                self?.vcmodel.resetData()
                self?.updateQuestion()
            }))
        }else{
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { [weak self](action) in
                self?.updateQuestion()
            }))
        }
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        vcmodel.setData()
        updateLayout()
        updateQuestion()
    }
}

