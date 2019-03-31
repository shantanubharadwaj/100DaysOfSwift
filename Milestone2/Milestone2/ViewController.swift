//
//  ViewController.swift
//  Milestone2
//
//  Created by Shantanu Dutta on 31/03/19.
//  Copyright © 2019 Shantanu Dutta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let cellid = "cellidentifier"
    fileprivate var shoppingList = [String]()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping !!!!"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearlist))
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        toolbarItems = [spacer,share]
        navigationController?.isToolbarHidden = false
    }

    @objc fileprivate func addItem() {
        let ac = UIAlertController(title: "Enter item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text, !item.isEmpty else {
                return
            }
            self?.submit(item)
        }))
        present(ac, animated: true)
    }

    @objc fileprivate func clearlist() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc fileprivate func shareTapped() {
        let list = shoppingList.joined(separator: "\n")
        guard !list.isEmpty else {
            return
        }
        let vc = UIActivityViewController(activityItems: [list, "Shopping List"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = toolbarItems?[1]
        present(vc, animated: true)
    }
    
    fileprivate func submit(_ value: String) {
        shoppingList.insert(value, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    
}
