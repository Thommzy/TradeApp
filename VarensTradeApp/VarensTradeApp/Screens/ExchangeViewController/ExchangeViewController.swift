//
//  ExchangeViewController.swift
//  VarensTradeApp
//
//  Created by Obeisun Timothy on 07/02/2022.
//

import UIKit

class ExchangeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        displayCard()
    }
    
    private func displayCard() {
        print("show na")
        let storyBoard: UIStoryboard = UIStoryboard(name: "ExChangeBottomCard", bundle: nil)
        let exchangeBottomCardVc = storyBoard.instantiateViewController(withIdentifier: "ExChangeBottomViewController") as! ExChangeBottomViewController
        self.present(exchangeBottomCardVc, animated: true, completion: nil)
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
