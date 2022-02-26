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

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel1.isHidden = true
    }
    
}

