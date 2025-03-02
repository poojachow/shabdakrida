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
    var optionsMap: [String: Int] = [:]
    var endOfLevel: Bool = false
    
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
        if isSelectedAnswerCorrect(option: option1Button.currentTitle ?? "") {
            option1Button.backgroundColor = .systemGreen
        }
        else {
            option1Button.backgroundColor = .systemRed
        }
        optionSelected()
    }
    
    @IBAction func option2Clicked(_ sender: UIButton) {
        if isSelectedAnswerCorrect(option: option2Button.currentTitle ?? "") {
            option2Button.backgroundColor = .systemGreen
        }
        else {
            option2Button.backgroundColor = .systemRed
        }
        optionSelected()
    }
    
    @IBAction func option3Clicked(_ sender: UIButton) {
        if isSelectedAnswerCorrect(option: option3Button.currentTitle ?? "") {
            option3Button.backgroundColor = .systemGreen
        }
        else {
            option3Button.backgroundColor = .systemRed
        }
        optionSelected()
    }
    
    @IBAction func option4Clicked(_ sender: UIButton) {
        if isSelectedAnswerCorrect(option: option4Button.currentTitle ?? "") {
            option4Button.backgroundColor = .systemGreen
        }
        else {
            option4Button.backgroundColor = .systemRed
        }
        optionSelected()
    }
    
    func reset() {
        // Reset option background color
        option1Button.backgroundColor = .systemGray5
        option2Button.backgroundColor = .systemGray5
        option3Button.backgroundColor = .systemGray5
        option4Button.backgroundColor = .systemGray5
        // Reset option text
        option1Button.setTitle("-", for: .normal)
        option2Button.setTitle("-", for: .normal)
        option3Button.setTitle("-", for: .normal)
        option4Button.setTitle("-", for: .normal)
        // Reset image
        questionImageView.image = UIImage(named: "placeholder")
        optionsMap.removeAll()
        // Enable all option buttons
        option1Button.isEnabled = true
        option2Button.isEnabled = true
        option3Button.isEnabled = true
        option4Button.isEnabled = true
        endOfLevel = false
    }
    
    func set() {
        guard let question = question else {
            return
        }
        if let url = URL(string: question.imageUrl) {
            questionImageView.sd_setImage(with: url)
        }
        levelNameLabel.text = question.level
        // Randomize array
        let randomOptions = question.options.shuffled()
        for (index, value) in randomOptions.enumerated() {
            optionsMap[value] = index
        }
        if randomOptions.count < 4 {
            print("ERROR: Options list < 4")
            return
        }
        // Set options
        option1Button.setTitle(randomOptions[0], for: .normal)
        option2Button.setTitle(randomOptions[1], for: .normal)
        option3Button.setTitle(randomOptions[2], for: .normal)
        option4Button.setTitle(randomOptions[3], for: .normal)
    }
    
    func optionSelected() {
        // Disable all option buttons
        option1Button.isEnabled = false
        option2Button.isEnabled = false
        option3Button.isEnabled = false
        option4Button.isEnabled = false
        perform(#selector(updateNextQuestion), with: nil, afterDelay: 1.5)
    }
    
    @objc func updateNextQuestion() {
        // Get next question
        (question, endOfLevel) = repository.getQuestion(isNext: true)
        if endOfLevel {
            performSegue(withIdentifier: "levelResultSegue", sender: self)
        }
        else {
            // Reset question
            reset()
            // Set question
            set()
        }
    }
    
    func isSelectedAnswerCorrect(option: String) -> Bool {
        if option == question?.answer {
            repository.updateScore(correctAnswer: true)
            return true
        }
        else {
            if let index = optionsMap[question?.answer ?? ""] {
                getOptionButton(index: index).backgroundColor = .systemGreen
            }
            return false
        }
    }
    
    func getOptionButton(index: Int) -> UIButton {
        switch index {
        case 0:
            return option1Button
        case 1:
            return option2Button
        case 2:
            return option3Button
        case 3:
            return option4Button
        default:
            return option1Button
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "levelResultSegue" {
            if let vc = segue.destination as? ResultsViewController {
                vc.modalPresentationStyle = .fullScreen
            }
        }
    }

}
