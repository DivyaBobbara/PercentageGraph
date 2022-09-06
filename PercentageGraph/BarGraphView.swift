//
//  BarGraphView.swift
//  PercentageGraph
//
//  Created by Naga Divya Bobbara on 06/09/22.
//

import UIKit
class BarGraphView:UIView{
        private let scrollView : UIScrollView = UIScrollView()
        let space: CGFloat = 40.0
        let barWidth: CGFloat = 40.0
        let contentSpace: CGFloat = 250
        var yAxisValues = [100,80,60,40,20]
        var dataEntries : [BarEntry] = [] {
            didSet{
                 scrollView.contentSize = CGSize(width:
                                                    barWidth + space * CGFloat(dataEntries.count) + contentSpace, height: self.frame.height)
                for i in 0..<dataEntries.count{
                    showEntry(index:i , entry:dataEntries[i])
                }
            }
        }
        override init(frame: CGRect){
           super.init(frame: frame)
           setupView()
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        private func setupView(){
           addSubview(scrollView)
        }
        func showEntry(index:Int,entry:BarEntry){
            let xPos = space + CGFloat(index) * (barWidth + space)
            let yPos = translateWidthVal(value: Float(entry.percentage)/Float(100.0))
            barGraph(xPos: xPos, yPos: yPos,index:index)
            
            drawTitle(xPos: xPos, yPos: scrollView.contentSize.height - 50 , width: 150.0, height:
           40.0, title: entry.subjectName)
            drawTextValue(xPos: xPos, yPos:scrollView.contentSize.height - yPos - 100, textValue: "\(entry.percentage)")
            drawXAxis(xPos: 0, yPos: scrollView.contentSize.height - 50, width: scrollView.contentSize.width, height: 1)
//            print(self.frame.height,"height")
            drawYAxis(xPos: 45, yPos:0 , width: 1, height: self.frame.height)
            
  
        }

        func displayYAxisValues(xPos:CGFloat,yPos:CGFloat,width:CGFloat,height:CGFloat,value:Int){
            
            let label = UILabel()
            label.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
            label.text = "\(value)%"
            self.addSubview(label)
            
        }
        func drawYAxis(xPos:CGFloat,yPos:CGFloat,width:CGFloat,height:CGFloat){
            let yAxisLine = UIView()
            yAxisLine.frame = CGRect(x: xPos, y: yPos, width:width, height: height)
            yAxisLine.backgroundColor = .gray
            self.addSubview(yAxisLine)
            
        }
        func drawXAxis(xPos:CGFloat,yPos:CGFloat,width:CGFloat,height:CGFloat){
            let xAxisLine = UIView()
            xAxisLine.frame = CGRect(x: xPos, y: yPos, width:width, height: height)
            xAxisLine.backgroundColor = .gray
            scrollView.addSubview(xAxisLine)
        }
        
        private func drawTitle(xPos: CGFloat, yPos: CGFloat, width: CGFloat, height: CGFloat = 22, title: String) {
//            print("pos",xPos,yPos)
          let label = UILabel()
            label.text = title
            label.frame = CGRect(x: xPos, y: yPos, width: 100, height: 50)
            scrollView.addSubview(label)
        }
        private func drawTextValue(xPos: CGFloat, yPos: CGFloat, textValue: String){
            let label = UILabel()
              label.text = textValue
              label.frame = CGRect(x: xPos, y: yPos, width: 100, height: 50)
              scrollView.addSubview(label)
        }
        func translateWidthVal(value : Float) -> CGFloat{
            let height = CGFloat(value) * (self.frame.height - 50)
            return abs(height)
        }
        func barGraph(xPos:CGFloat,yPos:CGFloat,index:Int){
            let button = UIButton()
            button.frame = CGRect(x: xPos, y: self.frame.height - 50 - yPos, width: barWidth, height: yPos)
//            button.backgroundColor = .red
            if(dataEntries[index].status == "Weak"){
                button.backgroundColor = .systemRed
            }
            else if(dataEntries[index].status == "Average"){
                button.backgroundColor = .systemOrange
            }
            else{
                button.backgroundColor = .systemGreen
            }
        
            button.tag = index
            button.addTarget(self, action: #selector(didClick), for: .touchUpInside)
            button.layer.cornerRadius = 20
            button.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            scrollView.addSubview(button)
        }
        
        override func layoutSubviews() {
            scrollView.frame = CGRect(x: 45, y: 0, width: frame.size.width,
            height: frame.size.height)
            var startPoint = CGPoint(x: 0, y: 0)
            for i in 0..<yAxisValues.count{
                displayYAxisValues(xPos: startPoint.x, yPos:startPoint.y, width: 50, height: 20,value:yAxisValues[i])
                startPoint.y = startPoint.y + ((self.frame.height - 50)/5)
//                print(startPoint)
                
            }
            
            let xAxisTitle = UILabel()
            xAxisTitle.frame = CGRect(x: scrollView.contentSize.width/2, y: self.frame.height + 5, width: 80, height: 30)
            xAxisTitle.text = "Subjects"
            self.addSubview(xAxisTitle)
            
            
            
            
         
            
            let status = ["Weak","Average","Strong"]
            let circleColor  = [UIColor.systemRed,UIColor.systemOrange,.systemGreen]
            var statusInfoStartingPoint = CGPoint(x: 40, y: self.frame.height + 50)
            
            
            
            for i in 0..<status.count{
                displayInfo(xPos: statusInfoStartingPoint.x, yPos: statusInfoStartingPoint.y, width: 20, height: 20, statusVal: status[i],circleColor:circleColor[i])
                statusInfoStartingPoint.x += 120
            }
            
           
        }
    
    func displayInfo(xPos:CGFloat,yPos:CGFloat,width:CGFloat,height:CGFloat,statusVal:String,circleColor:UIColor){
        let roundedButton = UIButton()
        roundedButton.frame = CGRect(x: xPos, y: yPos, width:width , height: height)
        roundedButton.layer.cornerRadius = 10
        roundedButton.backgroundColor = circleColor
        self.addSubview(roundedButton)
        
        
        
        
        let label = UILabel()
        label.frame = CGRect(x: xPos+30, y: yPos, width: width+60, height: height)
        label.text = statusVal
        self.addSubview(label)
        
    }
    @objc func didClick(sender:UIButton){
            print("Tapped,\(sender.tag)")
    }
        
       
    }

