//
//  ViewController.swift
//  PercentageGraph
//
//  Created by Naga Divya Bobbara on 06/09/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var barGraphView : BarGraphView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        barGraphView.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 500)
       
        barGraphView.dataEntries = [
        BarEntry(percentage: 30, subjectName: "MAT", status: "Average"),
        BarEntry(percentage: 100, subjectName: "PHY", status: "Weak"),
        BarEntry(percentage: 80, subjectName: "CHEM", status: "Average"),
        BarEntry(percentage: 80, subjectName: "SCI", status: "Strong"),
        BarEntry(percentage: 90, subjectName: "BIO", status: "Strong")
        ]

//        view.addSubview(barGraphView)
    }
    

}

