//
//  ViewController.swift
//  ChartSample
//
//  Created by Aaron Hanwe LEE on 2022/05/30.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var chartView2: LineChartView!
    @IBOutlet weak var chartView3: LineChartView!
    
    let standardValue: [Double] = [0.1, -0.3, 0.2, 0.0, 0.0, 0.5, 0.0, -0.6, 0.9, 1.1, -0.8]

    override func viewDidLoad() {
        super.viewDidLoad()
        setChart(data: standardValue) // 예제
        setChart2(data: standardValue) // 로직
        setChart3(data: standardValue) // 하드코딩버전
    }
    
    func setChart(data: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<self.standardValue.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: standardValue[i])
            dataEntries.append(dataEntry)
        }
        let dataSet = LineChartDataSet(entries: dataEntries)
        dataSet.highlightEnabled = false // 아마도 줌..?
        dataSet.drawCirclesEnabled = false // 엔티티의 동그라미 뷰
        dataSet.drawValuesEnabled = false // 엔티티 값
        dataSet.setColor(.brown) // 라인색
        dataSet.fillColor = .brown // 채움색
        dataSet.fillAlpha = 1
        dataSet.drawFilledEnabled = true // 채울껀지 아닌지
        
        
        var dataEntries2: [ChartDataEntry] = []
        for i in 0..<self.standardValue.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: standardValue[i])
            dataEntries2.append(dataEntry)
        }
        let dataSet2 = LineChartDataSet(entries: dataEntries2)
        dataSet2.highlightEnabled = false // 아마도 줌..?
        dataSet2.drawCirclesEnabled = false // 엔티티의 동그라미 뷰
        dataSet2.drawValuesEnabled = false // 엔티티 값
        dataSet2.setColor(.red) // 라인색
        dataSet2.fillColor = .brown // 채움색
        dataSet2.fillAlpha = 1
        dataSet2.drawFilledEnabled = true // 채울껀지 아닌지
        
        
        let chartData: LineChartData = LineChartData.init(dataSets: [dataSet, dataSet2])
        //
//        print("testValue = \(testValue)")
        
        // 데이터 셋
        chartView.backgroundColor = .lightGray
        self.chartView.data = chartData
        
        // 뷰 옵션
        self.chartView.doubleTapToZoomEnabled = false
        self.chartView.drawGridBackgroundEnabled = false
        self.chartView.xAxis.enabled = false // x축
        self.chartView.legend.enabled = false // 하단 이름
        // 왼쪽 축과 오른쪽 축을 제거하면 뒤의 y축이 다 없어진다.
        self.chartView.leftAxis.enabled = false // 왼쪽 축
        self.chartView.rightAxis.enabled = false // 오른쪽 축
        
    }
    
    func setChart2(data: [Double]) {
        let testValue = test(self.standardValue)
        let chartData: LineChartData = LineChartData.init(dataSets: testValue)
        chartView2.backgroundColor = .lightGray
        self.chartView2.data = chartData
        self.chartView2.doubleTapToZoomEnabled = false
        self.chartView2.drawGridBackgroundEnabled = false
        self.chartView2.xAxis.enabled = false // x축
        self.chartView2.legend.enabled = false // 하단 이름
        // 왼쪽 축과 오른쪽 축을 제거하면 뒤의 y축이 다 없어진다.
        self.chartView2.leftAxis.enabled = false // 왼쪽 축
        self.chartView2.rightAxis.enabled = false // 오른쪽 축
    }
    
    
    private let upColor: UIColor = .red
    private let downColor: UIColor = .blue
    private let zeroColor: UIColor = .black
    
    private func test(_ inputed: [Double]) -> [ChartDataSetProtocol] {
        var returnValue: [LineChartDataSet] = []
        // [0.1, -0.3, 0.2, 0.5, -0.6, 0.9, 1.1, -0.8]
        
        var currentEntries: [ChartDataEntry]? = []
        var beforeValue: Double = 0
        if inputed.count == 0 {
            return []
        } else {
            beforeValue = inputed[0]
            currentEntries?.append(ChartDataEntry(x: 0, y: inputed[0]))
        }
        
        for i in 1..<inputed.count {
            let currentValue = inputed[i]
            if beforeValue == 0 { // 이전 값이 0인 경우
                if currentValue == 0 { // 현재 값이 0인 경우
                    currentEntries?.append(ChartDataEntry(x: Double(i), y: currentValue))
                    guard let entries = currentEntries else { continue }
                    let dataSet = getDrawDataSet(color: zeroColor, entries: entries)
                    dataSet.append(ChartDataEntry(x: Double(inputed.count - 1), y: 0))
                    returnValue.append(dataSet) // 새로운 데이터 셋 더하기
                    currentEntries = [ChartDataEntry]() // 엔트리 초기화
                    currentEntries?.append(ChartDataEntry(x: Double(i), y: 0))
                    beforeValue = currentValue // beforeValue 변경
                } else {
                    currentEntries?.append(ChartDataEntry(x: Double(i), y: currentValue))
                    beforeValue = currentValue // beforeValue 변경
                }
            } else { // 이전값이 0이 아닌 경우
                if currentValue == 0 { // 현재 값이 0인 경우
                    currentEntries?.append(ChartDataEntry(x: Double(i), y: currentValue))
                    guard let entries = currentEntries else { continue }
                    let color: UIColor = {
                        var returnValue: UIColor = .clear
                        if beforeValue > 0 {
                            returnValue = upColor
                        } else {
                            returnValue = downColor
                        }
                        return returnValue
                    }()
                    let dataSet = getDrawDataSet(color: color, entries: entries)
                    dataSet.append(ChartDataEntry(x: Double(inputed.count - 1), y: 0))
                    returnValue.append(dataSet) // 새로운 데이터 셋 더하기
                    currentEntries = [ChartDataEntry]() // 엔트리 초기화
                    currentEntries?.append(ChartDataEntry(x: Double(i), y: 0))
                    beforeValue = currentValue // beforeValue 변경
                } else {
                    if (beforeValue > 0 && currentValue > 0) || (beforeValue < 0 && currentValue < 0) { // 이전 데이터와 현재의 데이터가 똑같이 양수이거나 음수인 경우
                        currentEntries?.append(ChartDataEntry(x: Double(i), y: currentValue))
                    } else {
                        let boxColor: UIColor = {
                            var color: UIColor = .black
                            if beforeValue > 0 && currentValue < 0 { // 이전 데이터는 양수인데 현재 데이터는 음수인 경우
                                color = upColor
                            } else {
                                color = downColor
                            }
                            return color
                        }()
                        let xOffset = getXOffset(before: beforeValue, after: currentValue)
                        currentEntries?.append(ChartDataEntry(x: Double(Double(i) - xOffset), y: 0))
                        guard let entries = currentEntries else { continue }
                        let dataSet = getDrawDataSet(color: boxColor, entries: entries)
                        dataSet.append(ChartDataEntry(x: Double(inputed.count - 1), y: 0))
                        returnValue.append(dataSet) // 새로운 데이터 셋 더하기
                        currentEntries = [ChartDataEntry]() // 엔트리 초기화
                        currentEntries?.append(ChartDataEntry(x: Double(Double(i) - xOffset), y: 0))
                        currentEntries?.append(ChartDataEntry(x: Double(i), y: currentValue))
                        beforeValue = currentValue // beforeValue 변경
                    }
                }
            }
            
            if (i + 1) == inputed.count { // 마지막이면 그려주자.
                guard let entries = currentEntries else { continue }
                let color: UIColor = {
                    var returnValue: UIColor = .clear
                    if currentValue == 0 {
                        returnValue = zeroColor
                    } else if currentValue > 0 {
                        returnValue = upColor
                    } else {
                        returnValue = downColor
                    }
                    return returnValue
                }()
                let dataSet = getDrawDataSet(color: color, entries: entries)
                returnValue.append(dataSet) // 새로운 데이터 셋 더하기
                currentEntries = [ChartDataEntry]() // 엔트리 초기화
                beforeValue = currentValue // beforeValue 변경
            }
            let lineEntries = [ChartDataEntry(x: 0, y: 0), ChartDataEntry(x: Double(inputed.count - 1), y: 0)]
            let lineDataSet = getDrawDataSet(color: zeroColor, entries: lineEntries)
            returnValue.append(lineDataSet)
        }
        
        return returnValue
    }
    
    private func getDrawDataSet(color: UIColor, entries: [ChartDataEntry]) -> LineChartDataSet {
        let dataSet = LineChartDataSet(entries: entries)
        dataSet.highlightEnabled = false
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.setColor(color)
        dataSet.fillColor = color
        dataSet.fillAlpha = 1
        dataSet.drawFilledEnabled = true
        return dataSet
    }
    
    private func getXOffset(before: Double, after: Double) -> Double { // 둘다 양수 또는 음수이거나 0이 들어가는 경우는 없다고 생각
        if before > 0 && after < 0 { // 양수 -> 음수로 가능 경우
            let gap = before + after.magnitude
            return after.magnitude/gap
        } else { // 음수 -> 양수로 가는 경우
            let gap = before.magnitude + after
            return after/gap
        }
    }
    
    func setChart3(data: [Double]) {
        
        var dataEntries: [ChartDataEntry] = [ChartDataEntry(x: 0, y: 0.1), ChartDataEntry(x: 0.25, y: 0), ChartDataEntry(x: 1.6, y: 0)]
        let dataSet = LineChartDataSet(entries: dataEntries)
        dataSet.highlightEnabled = false // 아마도 줌..?
        dataSet.drawCirclesEnabled = false // 엔티티의 동그라미 뷰
        dataSet.drawValuesEnabled = false // 엔티티 값
        dataSet.setColor(.brown) // 라인색
        dataSet.fillColor = .brown // 채움색
        dataSet.fillAlpha = 1
        dataSet.drawFilledEnabled = true // 채울껀지 아닌지
        
        var dataEntries2: [ChartDataEntry] = [ChartDataEntry(x: 0.25, y: 0), ChartDataEntry(x: 1, y: -0.3), ChartDataEntry(x: 1.6, y: 0)]
        let dataSet2 = LineChartDataSet(entries: dataEntries2)
        dataSet2.highlightEnabled = false // 아마도 줌..?
        dataSet2.drawCirclesEnabled = false // 엔티티의 동그라미 뷰
        dataSet2.drawValuesEnabled = false // 엔티티 값
        dataSet2.setColor(.brown) // 라인색
        dataSet2.fillColor = .brown // 채움색
        dataSet2.fillAlpha = 1
        dataSet2.drawFilledEnabled = true // 채울껀지 아닌지
        
        
        let chartData: LineChartData = LineChartData.init(dataSets: [dataSet, dataSet2])
        
        
//        var dataEntries: [ChartDataEntry] = [ChartDataEntry(x: 0.0, y: 0.1), ChartDataEntry(x: 0.2500000000000001, y: 0)]
//        let dataSet = LineChartDataSet(entries: dataEntries)
//        dataSet.highlightEnabled = false // 아마도 줌..?
//        dataSet.drawCirclesEnabled = false // 엔티티의 동그라미 뷰
//        dataSet.drawValuesEnabled = false // 엔티티 값
//        dataSet.setColor(.brown) // 라인색
//        dataSet.fillColor = .brown // 채움색
//        dataSet.fillAlpha = 1
//        dataSet.drawFilledEnabled = true // 채울껀지 아닌지
//
//        var dataEntries2: [ChartDataEntry] = [ChartDataEntry(x: 0.2500000000000001, y: 0.0), ChartDataEntry(x: 1.0, y: -0.3), ChartDataEntry(x: 1.6, y: 0.0)]
//        let dataSet2 = LineChartDataSet(entries: dataEntries2)
//        dataSet2.highlightEnabled = false // 아마도 줌..?
//        dataSet2.drawCirclesEnabled = false // 엔티티의 동그라미 뷰
//        dataSet2.drawValuesEnabled = false // 엔티티 값
//        dataSet2.setColor(.brown) // 라인색
//        dataSet2.fillColor = .brown // 채움색
//        dataSet2.fillAlpha = 1
//        dataSet2.drawFilledEnabled = true // 채울껀지 아닌지
        
//        var dataEntries3: [ChartDataEntry] = [ChartDataEntry(x: 0.0, y: 0.1), ChartDataEntry(x: 0.2500000000000001, y: 0)]
//        let dataSet3 = LineChartDataSet(entries: dataEntries3)
//        dataSet3.highlightEnabled = false // 아마도 줌..?
//        dataSet3.drawCirclesEnabled = false // 엔티티의 동그라미 뷰
//        dataSet3.drawValuesEnabled = false // 엔티티 값
//        dataSet3.setColor(.brown) // 라인색
//        dataSet3.fillColor = .brown // 채움색
//        dataSet3.fillAlpha = 1
//        dataSet3.drawFilledEnabled = true // 채울껀지 아닌지
//
//        var dataEntries4: [ChartDataEntry] = [ChartDataEntry(x: 0.0, y: 0.1), ChartDataEntry(x: 0.2500000000000001, y: 0)]
//        let dataSet4 = LineChartDataSet(entries: dataEntries4)
//        dataSet4.highlightEnabled = false // 아마도 줌..?
//        dataSet4.drawCirclesEnabled = false // 엔티티의 동그라미 뷰
//        dataSet4.drawValuesEnabled = false // 엔티티 값
//        dataSet4.setColor(.brown) // 라인색
//        dataSet4.fillColor = .brown // 채움색
//        dataSet4.fillAlpha = 1
//        dataSet4.drawFilledEnabled = true // 채울껀지 아닌지
//
//        var dataEntries5: [ChartDataEntry] = [ChartDataEntry(x: 0.0, y: 0.1), ChartDataEntry(x: 0.2500000000000001, y: 0)]
//        let dataSet5 = LineChartDataSet(entries: dataEntries5)
//        dataSet5.highlightEnabled = false // 아마도 줌..?
//        dataSet5.drawCirclesEnabled = false // 엔티티의 동그라미 뷰
//        dataSet5.drawValuesEnabled = false // 엔티티 값
//        dataSet5.setColor(.brown) // 라인색
//        dataSet5.fillColor = .brown // 채움색
//        dataSet5.fillAlpha = 1
//        dataSet5.drawFilledEnabled = true // 채울껀지 아닌지
//
//        var dataEntries6: [ChartDataEntry] = [ChartDataEntry(x: 0.0, y: 0.1), ChartDataEntry(x: 0.2500000000000001, y: 0)]
//        let dataSet6 = LineChartDataSet(entries: dataEntries6)
//        dataSet6.highlightEnabled = false // 아마도 줌..?
//        dataSet6.drawCirclesEnabled = false // 엔티티의 동그라미 뷰
//        dataSet6.drawValuesEnabled = false // 엔티티 값
//        dataSet6.setColor(.brown) // 라인색
//        dataSet6.fillColor = .brown // 채움색
//        dataSet6.fillAlpha = 1
//        dataSet6.drawFilledEnabled = true // 채울껀지 아닌지
        
//        let chartData: LineChartData = LineChartData.init(dataSets: [dataSet, dataSet2, dataSet3, dataSet4, dataSet5, dataSet6])
        //
//        print("testValue = \(testValue)")
        
        // 데이터 셋
        chartView3.backgroundColor = .lightGray
        self.chartView3.data = chartData
    }


}
