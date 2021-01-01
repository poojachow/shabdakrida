//
//  LevelOneViewController.swift
//  Shabdakrida
//
//  Created by Pooja Chowdhary on 12/31/20.
//

import UIKit
import SDWebImage

class LevelOneViewController: UIViewController {

    @IBOutlet weak var levelNameLabel: UILabel!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    
    var question: QuestionModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        option1Button.layer.cornerRadius = option1Button.frame.size.height / 2
        option2Button.layer.cornerRadius = option2Button.frame.size.height / 2
        option3Button.layer.cornerRadius = option3Button.frame.size.height / 2
        option4Button.layer.cornerRadius = option4Button.frame.size.height / 2
        reset()
        set()
    }
    
    @IBAction func option1Clicked(_ sender: UIButton) {
    }
    
    @IBAction func option2Clicked(_ sender: UIButton) {
    }
    
    @IBAction func option3Clicked(_ sender: UIButton) {
    }
    
    @IBAction func option4Clicked(_ sender: UIButton) {
    }
    
    func reset() {
        // reset option background color
        option1Button.backgroundColor = .systemGray5
        option2Button.backgroundColor = .systemGray5
        option3Button.backgroundColor = .systemGray5
        option4Button.backgroundColor = .systemGray5
        // reset option text
        option1Button.setTitle("-", for: .normal)
        option2Button.setTitle("-", for: .normal)
        option3Button.setTitle("-", for: .normal)
        option4Button.setTitle("-", for: .normal)
        // reset image
        questionImageView.image = UIImage(named: "placeholder")
    }
    
    func set() {
        guard let question = question else {
            return
        }
        option1Button.setTitle(question.options[0], for: .normal)
        option2Button.setTitle(question.options[1], for: .normal)
        option3Button.setTitle(question.options[2], for: .normal)
        option4Button.setTitle(question.options[3], for: .normal)
        if let url = URL(string: question.imageUrl) {
            questionImageView.sd_setImage(with: url)
        }
    }

}
