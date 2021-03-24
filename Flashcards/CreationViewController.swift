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
        extraAnswerOne.text = initialExtraTextOne
        extraAnswerTwo.text = initialExtraTextTwo
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        let questionText = questionTextField.text
        
        let answerText = answerTextField.text
        
        let extraTextOne = extraAnswerOne.text ?? "extra Option"
        
        let extraTextTwo = extraAnswerTwo.text ?? "extra Option"
        
        if (questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty){
            let alert = UIAlertController(title: "Missing Text", message: "You need both a question and an answer", preferredStyle: .alert)
            present(alert, animated: true)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
        } else {
            //check if the flashcard exists
            var isExisting = false
            if initialQuestion != nil {
                isExisting = true
            }
            
            //pass edited values to flashcard
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraOne: extraTextOne, extraTwo: extraTextTwo, isExisting: isExisting)
            dismiss(animated: true)
        }
        
    }
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var extraAnswerOne: UITextField!
    @IBOutlet weak var extraAnswerTwo: UITextField!
    var initialQuestion: String?
    var initialAnswer: String?
    var initialExtraTextOne: String?
    var initialExtraTextTwo: String?
//    var isExistingBool : Bool
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
