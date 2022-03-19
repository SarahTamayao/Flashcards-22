//
//  ViewController.swift
//  Flashcards
//
//  Created by Aijing Ma on 2022/2/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel1: UILabel!
    @IBOutlet weak var backLabel1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func updateFalshcard(question: String, answer: String){
        frontLabel1.text = question
        backLabel1.text = answer
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel1.isHidden = !frontLabel1.isHidden
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // We know the destination of the segue is the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        // We know the Navigation Controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        // We set the flashcardsController poperty to self
        creationController.flashcardsController = self
    }
    
}

