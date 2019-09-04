//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Angela Garrovillas on 9/2/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {
    @IBOutlet weak var stockTableView: UITableView!
    
    var stocks = [APPLStocks]()
    var separateStocks = [[APPLStocks]]() {
        didSet {
            stockTableView.reloadData()
        }
    }
    private func loadSeparateStocks() {
        separateStocks = separateByMonthAndYear(from: stocks)
    }
    private func loadData() {
        guard let pathToStockJSON = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {return}
            let url = URL(fileURLWithPath: pathToStockJSON)
        do {
            let data = try Data(contentsOf: url)
            let appleStocks = APPLStocks.getStocks(from: data)
            stocks = appleStocks
        } catch {
            print(error)
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.dataSource = self
        loadData()
        loadSeparateStocks()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? StockDetailViewController, let indexPath = stockTableView.indexPathForSelectedRow else {return}
        destination.stock = separateStocks[indexPath.section][indexPath.row]
    }

}

extension StocksViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.backgroundColor = .blue
        return separateStocks.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let currentArr = separateStocks[section]
        let month = getMonth(from: currentArr[0].date)
        let year = getYear(from: currentArr[0].date)
        let avg = findAverage(from: currentArr)
        return "M: \(month) Y: \(year) Avg: \(avg)" 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return separateStocks[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let stock = separateStocks[indexPath.section][indexPath.row]
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = "\(stock.open)"
        return cell
    }
    
    
}
