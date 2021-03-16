//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Uren Mador on 3/6/21.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        let questionText = questionTextField.text
        
        let answerText = answerTextField.text
        
        let extraTextOne = extraAnswerOne.text
        
        let extraTextTwo = extraAnswerTwo.text
        
        if (questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty){
            let alert = UIAlertController(title: "Missing Text", message: "You need both a question and an answer", preferredStyle: .alert)
            present(alert, animated: true)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
        } else {
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraOne: extraTextOne, extraTwo: extraTextTwo)
            dismiss(animated: true)
        }
        
        
        
    }
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var extraAnswerOne: UITextField!
    @IBOutlet weak var extraAnswerTwo: UITextField!
    var initialQuestion: String?
    var initialAnswer: String?
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
