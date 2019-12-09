//
//  BarChartViewController.swift
//  TeamMoods
//
//  Created by Marco D'Agostino on 10/12/2019.
//  Copyright © 2019 com.ibm.cio.be.MD.TeamMoods. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {
    
    var GREEN = 0.00
    var YELLOW = 0.00
    var RED = 0.00
    var TOTAL = 0
    var marble: [String] = []
    var date: [String] = []
    var jsonArray: [String] = []
    var country = String()
    var dept = String ()
    
    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GREEN = 0
        YELLOW = 0
        RED = 0
        TOTAL = 0
        loadMetrics()
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
                
                if myjsonArray.count > 0 {
                    for index in 0...myjsonArray.count-1 {
                        
                        let record = myjsonArray[index] as [String : AnyObject]
                        
                        if let recordDate = record["doc"]?["date"] as? String {
                            date.append(recordDate)
                            //***************************************************
                            let dateComponents = recordDate.components(separatedBy: "T")
                            let dateOnly = dateComponents[0]
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            dateFormatter.locale = Locale(identifier: "en_US")
                            let dateOfRecord = dateFormatter.date(from: dateOnly)
                            //***************************************************
                            
                            if dateOfRecord! > oneMonthAgo {
                                
                                if country == record["doc"]?["country"] as? String {
                                    
                                    if dept == record["doc"]?["dept"] as? String {
                                        
                                        let moodmarble = record["doc"]?["mood"]
                                        marble.append(moodmarble as! String)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            for i in 0..<marble.count {
                if marble[i] == "G" {
                    GREEN += 1
                    TOTAL += 1
                }
                if marble[i] == "Y" {
                    YELLOW += 1
                    TOTAL += 1
                }
                if marble[i] == "R" {
                    RED += 1
                    TOTAL += 1
                }
            }
        }
            
        catch {
            
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "No data available so far."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: (Double(i)), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Moods Values")
        chartDataSet.colors = [.green, .yellow, .red]
        let chartData = BarChartData(dataSet: chartDataSet)
        chartDataSet.valueFormatter = DefaultValueFormatter(decimals: 0)
        chartDataSet.valueColors = [.black]
        chartDataSet.valueFont = UIFont.boldSystemFont(ofSize: 16.0)
        
        barChartView.data = chartData
    }
    
    func loadMetrics() {
        let firstUse = UserDefaults.standard.object(forKey: "storedcountry")
        
        if firstUse != nil {
            
            self.country = String( UserDefaults.standard.string(forKey: "storedcountry")!)
            self.dept = String( UserDefaults.standard.string(forKey: "storeddept")!)
            
            GetJSONfromCloudantDB ()
            
            let smiley = ["Green", "Amber", "Red"]
            let numbers = [GREEN, YELLOW, RED]
            
            barChartView.animate(yAxisDuration: 2.5)
            barChartView.pinchZoomEnabled = false
            barChartView.drawBarShadowEnabled = false
            barChartView.drawBordersEnabled = false
            barChartView.doubleTapToZoomEnabled = false
            barChartView.drawGridBackgroundEnabled = false
            let  xAxisFont : XAxis = self.barChartView.xAxis
            xAxisFont.labelFont = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.black)
            barChartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.regular)
            barChartView.leftAxis.labelTextColor = .black
            barChartView.leftAxis.axisMinimum = 0
            barChartView.leftAxis.axisMaximum = Double(TOTAL)
            let legend = barChartView.legend
            legend.font = UIFont(name: "Verdana", size: 16.0)!
            barChartView.legend.enabled = false
            barChartView.legend.horizontalAlignment = .right
            barChartView.legend.verticalAlignment = .bottom
            barChartView.legend.orientation = .horizontal
            barChartView.highlighter = nil
            barChartView.rightAxis.enabled = false
            barChartView.animate(yAxisDuration: 2.5, easingOption: .easeInOutQuart)
            barChartView.xAxis.enabled = false
            
            setChart(dataPoints: smiley, values: numbers)
        }
    }
}
