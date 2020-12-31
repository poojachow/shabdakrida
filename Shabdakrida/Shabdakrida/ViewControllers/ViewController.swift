//
//  ViewController.swift
//  Shabdakrida
//
//  Created by Pooja Chowdhary on 12/30/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func startClicked(_ sender: UIButton) {
        let vc = Level1ViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.question = repository.getQuestion(isNext: false)
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

