//
//  ViewController.swift
//  Flashcards
//
//  Created by Aijing Ma on 2022/2/26.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel1: UILabel!
    @IBOutlet weak var backLabel1: UILabel!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var card: UIView!
    
    // array to hold our flashcards
    var flashcards = [Flashcard]()
    
    // current flashcard index
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //read saved flashcards
        readSavedFlashcards()
        
        //adding our initial flashcard if needed
        if flashcards.count == 0{
            updateFalshcard(question: "How are you?", answer: "I'm feeling good!")
        }else{
            updateLabels()
            updateNextPrevButtons()
        }
        
    }

    func updateFalshcard(question: String, answer: String){
        let flashcard = Flashcard(question: question, answer: answer)
        
        //adding flashcard in the flashcards array
        flashcards.append(flashcard)
        
        //logging into the console
        print("Added new flashcard")
        print("We now have\(flashcards.count) flashcards")
        
        //update current index
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        
        //update buttons
        updateNextPrevButtons()
        
        //update lables
        updateLabels()
        
        //store flashcards
        saveAllFalshcardsToDisk()
    }
    
    func updateNextPrevButtons(){
        //disable next button if at the end
        if currentIndex == flashcards.count - 1{
            nextButton.isEnabled = false
        } else{
            nextButton.isEnabled = true
        }
        //disable prev button if at the beginning
        if currentIndex == 0{
            prevButton.isEnabled = false
        }else{
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels(){
        //get current flashcards
        let currentFlashcard = flashcards[currentIndex]
        
        //update labels
        frontLabel1.text = currentFlashcard.question
        backLabel1.text = currentFlashcard.answer
    }
    
    func saveAllFalshcardsToDisk(){
        //from flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String:String] in return ["question":card.question, "answer":card.answer]
        }
        
        //set array on disk using userDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        //log it
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards(){
        //read dictionary array from disk(if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            
            //in here we know for sure we have a dictionary array
            let savedCards = dictionaryArray.map{ dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer:dictionary["answer"]!)
            }
            //  put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    func animateCardOut(){
        UIView.animate(withDuration:0.3,animations:{
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        },completion: {finished in
            //update labels
            self.updateLabels()
            
            //run out animation
            self.animateCardIn()
        })
    }
    
    func animateCardIn(){
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        UIView.animate(withDuration:0.3){
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    
    func flipFlashcard(){
        frontLabel1.isHidden = !frontLabel1.isHidden
        UIView.transition(with: card,duration: 0.3, options: .transitionFlipFromRight, animations:{self.frontLabel1.isHidden = true})
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        //decrease current index
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
        
        UIView.animate(withDuration: 0.3){
            self.card.transform = CGAffineTransform.identity.translatedBy(x: 300, y: 0)
        } completion:{ finished in
            self.updateLabels()
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300, y: 0)
            UIView.animate(withDuration: 0.3){
                self.card.transform = CGAffineTransform.identity
            }
        }
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        //increase current index
        currentIndex = currentIndex + 1
        updateNextPrevButtons()
        animateCardOut()
         
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

