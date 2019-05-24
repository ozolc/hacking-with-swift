//
//  ViewController.swift
//  Project2
//
//  Created by Maksim Nosov on 20/05/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var bestScore = 0
    var isBest = false
    
    let defaults = UserDefaults.standard
    let bestScoreString = "bestScore"
    
    var totalQuestions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("uk")
        countries.append("us")
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .done, target: self, action: #selector(showScore))
        
        bestScore = loadScore()
        
        askQuestion()
        
    }
    
    func loadScore() -> Int {
        return defaults.integer(forKey: bestScoreString)
    }
    
    func saveScore(value: Int) {
        defaults.set(value, forKey: bestScoreString)
    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: "Result", message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true)
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased() + ". Your score is: \(score)"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            if (score > bestScore) && !isBest {
                isBest = true
                showBestScore()
            }
            saveScore(value: score)
        } else {
            title = "Wrong"
            let ac = UIAlertController(title: title, message: "That's the flag of \(countries[sender.tag].uppercased())", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
            present(ac, animated: true)
            score -= 1
            if (score < bestScore) && isBest {
//                saveScore(value: score)
                isBest = false
            }
        }
        
        totalQuestions += 1
        
//        if totalQuestions == 3 {
//            let ac = UIAlertController(title: "You have passed 3 questions", message: "Your score is \(score)", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
//            present(ac, animated: true)
//            totalQuestions = 0
//        } else {
            askQuestion()
//        }
    }
    
    func showBestScore() {
        let ac = UIAlertController(title: "Congratulations", message: "It's your best score: \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
}

