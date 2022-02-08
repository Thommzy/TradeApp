//
//  ChartViewController.swift
//  VarensTradeApp
//
//  Created by Obeisun Timothy on 05/02/2022.
//

import UIKit
//import Charts
import SnapKit
import SwiftCharts

class ChartViewController: UIViewController {
    
    
    @IBOutlet weak var statTableView: UITableView!
    @IBOutlet weak var buyBtn: VarensButton!
    @IBOutlet weak var sellBtn: VarensButton!
    @IBOutlet weak var aboutSectionConst: NSLayoutConstraint!
    @IBOutlet weak var tbvConst: NSLayoutConstraint!
    @IBOutlet weak var aboutTextView: UITextView!
    var dataSource: UITableViewDiffableDataSource<Section, StatModel>!
    var statMarketArray: [StatModel] = []
    @IBOutlet weak var barChartParentView: UIView!
    
    @IBOutlet weak var twentyFourhrsBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var allBtn: UIButton!
    @IBOutlet weak var oneWeekBtn: UIButton!
    @IBOutlet weak var oneMonthBtn: UIButton!
    @IBOutlet weak var oneYearBtn: UIButton!
    @IBOutlet weak var currencySingleView: CurrencyView!
    fileprivate var chart: Chart? // arc
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSellBtn()
        setupBuyBtn()
        setupStatTableView()
        setupDataSource()
        setupStatMarketArray()
        setupAboutSectionConst()
        setupChart()
        setupCurrencySingleView()
        setupChangeBtnDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTableviewOberver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeTableviewObserver()
    }
    
    func setupChangeBtnDelegate() {
        currencySingleView.delegate = self
    }
    
    func setupCurrencySingleView() {
        let image = UIImage(named: "btc")
        currencySingleView.currencyImageView.image = image
        self.currencySingleView.amountsView.isHidden = true
    }
    
    func setupChart() {
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        let readFormatter = DateFormatter()
        readFormatter.dateFormat = "dd.MM.yyyy"
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "EEE"
        
        let date = {(str: String) -> Date in
            return readFormatter.date(from: str)!
        }
        
        let calendar = Calendar.current
        
        _ = {(day: Int, month: Int, year: Int) -> Date in
            var components = DateComponents()
            components.day = day
            components.month = month
            components.year = year
            return calendar.date(from: components)!
        }
        
        
        func filler(_ date: Date) -> ChartAxisValueDate {
            let filler = ChartAxisValueDate(date: date, formatter: displayFormatter)
            filler.hidden = true
            return filler
        }
        let dates = getDates(forLastNDays: 16)
        
        let chartPoints = [
            ChartPointCandleStick(date: date(dates[0]), formatter: displayFormatter, high: 0, low: 0, open: 0, close: 0),
            ChartPointCandleStick(date: date(dates[1]), formatter: displayFormatter, high: 1620, low: 1380, open: 1520, close: 1400),
            ChartPointCandleStick(date: date(dates[2]), formatter: displayFormatter, high: 1640, low: 1430, open: 1600, close: 1515),
            ChartPointCandleStick(date: date(dates[3]), formatter: displayFormatter, high: 1495, low:  1605, open: 1510, close: 1570),
            ChartPointCandleStick(date: date(dates[4]), formatter: displayFormatter, high: 1560, low: 1440, open: 1540, close: 1455),
            ChartPointCandleStick(date: date(dates[5]), formatter: displayFormatter, high: 1565, low: 1370, open: 1535, close: 1400),
            ChartPointCandleStick(date: date(dates[6]), formatter: displayFormatter, high: 1480, low:  1569, open: 1485, close: 1560),
            ChartPointCandleStick(date: date(dates[7]), formatter: displayFormatter, high: 1700, low: 1545, open: 1685, close: 1555),
            ChartPointCandleStick(date: date(dates[8]), formatter: displayFormatter, high: 1600, low: 1485, open: 1590, close: 1492),
            ChartPointCandleStick(date: date(dates[9]), formatter: displayFormatter, high: 1690, low: 1590, open: 1660, close: 1600),
            ChartPointCandleStick(date: date(dates[10]), formatter: displayFormatter, high: 1590, low: 1695 , open: 1605, close: 1665),
            ChartPointCandleStick(date: date(dates[11]), formatter: displayFormatter, high: 1780, low: 1630, open: 1740, close: 1645),
            ChartPointCandleStick(date: date(dates[12]), formatter: displayFormatter, high: 1600, low: 1685, open: 1605, close: 1640),
            ChartPointCandleStick(date: date(dates[13]), formatter: displayFormatter, high: 1570, low:  1680, open: 1595, close: 1650),
            ChartPointCandleStick(date: date(dates[14]), formatter: displayFormatter, high: 1690, low: 1590, open: 1656, close: 1595),
            ChartPointCandleStick(date: date(dates[15]), formatter: displayFormatter, high: 0, low: 0, open: 0, close: 0)
        ]
        
        let yValues = stride(from: 1300, through: 1800, by: 100).map {ChartAxisValueDouble(Double($0), labelSettings: labelSettings)}
        let xGeneratorDate = ChartAxisValuesGeneratorDate(unit: .day, preferredDividers:5, minSpace: 1, maxTextSize: 12)
        let xLabelGeneratorDate = ChartAxisLabelsGeneratorDate(labelSettings: labelSettings, formatter: displayFormatter)
        let firstDate = date(dates[0])
        let lastDate = date(dates[15])
        let xModel = ChartAxisModel(firstModelValue: firstDate.timeIntervalSince1970, lastModelValue: lastDate.timeIntervalSince1970, axisTitleLabels: [ChartAxisLabel(text: "", settings: labelSettings)], axisValuesGenerator: xGeneratorDate, labelsGenerator: xLabelGeneratorDate)
        
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings.defaultVertical()))
        let chartFrame = ExamplesDefaults.chartFrame(CGRect(x: 0, y: 0, width: barChartParentView.frame.size.width, height: barChartParentView.frame.size.height))
        
        let chartSettings = ExamplesDefaults.chartSettings // for now zoom & pan disabled, layer needs correct scaling mode.
        
        let coordsSpace = ChartCoordsSpaceRightBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let chartPointsLineLayer = ChartCandleStickLayer<ChartPointCandleStick>(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, itemWidth: Env.iPad ? 10 : 7, strokeWidth: Env.iPad ? 1 : 0.6, increasingColor: #colorLiteral(red: 0.9438043237, green: 0.6057826877, blue: 0.4935973287, alpha: 1), decreasingColor: #colorLiteral(red: 0, green: 0.7389898896, blue: 0.6892247796, alpha: 1) )
        
        let settings = ChartGuideLinesLayerSettings(linesColor: UIColor.gray, linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, axis: .y, settings: settings)
        
        let dividersSettings =  ChartDividersLayerSettings(linesColor: UIColor.black, linesWidth: ExamplesDefaults.guidelinesWidth, start: Env.iPad ? 7 : 3, end: 0)
        let dividersLayer = ChartDividersLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: dividersSettings)
        
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                dividersLayer,
                chartPointsLineLayer
            ]
        )
        
        barChartParentView.addSubview(chart.view)
        chart.view.snp.makeConstraints { make in
            make.top.equalTo(barChartParentView)
            make.bottom.equalTo(barChartParentView)
            make.left.equalTo(barChartParentView)
            make.right.equalTo(barChartParentView)
        }
        self.chart = chart
    }
    
    func getDates(forLastNDays nDays: Int) -> [String] {
        let cal = NSCalendar.current
        // start with today
        var date = cal.startOfDay(for: Date())
        
        var arrDates = [String]()
        
        for _ in 1 ... nDays {
            // move back in time by one day:
            date = cal.date(byAdding: Calendar.Component.day, value: 1, to: date)!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let dateString = dateFormatter.string(from: date)
            arrDates.append(dateString)
        }
        return arrDates
    }
    
    private func setupAboutSectionConst() {
        let height = aboutTextView.contentSize.height
        aboutSectionConst.constant = height + 60
        aboutTextView.sizeToFit()
    }
    
    private func setupStatMarketArray() {
        statMarketArray = [StatModel(icon: "market_cap", title: "Market Cap", price: "41,228.00 BTC"), StatModel(icon: "volume", title: "Volume (24 h)", price: "$12,999.00"), StatModel(icon: "supply", title: "Available Supply", price: "9,771.64")]
        self.updateDataSource()
    }
    
    private func setupStatTableView() {
        statTableView.register(UINib(nibName: StatTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: StatTableViewCell.identifier)
    }
    
    private func setupBuyBtn() {
        buyBtn.setupCustomStyle(backgroundColor: #colorLiteral(red: 0.04705882353, green: 0.6941176471, blue: 0.6274509804, alpha: 1), title: "Buy", titleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), fontSize: 20)
    }
    
    private func setupSellBtn() {
        sellBtn.setupCustomStyle(backgroundColor: #colorLiteral(red: 0.9438043237, green: 0.6057826877, blue: 0.4935973287, alpha: 0.2575201956), title: "Sell", titleColor: #colorLiteral(red: 0.9438043237, green: 0.6057826877, blue: 0.4935973287, alpha: 1), fontSize: 20)
    }
    
    @IBAction func oneWeekBtnAction(_ sender: UIButton) {
        sender.isSelected = true
        oneMonthBtn.isSelected = false
        oneYearBtn.isSelected = false
        allBtn.isSelected = false
        settingsBtn.isSelected = false
        twentyFourhrsBtn.setTitleColor(#colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7215686275, alpha: 1), for: .normal)
    }
    @IBAction func oneMonthBtnAction(_ sender: UIButton) {
        sender.isSelected = true
        oneYearBtn.isSelected = false
        allBtn.isSelected = false
        settingsBtn.isSelected = false
        oneWeekBtn.isSelected = false
        twentyFourhrsBtn.setTitleColor(#colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7215686275, alpha: 1), for: .normal)
    }
    
    @IBAction func oneYearBtnAction(_ sender: UIButton) {
        sender.isSelected = true
        oneMonthBtn.isSelected = false
        oneWeekBtn.isSelected = false
        allBtn.isSelected = false
        settingsBtn.isSelected = false
        twentyFourhrsBtn.setTitleColor(#colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7215686275, alpha: 1), for: .normal)
    }
    
    @IBAction func allBtnAction(_ sender: UIButton) {
        sender.isSelected = true
        oneMonthBtn.isSelected = false
        oneWeekBtn.isSelected = false
        settingsBtn.isSelected = false
        oneYearBtn.isSelected = false
        twentyFourhrsBtn.setTitleColor(#colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7215686275, alpha: 1), for: .normal)
    }
    
    @IBAction func settingsBtnAction(_ sender: UIButton) {
        sender.isSelected = true
        oneMonthBtn.isSelected = false
        oneWeekBtn.isSelected = false
        oneYearBtn.isSelected = false
        allBtn.isSelected = false
        twentyFourhrsBtn.setTitleColor(#colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7215686275, alpha: 1), for: .normal)
    }
    
    @IBAction func twentyFourhrsBtnAction(_ sender: UIButton) {
        oneMonthBtn.isSelected = false
        oneWeekBtn.isSelected = false
        oneYearBtn.isSelected = false
        allBtn.isSelected = false
        settingsBtn.isSelected = false
        twentyFourhrsBtn.setTitleColor(#colorLiteral(red: 0, green: 0.7389898896, blue: 0.6892247796, alpha: 1), for: .normal)
    }
    
}

extension ChartViewController: ChangeBtnDelegate {
    func changeBtnTapped() {
        let exchangeVc = ExchangeViewController(nibName: "ExchangeViewController", bundle: nil)
        exchangeVc.modalPresentationStyle = .fullScreen
        self.present(exchangeVc, animated: true, completion: nil)
    }
}

//MARK: - Tableview Observer
extension ChartViewController {
    
    private func addTableviewOberver() {
        self.statTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
    }
    
    private func removeTableviewObserver() {
        
        if self.statTableView.observationInfo != nil {
            self.statTableView.removeObserver(self, forKeyPath: "contentSize")
        }
    }
    
    /**
     This method is used to observeValue in table view.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UITableView {
            if obj == self.statTableView && keyPath == "contentSize" {
                self.tbvConst.constant = self.statTableView.contentSize.height
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }
        }
    }
}

extension ChartViewController: UITableViewDelegate {
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: statTableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: StatTableViewCell.identifier, for: indexPath) as? StatTableViewCell
            if indexPath.row % 2 == 0 {
                cell?.contentView.backgroundColor = UIColor(named: "cellBackgroundColor")
            }
            cell?.stat = self.statMarketArray[indexPath.row]
            return cell
        })
    }
    
    private func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, StatModel>()
        snapshot.appendSections([.first])
        snapshot.appendItems(statMarketArray)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
