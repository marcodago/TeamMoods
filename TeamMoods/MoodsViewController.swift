//
//  MoodsViewController.swift
//  TeamMoods
//
//  Created by Marco D'Agostino on 10/12/2019.
//  Copyright © 2019 com.ibm.cio.be.MD.TeamMoods. All rights reserved.
//

import UIKit
import PMAlertController

class MoodsViewController: UIViewController {
    
    var country = String()
    var dept = String()

    @IBOutlet var buttonGreen: UIButton!
    @IBAction func buttonGreenpressed(_ sender: UIButton) {
        
        leaveComment(iconValue: "G")
    }
    
    @IBOutlet var buttonYellow: UIButton!
    @IBAction func buttonYellowpressed(_ sender: UIButton) {
        
        leaveComment(iconValue: "Y")
    }
    
    @IBOutlet var buttonRed: UIButton!
    @IBAction func buttonRedpressed(_ sender: UIButton) {
        
        leaveComment(iconValue: "R")
    }

    func leaveComment (iconValue: String) {
        
        let alertVC = PMAlertController(title: "Many thanks for letting us what do you think about provided service.", description: nil, image: UIImage(named: "moodmarbles.png"), style: .walkthrough)
        
        alertVC.headerViewTopSpaceConstraint.constant = 20
        alertVC.alertContentStackViewLeadingConstraint.constant = 20
        alertVC.alertContentStackViewTrailingConstraint.constant = 20
        alertVC.alertContentStackViewTopConstraint.constant = 20
        alertVC.alertActionStackViewLeadingConstraint.constant = 20
        alertVC.alertActionStackViewTrailingConstraint.constant = 20
        alertVC.alertActionStackViewTopConstraint.constant = 20
        alertVC.alertActionStackViewBottomConstraint.constant = 20
        alertVC.view.layoutIfNeeded()
        
        let actionSubmit = PMAlertAction(title: "Submit comment", style: .default) { ()
            print("Submit comment")
            
            let firstTextField = alertVC.textFields[0] as UITextField?
            let secondTextField = alertVC.textFields[0] as UITextField?
            var allComments: [String] = []
            var allIconsComments: [String] = []
            
            allComments.append((firstTextField!.text!))
            
            let comment = firstTextField?.text
            
            if iconValue == "G" {
                secondTextField!.text = "G"
            }
            
            if iconValue == "Y" {
                secondTextField!.text = "Y"
            }
            
            if iconValue == "R" {
                secondTextField!.text = "R"
            }
            
            allIconsComments.append((secondTextField?.text!)!)
            
            self.country = String( UserDefaults.standard.string(forKey: "storedcountry")!)
            self.dept = String( UserDefaults.standard.string(forKey: "storeddept")!)
            
            let payload = "&country=\(self.country)&dept=\(self.dept)&mood=\(iconValue)&comment=\(comment!)"
            
            self.LoadJSONtoCloudantDB(payload: payload)
            print("comment:\(String(describing: firstTextField?.text))")
        }
        
        let actionCancel = PMAlertAction(title: "Cancel your feedback", style: .cancel) { () in
            print("Cancel")
        }
        
        alertVC.addTextField { (textField) in
            textField?.placeholder = "Leave your comment..."
        }
        alertVC.addAction(actionCancel)
        alertVC.addAction(actionSubmit)
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func LoadJSONtoCloudantDB(payload:String) {
        
        let signature = "mdago_v2.0_iOS"
        let tipo = "DEPT-MOODMARBLE"
        
        let keyValues = "signature=\(signature)&type=\(tipo)" + payload
        
        let url:URL = URL(string: "https://thinkdeskmoods.mybluemix.net/moods")!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url as URL)
        
        request.httpMethod = "POST"
        
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = keyValues
        
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) in
            
            guard let _:Data = data as Data?, let _:URLResponse = response  , error == nil else {
                
                print("error")
                return
            }
            
            let dataString = String(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            
            print(dataString!)
            
        }
        
        task.resume()
        
    }
}
