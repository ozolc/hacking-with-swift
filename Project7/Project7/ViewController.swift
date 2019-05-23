//
//  ViewController.swift
//  Project7
//
//  Created by Maksim Nosov on 22/05/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    var urlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loadDatabutton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(loadData))
        let showInfoButton = UIBarButtonItem(title: "Info", style: .done, target: self, action: #selector(showInfo))
        navigationItem.rightBarButtonItems = [loadDatabutton, showInfoButton]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .done, target: self, action: #selector(filterJSON))
        
        performSelector(inBackground: #selector(loadData), with: nil)
    }
        
    
    @objc func loadData() {
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            //            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            //            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }
        
        if let url = URL(string: urlString) {
            if let data  = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        }
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func filterJSON() {
        let ac = UIAlertController(title: "Enter filter string", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Filter", style: .default) { [weak self, weak ac] _ in
            guard let filterText = ac?.textFields?[0].text else { return }
            self?.submit(filterText)
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
            
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ text: String) {
        filteredPetitions.removeAll()

        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            for petition in self.petitions {
                if petition.title.lowercased().contains(text.lowercased()) {
                    self.filteredPetitions.append(petition)
                }
            }
        }
        
    }
    
    
    @objc func showInfo() {
        let ac = UIAlertController(title: "Attention", message: "Data comes from the \nWe The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

