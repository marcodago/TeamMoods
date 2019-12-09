//
//  SettingsViewController.swift
//  TeamMoods
//
//  Created by Marco D'Agostino on 10/12/2019.
//  Copyright © 2019 com.ibm.cio.be.MD.TeamMoods. All rights reserved.
//

import UIKit
import Foundation
import PMAlertController

class SettingsViewController: UIViewController, UITextFieldDelegate, NSURLConnectionDelegate {
    
    @IBOutlet var country: UITextField!
    @IBOutlet var dept: UITextField!

    

    @IBOutlet weak var mybutton: UIButton!
    
    @IBAction func saveSettings(_ sender: Any) {
        UserDefaults.standard.set(country.text!, forKey: "storedcountry")
        UserDefaults.standard.set(dept.text!, forKey: "storeddept")
        UserDefaults.standard.synchronize()
        
        let alertVC = PMAlertController(title: "Thanks", description: "The profile setup for the THINKDESK site has been completed.", image: UIImage(named: "moodmarbles.png"), style: .walkthrough)
        
        alertVC.headerViewTopSpaceConstraint.constant = 20
        alertVC.alertContentStackViewLeadingConstraint.constant = 20
        alertVC.alertContentStackViewTrailingConstraint.constant = 20
        alertVC.alertContentStackViewTopConstraint.constant = 20
        alertVC.alertActionStackViewLeadingConstraint.constant = 20
        alertVC.alertActionStackViewTrailingConstraint.constant = 20
        alertVC.alertActionStackViewTopConstraint.constant = 20
        alertVC.alertActionStackViewBottomConstraint.constant = 20
        alertVC.view.layoutIfNeeded()
        
        let actionSubmit = PMAlertAction(title: "OK", style: .default) { ()
            print("Submit comment")
        }
        
        alertVC.addAction(actionSubmit)
        self.present(alertVC, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.string(forKey: "storedcountry") != nil {

            country.text! = String( UserDefaults.standard.string(forKey: "storedcountry")!)
            dept.text! = String( UserDefaults.standard.string(forKey: "storeddept")!)
        
            country.delegate = self
            dept.delegate = self
         }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if UserDefaults.standard.string(forKey: "storedcountry") != nil {
            
            country.text! = String( UserDefaults.standard.string(forKey: "storedcountry")!)
            dept.text! = String( UserDefaults.standard.string(forKey: "storeddept")!)
            
            country.delegate = self
            dept.delegate = self
        }
    }
    
    // Funzione per far "sparire" la tastiera se utente clicca su un punto dela view diverso da textfield
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
