//
//  Lab3ChartViewController.swift
//  StriletskiyAMO
//
//  Created by Головаш Анастасия on 18.04.2020.
//  Copyright © 2020 com.Vadim. All rights reserved.
//

import UIKit
import Charts

class Lab3ChartViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var chartView: LineChartView!
    
    var valuesSegue: [ChartDataEntry]?
    var valuesSegue2: [ChartDataEntry]?
    var valuesSegueMistake: [ChartDataEntry]?
    var variantFuncsion: Bool = true
    var isShowFunc: Bool = true
    
    public var chartLineColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                /// Return the color for Dark Mode
                return .cyan
                    
            } else {
                /// Return the color for Light Mode
                return .blue
            }
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if variantFuncsion {
            self.title = "f(x) = sin(x)^3 + 3cos(x)^2"
        } else {
            self.title = "f(x) = sin(x)"
        }
        
        setupChartView()
        /// Number of for loops for theoretical value
        self.setDataCount(n: 70)
    }
    
    private func setupChartView() {
        chartView.delegate = self
        
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        
        chartView.xAxis.gridLineDashLengths = [3, 1]
        chartView.xAxis.gridLineDashPhase = 0
        chartView.xAxis.axisLineColor = UIColor.label
        chartView.xAxis.labelTextColor = UIColor.label
        
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
        
        leftAxis.gridLineDashLengths = [3, 1]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        leftAxis.axisLineColor = UIColor.label
        leftAxis.labelTextColor = UIColor.label
        
        chartView.rightAxis.enabled = false
        
        
        chartView.legend.form = .line
        chartView.legend.font =  NSUIFont(name: "Helvetica", size: 15) ?? NSUIFont()
        chartView.legend.textColor = UIColor.label
        
        chartView.animate(xAxisDuration: 2.5)
    }
    
    
    func setDataCount(n: Int) {
        
        if isShowFunc {
            guard let valuesTest = valuesSegue else { return }
            guard let valuesTeor = valuesSegue2 else { return }
            
            // First line (teoretical)
            let set1 = LineChartDataSet(entries: valuesTeor, label: "Інтерпольовані значення")
            set1.drawIconsEnabled = false
            set1.setColor(.orange)
            set1.setCircleColor(.orange)
            set1.lineWidth = 1
            set1.circleRadius = 0
            set1.drawCircleHoleEnabled = false
            set1.mode = .cubicBezier

            // Second line (test)
            let set2 = LineChartDataSet(entries: valuesTest, label: "Точні значення f(x)")
            set2.drawIconsEnabled = false
            set2.setColor(chartLineColor)
            set2.setCircleColor(chartLineColor)
            set2.lineWidth = 1
            set2.circleRadius = 0
            set2.drawCircleHoleEnabled = false
            set2.formSize = 15
            set2.mode = .cubicBezier
            
            let data = LineChartData(dataSets: [set1, set2])
            chartView.data = data
            
        } else {
            
            guard let valuesMistake = valuesSegueMistake else { return }
            
            let set3 = LineChartDataSet(entries: valuesMistake, label: "Похибка інтерполяції -lg∆n")
            set3.drawIconsEnabled = false
            set3.setColor(.blue)
            set3.setCircleColor(.blue)
            set3.lineWidth = 1
            set3.circleRadius = 0
            set3.drawCircleHoleEnabled = false
            set3.formSize = 15
            set3.mode = .cubicBezier
            
            let data = LineChartData(dataSets: [set3])
            chartView.data = data
        }
        
    }
   

}
