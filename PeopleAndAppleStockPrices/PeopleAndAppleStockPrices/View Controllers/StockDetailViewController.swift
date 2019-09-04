//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Angela Garrovillas on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    
    var stock: APPLStocks?
    func positiveOrNegativeStock() -> Double {
        guard let stock = stock else {return Double()}
        return stock.open - stock.close
    }
    func loadStockPic() {
        let endOfDayResult = positiveOrNegativeStock()
        if endOfDayResult > 0 {
            thumbImageView.image = UIImage(named: "thumbsUp")
        } else {
            thumbImageView.image = UIImage(named: "thumbsDown")
        }
    }
    func changeBackground() {
        let endOfDayResult = positiveOrNegativeStock()
        if endOfDayResult > 0 {
            self.view.backgroundColor = .green
        } else {
            self.view.backgroundColor = .red
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let stock = stock else {return}
        dateLabel.text = stock.date
        openLabel.text = stock.open.description
        closeLabel.text = stock.close.description
        loadStockPic()
        changeBackground()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
