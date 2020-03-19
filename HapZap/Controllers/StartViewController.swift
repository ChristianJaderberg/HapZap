//
//  StartViewController.swift
//  HapZap
//
//  Created by Christian Jäderberg on 2020-03-11.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UITextFieldDelegate {
    
    var currentQuestion = ""
    @IBOutlet weak var questionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // code needed for hiding keyboard when enter is pressed
        self.questionTextField.delegate = self
    }
    
    // hide keyboard when enter is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func hapZapButtonPressed(_ sender: Any) {
        
        if (questionTextField.text != "") {
            self.currentQuestion = self.questionTextField.text!
            
            // hide keyboard
            self.questionTextField.resignFirstResponder()
            
            // clear textfield
            self.questionTextField.text = ""
        } else {
            // create and show alert message
            let alert : UIAlertController = UIAlertController(title: "No input!", message: "Please enter a HapZap-question", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "goToHapZap",
            let destinationVC = segue.destination as? HapZapViewController
        {
            destinationVC.initQuestion = self.currentQuestion
        }
    }

}
