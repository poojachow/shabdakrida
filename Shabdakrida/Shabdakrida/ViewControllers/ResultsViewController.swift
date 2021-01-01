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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text = repository.getResultScore()
        resultDescriptionLabel.text = repository.getResultDescription()
    }

}
