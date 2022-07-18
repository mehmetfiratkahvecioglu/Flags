//
//  ViewController.swift
//  Project2
//
//  Created by Fırat Kahvecioğlu on 14.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    @IBOutlet var scoreLabel: UILabel!
    
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var questionsAnswered = 0
    
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        // project 3 challenge 3
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(replayButtonTapped))
        
        
        askQuestion()
        self.navigationController!.navigationBar.backgroundColor = UIColor.yellow

        button1.configuration = .filled()
        button1.configuration?.imagePadding = 0
        button1.configuration?.contentInsets = .zero
        
        button2.configuration = .filled()
        button2.configuration?.imagePadding = 0
        button2.configuration?.contentInsets = .zero
        
        button3.configuration = .filled()
        button3.configuration?.imagePadding = 0
        button3.configuration?.contentInsets = .zero
        

    }


    func askQuestion(action: UIAlertAction! = nil) {
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

        
        button1.setImage(UIImage(named: countries[0]), for: UIControl.State.normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = " Which is the flag of \(countries[correctAnswer].uppercased()) ?"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blue]
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        questionsAnswered += 1
        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.green]
            
            message = "Correct "
            
        } else {
            title = "Wrong!"
            
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.red]
            
            message = " Wrong! That’s the flag of \(countries[sender.tag].uppercased()) "
            
            
        }
        
        
        
        if questionsAnswered == 10{
            
            title = "Game Over !"
            
            let ac = UIAlertController(title: title, message: "\(message),Game Over Your score is \(score)/\(questionsAnswered).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Replay", style: .default, handler: rePlay))
            present(ac, animated: true)
            
        }else{
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
        
        scoreLabel.text = "Score : \(String(score))/\(questionsAnswered)"
        
        
        
        sender.alpha = 0.5

           DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ) {
               sender.alpha = 1.0
           }
    }
    
    func rePlay(action: UIAlertAction! = nil){
        correctAnswer = 0
        score = 0
        questionsAnswered = 0
        scoreLabel.text = "Score : \(String(score))/\(questionsAnswered)"
        askQuestion()
    }
    
    // project 3 challenge 3
        @objc func replayButtonTapped() {
            let ac = UIAlertController(title: "Score", message: "Score: \(score)/\(questionsAnswered)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
            ac.addAction(UIAlertAction(title: "Replay", style: .destructive , handler: (rePlay ) ))
            
                    present(ac, animated: true)
            
        }
    
    
}

