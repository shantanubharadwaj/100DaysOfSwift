//
//  ViewController.swift
//  Project5
//
//  Created by Shantanu Dutta on 31/03/19.
//  Copyright © 2019 Shantanu Dutta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let cellId = "cellIdentifier"
    
    private var allWords = [String]()
    private var usedWords = [String]()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        loadSource()
        configureUI()
        configureContraints()
        startGame()
    }
    
    private func loadSource() {
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt"), let startWords = try? String(contentsOf: fileURL, encoding: .utf8) {
            allWords = startWords.components(separatedBy: "\n")
        }
    }
    
    private func configureUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(startGame))
        view.addSubview(tableView)
    }
    
    private func configureContraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }

    @objc fileprivate func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    fileprivate func submitAnswer(_ answer: String) {
        let loweranswer = answer.lowercased()
        if isPossible(word: loweranswer) {
            if isOriginal(word: loweranswer) {
                if isReal(word: loweranswer) {
                    usedWords.insert(loweranswer, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .fade)
                    return
                }else{
                    showErrorAlert(title: "Word not recognised", message: "You can't just make them up, you know!")
                }
            }else{
                showErrorAlert(title: "Word used already", message: "Be more original!")
            }
        }else{
            guard let title = title?.lowercased() else { return }
            showErrorAlert(title: "Word not possible", message: "You can't spell that word from \(title)")
        }
        
    }
    
    fileprivate func showErrorAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    fileprivate func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            }else{
                return false
            }
        }
        return true
    }
    
    fileprivate func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    fileprivate func isReal(word: String) -> Bool {
        guard word.count >= 3 else {
            return false
        }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    @objc fileprivate func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak ac, weak self] _ in
            guard let answer = ac?.textFields?[0].text, !answer.isEmpty else {
                return
            }
            self?.submitAnswer(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    
}
