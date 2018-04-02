//
//  GridViewController.swift
//  Dashboard
//
//  Created by Mollick, Md Razib Uddin on 2/26/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit
import Charts

var shouldHideData: Bool = false

class GridViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet var chartView: LineChartView!
    
//    fileprivate let dataManager = CoreDataHelper()
//    
//    fileprivate var sortedLiftEvents: [LiftEvent] = []
    
     func setUp()
    {
       
   
        
        // Sample data
        let values: [Double] = [8, 104, 81, 93, 52, 44, 97, 101, 75, 28,
                                76, 25, 20, 13, 52, 44, 57, 23, 45, 91,
                                99, 14, 84, 48, 40, 71, 106, 41, 45, 61]
        
        var entries: [ChartDataEntry] = Array()
        
        for (i, value) in values.enumerated()
        {
            entries.append(ChartDataEntry(x: Double(i), y: value, icon: UIImage(named: "icon", in: Bundle(for: self.classForCoder), compatibleWith: nil)))
        }
//
//        dataSet = LineChartDataSet(values: entries, label: "First unit test data")
//        dataSet.drawIconsEnabled = false
//        dataSet.iconsOffset = CGPoint(x: 0, y: 20.0)
//
//        chart = LineChartView(frame: CGRect(x: 0, y: 0, width: 480, height: 350))
//        chart.backgroundColor = NSUIColor.clear
//        chart.leftAxis.axisMinimum = 0.0
//        chart.rightAxis.axisMinimum = 0.0
//        chart.data = LineChartData(dataSet: dataSet)
    }
    
    
    
    
    var days: [String]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "1RM"
        
        chartView.delegate = self
        chartView.chartDescription?.enabled = false
        
        let leftAxis = chartView.leftAxis
        leftAxis.axisMinimum = 0
        leftAxis.labelTextColor = NSUIColor.white
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.axisMinimum = 0
        xAxis.granularity = 1
     //   xAxis.valueFormatter = self as! IAxisValueFormatter
        xAxis.labelTextColor = NSUIColor.white
        
        chartView.rightAxis.enabled = false // this fixed the extra xAxis grid lines
        
        chartView.backgroundColor = NSUIColor(red: 35/255.0, green: 43/255.0, blue: 53/255.0, alpha: 1.0)
        
     //   fetchData()
        
        self.updateChartData()
        
        
       // chartView.configureDefaults()
        
        chartView.setVisibleXRangeMaximum(5)
        
       // view.backgroundColor = UIColor(hexString: "232B35")
    }
    
//    private func fetchData() {
//
//        let liftEventTypeUuid = "98608870-E3CE-476A-B1E4-018D2AE4BDBF"
//
//        // get all Bench Press events
//        let liftEvents = dataManager.fetchLiftsEventsOfType(liftEventTypeUuid)
//
//        // put them into a Dictionary grouped by each unique day
//        let groupedEvents = Dictionary(grouping: liftEvents, by: { floor($0.date.timeIntervalSince1970 / 86400) })
//
//        let maxEventsPerDay = groupedEvents.map { $1.max(by: { $0.oneRepMax < $1.oneRepMax }) }
//
//        // MARK: - Fix the silly unwrapping
//        sortedLiftEvents = maxEventsPerDay.sorted(by: { $0?.date.compare(($1?.date)!) == .orderedAscending }) as! [LiftEvent]
//
//        /// 3600 = 1 hour
//        /// 1 day
//        let startingDate = sortedLiftEvents.first?.date
//        let endDate = sortedLiftEvents.last?.date
//        let intervalBetweenDates:TimeInterval = 3600 * 24
//
//        let dates:[Date] = intervalDates(from: startingDate!, to: endDate!, with: intervalBetweenDates)
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMM d"
//
//        days = dates.map{dateFormatter.string(from: $0)}
//
//    }
    
    func updateChartData() {
        if shouldHideData {
            chartView.data = nil
            return
        }
        
        self.setChartData()
        
    }
    
    func setChartData() {
        
        generateLineData()
        
    }
    
    func generateLineData() {
        
        // Sample data
        let values: [Double] = [209.0, 209.0, 246.0, 233.3333, 220.0, 234.0, 220.0, 240.0, 227.6, 239.17777,
                                234.666, 220.0, 224.0, 230.2222, 238.0, 240.0, 239.58, 230.9, 227.8, 234.77,
                                229.9, 237.99, 223.9, 229.234, 226.8, 231.23, 233.4, 238.0, 240.9, 237.5]
        
      //  var entries: [ChartDataEntry] = Array()
        
//        let entries = sortedLiftEvents.enumerated().map { (arg) -> ChartDataEntry in
//            let (index, liftEvent) = arg
//            return ChartDataEntry(x: Double(index), y: liftEvent.oneRepMax.value)
//        }
        
        let entries = values.enumerated().map { (arg) -> ChartDataEntry in
                 let (index, liftEvent) = arg
                 return ChartDataEntry(x: Double(index), y: liftEvent)
             }
        print(entries)
        
//        for (i, value) in values.enumerated()
//        {
//            entries.append(ChartDataEntry(x: Double(i), y: value, icon: UIImage(named: "icon", in: Bundle(for: self.classForCoder), compatibleWith: nil)))
//        }
        
        // style the line to be drawn
        let set = LineChartDataSet(values: entries, label: "Line DataSet")
        set.setColor(UIColor.red)
        set.lineWidth = 1.5
        set.setCircleColor((UIColor.green))
        set.circleHoleColor = UIColor(red: 35/255, green: 43/255, blue: 53/255, alpha: 1)
        set.circleRadius = 4
        set.circleHoleRadius = 2
        set.fillColor = (UIColor.gray)
        set.mode = .linear
        set.drawValuesEnabled = true
        set.valueFont = .systemFont(ofSize: 10)
        set.valueTextColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
        
        set.axisDependency = .left
        
        let data = LineChartData(dataSet: set)
        
        chartView.data = data
    }
    
    func intervalDates(from startingDate:Date, to endDate:Date, with interval:TimeInterval) -> [Date] {
        guard interval > 0 else { return [] }
        
        var dates:[Date] = []
        var currentDate = startingDate
        
        while currentDate <= endDate {
            currentDate = currentDate.addingTimeInterval(interval)
            dates.append(currentDate)
        }
        
        return dates
    }
    
    @IBAction func dismissBtmClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension GridViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let days = days else { return "" }
        
        return days[Int(20) % days.count]
    }
}

