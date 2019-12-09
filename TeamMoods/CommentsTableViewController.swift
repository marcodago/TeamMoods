//
//  CommentsTableViewController.swift
//  TeamMoods
//
//  Created by Marco D'Agostino on 10/12/2019.
//  Copyright © 2019 com.ibm.cio.be.MD.TeamMoods. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController {
    
    @IBOutlet var myTable: UITableView!
    
    var marble: [String] = []
    var feedback: [String] = []
    var arrImageName: [String] = ["green_smiley.png", "yellow_smiley.png", "red_smiley.png"]
    var jsonArray: [String] = []
    
    var country = String()
    var dept = String ()
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.myTable.delegate = self
        self.myTable.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let firstUse = UserDefaults.standard.object(forKey: "storedcountry")
        
        if firstUse != nil {
            
            self.country = String( UserDefaults.standard.string(forKey: "storedcountry")!)
            self.dept = String( UserDefaults.standard.string(forKey: "storeddept")!)
            
            GetJSONfromCloudantDB ()
            
        }
    }
    
    func GetJSONfromCloudantDB () {
        
        let postEndpoint: String = ("https://0887ad8a-8f0b-4aec-b8fc-bf66958c007a-bluemix:b044033ceb27472f0c349ac201473b760f3e3f1f360d19209f37e860118ff9bd@0887ad8a-8f0b-4aec-b8fc-bf66958c007a-bluemix.cloudant.com/comments/_all_docs?include_docs=true")
        
        let url = NSURL(string: postEndpoint)!
        
        let now = Date()
        let oneMonthAgo = now.addingTimeInterval(-1 * 30 * 24 * 60 * 60) as Date

        do {
            let allCommentsData = try Data(contentsOf: url as URL)
            
            
            let jsonArray = try JSONSerialization.jsonObject(with: allCommentsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            
            
            if let myjsonArray = jsonArray["rows"] as? [[String: Any]] {
                
                marble = []
                feedback = []
                
                if myjsonArray.count > 0 {
                    for index in 0...myjsonArray.count-1 {
                        
                        let record = myjsonArray[index] as [String : AnyObject]
                        
                        let myDate = record["doc"]?["date"] as! String
                        
                        //***************************************************
                        let dateComponents = myDate.components(separatedBy: "T")
                        let dateOnly = dateComponents[0]
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        dateFormatter.locale = Locale(identifier: "en_US")
                        let dateOfRecord = dateFormatter.date(from: dateOnly)
                        //***************************************************
                        
                        if dateOfRecord! > oneMonthAgo {
                            
                            if country == record["doc"]?["country"] as? String {
                                
                                if dept == record["doc"]?["dept"] as? String {
                                    
                                    if let moodmarble = record["doc"]?["mood"] {
                                        marble.append(moodmarble as! String)
                                    }
                                    if let userfeedback = record["doc"]?["comment"] {
                                        feedback.append(userfeedback as! String)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.myTable?.reloadData()
            }
        }
        catch {
        // error handling code if needed
        }
    }
    
    override func numberOfSections(in Mytable: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(country) - \(dept)"
    }
    
    override func tableView(_ myTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedback.count
    }
    
    override func tableView(_ myTable: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.white
        }
    }
    
    override func tableView(_ Mytable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "myCell")! as! CustomTableViewCell
        
        cell.feedback?.text = feedback[indexPath.row]
        
        if marble[indexPath.row] == "G" {
            cell.marble?.image = UIImage(named:arrImageName[0])
        }
        if marble[indexPath.row] == "Y" {
            cell.marble?.image = UIImage(named:arrImageName[1])
        }
        if marble[indexPath.row] == "R" {
            cell.marble?.image = UIImage(named:arrImageName[2])
        }
        return cell
    }
}
