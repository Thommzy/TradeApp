//
//  ChartViewController.swift
//  VarensTradeApp
//
//  Created by Obeisun Timothy on 05/02/2022.
//

import UIKit

class ChartViewController: UIViewController {
    
    @IBOutlet weak var statTableView: UITableView!
    @IBOutlet weak var buyBtn: VarensButton!
    @IBOutlet weak var sellBtn: VarensButton!
    @IBOutlet weak var aboutSectionConst: NSLayoutConstraint!
    @IBOutlet weak var tbvConst: NSLayoutConstraint!
    @IBOutlet weak var aboutTextView: UITextView!
    var dataSource: UITableViewDiffableDataSource<Section, StatModel>!
    var statMarketArray: [StatModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSellBtn()
        setupBuyBtn()
        setupStatTableView()
        setupDataSource()
        setupStatMarketArray()
        setupAboutSectionConst()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTableviewOberver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeTableviewObserver()
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
