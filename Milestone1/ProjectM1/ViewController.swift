//
//  ViewController.swift
//  Project4
//
//  Created by Shantanu Dutta on 18/03/19.
//  Copyright © 2019 Shantanu Dutta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let cellId = "flagCell"
    
    var flagPictures = [String]()
    @IBOutlet weak var flagList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flagList.separatorStyle = .none
        loadResource()
    }
    
    func loadResource() {
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: path)
        
        for item in items where item.hasSuffix("png") {
            flagPictures.append(item)
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "FlagDetail") as? DetailViewController {
            vc.selectedImage = flagPictures[indexPath.row]
            vc.selectedCountry = countryName(flagPictures[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func countryName(_ imageName: String) -> String {
        let strippedString = imageName.removeExtension
        return strippedString.count == 2 ? strippedString.uppercased() : strippedString.capitalized
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flagPictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if let flagCell = cell as? FlagListCell {
            flagCell.imageName = flagPictures[indexPath.row]
        }
        return cell
    }
}

extension String {
    var removeExtension: String {
        return String(self.prefix(while: {$0 != "."}))
    }
}
