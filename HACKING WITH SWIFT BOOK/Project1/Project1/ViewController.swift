//
//  ViewController.swift
//  Project1
//
//  Created by Maksim Nosov on 19/05/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    let defaults = UserDefaults.standard
//    var showCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                if item.hasPrefix("nssl") {
                    self?.pictures.append(item)
                }
            }
            
            DispatchQueue.main.async {
                self?.pictures.sort()
                self?.tableView.reloadData()
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Recommend", style: .plain, target: self, action: nil)
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]

        let cellCount = defaults.integer(forKey: "\(pictures[indexPath.row])")
        cell.detailTextLabel?.text = String(cellCount)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.allPictures = pictures.count
            vc.selectedIndexOfPictures = indexPath.row
            vc.selectedImage = pictures[indexPath.row]
            
            let cellCount = defaults.integer(forKey: "\(pictures[indexPath.row])")
            defaults.set(cellCount + 1, forKey: "\(pictures[indexPath.row])")
            
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

