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
    
    let value: [Double] = [0.1, -0.3, 0.2, 0.5, -0.6, 0.9, 1.1, -0.8]

    override func viewDidLoad() {
        super.viewDidLoad()
        setChart(data: value)
    }
    
    
    func setChart(data: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<self.value.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: value[i])
            dataEntries.append(dataEntry)
        }
        let dataSet = LineChartDataSet(entries: dataEntries)
        dataSet.highlightEnabled = false // 아마도 줌..?
        dataSet.drawCirclesEnabled = false // 엔티티의 동그라미 뷰
        dataSet.drawValuesEnabled = false // 엔티티 값
        dataSet.setColor(.red) // 라인색
        dataSet.fillColor = .red // 채움색
        dataSet.fillAlpha = 1.0
        dataSet.drawFilledEnabled = true // 채울껀지 아닌지
        let chartData = LineChartData(dataSet: dataSet)
        
        // 데이터 셋
        self.chartView.data = chartData
        
        // 뷰 옵션
        self.chartView.doubleTapToZoomEnabled = false
        self.chartView.drawGridBackgroundEnabled = false
        self.chartView.xAxis.enabled = false // x축
        self.chartView.legend.enabled = false // 하단 이름
        // 왼쪽 축과 오른쪽 축을 제거하면 뒤의 y축이 다 없어진다.
        self.chartView.leftAxis.enabled = false // 왼쪽 축
        self.chartView.rightAxis.enabled = false // 오른쪽 축
        
        
//        self.chartView.setViewPortOffsets(left: 0, top: 0, right: 0, bottom: 0)
    }
    


}

//TODO)
// 선 색 변경
// 백그라운드 선 제거
// 색칠하기
// 중간중간 0 껴넣기?

