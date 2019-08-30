//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    @IBOutlet weak var userTableView: UITableView!
    var alphabetizedUsers = [InfoWrapper]()
    var users: [InfoWrapper] {
        get {
            return alphabetizedUsers
        }
    }
    
    
    func loadData() {
        guard let pathToData = Bundle.main.path(forResource: "userinfo", ofType: ".json") else {return}
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            let people = Users.getUsers(from: data)
            let alphabetized = alphabetizeUsers(users: people)
            alphabetizedUsers = alphabetized
        } catch {
            print(error)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        userTableView.dataSource = self
    }
    
    
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let person = users[indexPath.row]
        cell.textLabel?.text = person.getFullNameUppercased()
        cell.detailTextLabel?.text = person.getFullAddress()
        return cell
    }
    
    
}
