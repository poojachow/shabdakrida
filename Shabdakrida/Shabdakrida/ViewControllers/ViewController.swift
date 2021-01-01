//
//  ViewController.swift
//  Shabdakrida
//
//  Created by Pooja Chowdhary on 12/30/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startButton.layer.cornerRadius = startButton.frame.height / 2
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "level1Segue" {
            if let vc = segue.destination as? LevelOneViewController {
                vc.modalPresentationStyle = .fullScreen
                (vc.question, _) = repository.getQuestion(isNext: false)
            }
        }
    }

}

