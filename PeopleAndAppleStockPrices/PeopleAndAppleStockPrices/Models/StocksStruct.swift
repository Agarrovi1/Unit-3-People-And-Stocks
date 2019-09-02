//
//  StocksStruct.swift
//  PeopleAndAppleStockPrices
//
//  Created by Angela Garrovillas on 9/2/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct APPLStocks: Codable {
    let date: String
    let uClose: Double
    let uOpen: Double
    let close: Double
    let open: Double
    let label: String
    
    func getStocks(from data: Data) -> [APPLStocks] {
        do {
            let stocksFromJSON = try JSONDecoder().decode([APPLStocks].self, from: data)
            return stocksFromJSON
        } catch {
            print(error)
        }
        return [APPLStocks]()
    }
    func findDiffOfOpenAndClose() -> Double {
        return open - close
    }
}
func getMonth(from date: String) -> String {
    var month = String()
    for (index,a) in date.enumerated() {
        if index == 5 || index == 6 {
            month += "\(a)"
        }
    }
    return month
}
func getYear(from date: String) -> String {
    var year = String()
    for (index,a) in date.enumerated() {
        if index == 0 || index == 1 || index == 2 || index == 3 {
            year += "\(a)"
        }
    }
    return year
}

func separateByMonthAndYear(from stock: [APPLStocks]) -> [[APPLStocks]] {
    var currentMonth = getMonth(from: stock[0].date)
    var currentYear = getYear(from: stock[0].date)
    var arrOfArr = [[APPLStocks]]()
    var currentArr = [APPLStocks]()
    for a in stock {
        let month = getMonth(from: a.date)
        let year = getYear(from: a.date)
        if month == currentMonth && year == currentYear {
            currentArr.append(a)
            currentYear = year
            currentMonth = month
        } else {
            arrOfArr.append(currentArr)
            currentArr = [APPLStocks]()
            currentArr.append(a)
            currentYear = year
            currentMonth = month
        }
    }
    arrOfArr.append(currentArr)
    return arrOfArr
}
