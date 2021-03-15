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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if (frontLabel.isHidden != true) {
            frontLabel.isHidden = true
        } else {
            frontLabel.isHidden = false
        }
    }
    
    func updateFlashcard(question: String, answer: String){
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
    }
}

