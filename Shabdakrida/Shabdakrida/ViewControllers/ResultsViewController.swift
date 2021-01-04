//
//  ResultsViewController.swift
//  Shabdakrida
//
//  Created by Pooja Chowdhary on 12/31/20.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var resultDescriptionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var isNextLevel: Bool = false
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text = repository.getResultScore()
        resultDescriptionLabel.text = repository.getResultDescription()
        nextButton.layer.cornerRadius = nextButton.frame.size.height  / 2
        isNextLevel = repository.getNextLevel()
        if isNextLevel {
            // Next level exists
            nextButton.isHidden = false
        }
        else {
            // This is last level
            nextButton.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextLevelSegue" {
            if let vc = segue.destination as? LevelOneViewController {
                vc.modalPresentationStyle = .fullScreen
                (vc.question, _) = repository.getQuestion(isNext: false)
            }
        }
    }

}
