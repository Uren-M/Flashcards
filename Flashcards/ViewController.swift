//
//  ViewController.swift
//  Flashcards
//
//  Created by Uren Mador on 2/27/21.
//

import UIKit

//Create a struct. A struct is a way to define a type of object, and allows us to group properties and functions

struct Flashcard {
    var question: String
    var answer: String
    var extraOne: String
    var extraTwo: String
}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //create an array flashcards
    var flashcards = [Flashcard]()
    //create index counter
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        
        //Read saved flashcards
        readSavedFlashcards()
        
        if flashcards.count == 0 {
            updateFlashcard(question: "What's the capital of Brazil?", answer: "Brasilia", extraOne: "Hong Kong", extraTwo: "Lagos", isExisting: true)
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
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
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateLabels()
        updateNextPrevButtons()
    }
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        present(alert, animated: true)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)

    }
    
    func deleteCurrentFlashcard(){
        
        //SPECIAL CASE: When the last index is deleted
        if currentIndex > 0 || flashcards.count != 1 {
            flashcards.remove(at: currentIndex)
            currentIndex = flashcards.count - 1
            
            updateLabels()
            updateNextPrevButtons()
            saveAllFlashcardsToDisk()
        } else {
            //show alert message if user tries to delete last flashcard left
            let notify = UIAlertController(title: "Caution⚠️", message: "You cannot delete the last flashcard left", preferredStyle: .alert)
            present(notify, animated: true)
            let dismiss = UIAlertAction(title: "Dismiss", style: .default)
            notify.addAction(dismiss)
        }
    }
    
    //function to update flashcards
    
    func updateFlashcard(question: String, answer: String, extraOne: String, extraTwo: String, isExisting: Bool){
        let flashcard = Flashcard(question: question, answer: answer, extraOne: extraOne, extraTwo: extraTwo)
        
        //check if the flashcard already exists and is only being edited
        if isExisting{
            flashcards[currentIndex] = flashcard
        } else {
            //adding new flashcard to flashcard array/dictionary
            flashcards.append(flashcard)
        
            //logging on console
            print("😎 added flashcard")
            currentIndex = flashcards.count - 1
            print("😎 We now have \(currentIndex) flashcards")
        }
        
        //update nav button function
        updateNextPrevButtons()
        
        //update labels
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    //create update nav button function
    
    func updateNextPrevButtons(){
        //disable button if at end
        if (currentIndex == flashcards.count - 1){
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        if (currentIndex == 0){
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        btnOptionOne.setTitle(currentFlashcard.extraOne, for: .normal)
        btnOptionTwo.setTitle(currentFlashcard.answer, for: .normal)
        btnOptionThree.setTitle(currentFlashcard.extraTwo, for: .normal)
        
    }
    
    //function to save flashcards locally on disk
    func saveAllFlashcardsToDisk(){
        //convert from flashcards array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer, "extraOne": card.extraOne, "extraTwo": card.extraTwo]
        }
    
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("🎉 Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            let savedCards = dictionaryArray.map { (dictionary) -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraOne: dictionary["extraOne"]!, extraTwo: dictionary["extraTwo"]!)
            }
            
            flashcards.append(contentsOf: savedCards)
        }
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

