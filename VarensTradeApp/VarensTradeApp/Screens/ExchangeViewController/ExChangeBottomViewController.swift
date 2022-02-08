//
//  ExChangeBottomViewController.swift
//  VarensTradeApp
//
//  Created by Obeisun Timothy on 07/02/2022.
//

import UIKit
import SwiftCharts

class ExChangeBottomViewController: BottomPopupViewController {

    @IBOutlet weak var currencyTableView: UITableView!
    var dataSource: UITableViewDiffableDataSource<Section, CurrencyModel>!
    var currencyArr: [CurrencyModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCurrencyTableView()
        setupDataSource()
        setupCurrencyArr()
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupCurrencyTableView() {
        currencyTableView.register(UINib(nibName: ExchangeTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ExchangeTableViewCell.identifier)
    }
    
    private func setupCurrencyArr() {
        currencyArr = [CurrencyModel(logo: "btc", coin: "btc".uppercased(), coinColor: "VarenOrange"), CurrencyModel(logo: "eth", coin: "eth".uppercased(), coinColor: "VarensEthColor"), CurrencyModel(logo: "xrp", coin: "xrp".uppercased(), coinColor: "VarensXrpColor"), CurrencyModel(logo: "ltc", coin: "ltc".uppercased(), coinColor: "VarensEthColor")]
        self.updateDataSource()
    }
    
    override var popupHeight: CGFloat { return  view.frame.size.height - 70 }
    
    override var popupTopCornerRadius: CGFloat { return CGFloat(25) }
    
    override var popupPresentDuration: Double { return 0.30 }
    
    override var popupDismissDuration: Double { return 0.30 }
    
    override var popupShouldDismissInteractivelty: Bool { return true }
    
    override var popupDimmingViewAlpha: CGFloat { return 0.5 }
}


extension ExChangeBottomViewController: UITableViewDelegate {
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: currencyTableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeTableViewCell.identifier, for: indexPath) as? ExchangeTableViewCell
            if indexPath.row % 2 == 1 {
                cell?.cellCurrencyView.mainBackground.backgroundColor = .clear
            }
            cell?.currency = self.currencyArr[indexPath.row]
            return cell
        })
    }
    
    private func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CurrencyModel>()
        snapshot.appendSections([.first])
        snapshot.appendItems(currencyArr)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
}
