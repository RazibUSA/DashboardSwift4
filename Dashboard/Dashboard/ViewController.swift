//
//  ViewController.swift
//  Dashboard
//
//  Created by Mollick, Md Razib Uddin on 2/23/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var barView: BarChartView!
    weak var axisFormateDelegate:IAxisValueFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        axisFormateDelegate = self
        
        self.barView.layer.borderWidth = 2
        self.barView.layer.borderColor = UIColor.orange.cgColor
         updateChartWithData()
        
        let tap = UITapGestureRecognizer(target: self, action: Selector(("handleTap:")))
        //tap.delegate = self
        barView.addGestureRecognizer(tap)
        barView.isUserInteractionEnabled = true
    }


    @IBAction func AddDataCliecked(_ sender: Any) {
        
        if let value = textField.text , value != "" {
            let visitorCount = VisitorCountModel()
            visitorCount.count = (NumberFormatter().number(from: value)?.intValue)!
            visitorCount.save()
            textField.text = ""
        }
        updateChartWithData()
    }
    
    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        let visitorCounts = getVisitorCountsFromDatabase()
        for i in 0..<visitorCounts.count {
            
            let timeIntervalForDate:TimeInterval = visitorCounts[i].date.timeIntervalSince1970
            
            let dataEntry = BarChartDataEntry(x: Double(timeIntervalForDate), y: Double(visitorCounts[i].count))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Visitor count")
        let chartData = BarChartData(dataSet: chartDataSet)
        barView.data = chartData
        
        let x_Axis = barView.xAxis
        x_Axis.valueFormatter = axisFormateDelegate
        barView.xAxis.labelPosition = .bottom
        barView.backgroundColor = UIColor.lightGray
        barView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
    }
    
    func getVisitorCountsFromDatabase() -> Results<VisitorCountModel> {
        do {
            let realm = try Realm()
            return realm.objects(VisitorCountModel.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("Hello World")
        let gridViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GridViewController_ID") as! GridViewController
        gridViewController.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        self.present(gridViewController, animated: true) {
            print("Launch Grid")
        }
    }
    
    
}

// MARK: axisFormatDelegate
extension ViewController: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm.ss"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}

