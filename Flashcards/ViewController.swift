//
//  ViewController.swift
//  Flashcards
//
//  Created by Uren Mador on 2/27/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.2184618115, green: 0.9229496919, blue: 0.9385696883, alpha: 1)
        btnOptionOne.layer.cornerRadius = 10.0
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.2184618115, green: 0.9229496919, blue: 0.9385696883, alpha: 1)
        btnOptionTwo.layer.cornerRadius = 10.0
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.2184618115, green: 0.9229496919, blue: 0.9385696883, alpha: 1)
        btnOptionThree.layer.cornerRadius = 10.0
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if (frontLabel.isHidden != true) {
            frontLabel.isHidden = true
            btnOptionOne.isHidden = true
            btnOptionThree.isHidden = true
        } else {
            frontLabel.isHidden = false
            btnOptionOne.isHidden = false
            btnOptionThree.isHidden = false
        }
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isHidden = true
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true
    }
    
    
    func updateFlashcard(question: String, answer: String, extraOne: String?, extraTwo: String?){
        frontLabel.text = question
        backLabel.text = answer
        btnOptionOne.setTitle(extraOne, for: .normal)
        btnOptionTwo.setTitle(answer, for: .normal)
        btnOptionThree.setTitle(extraTwo, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
        if (segue.identifier == "EditSegue"){
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
        }
    }
}

