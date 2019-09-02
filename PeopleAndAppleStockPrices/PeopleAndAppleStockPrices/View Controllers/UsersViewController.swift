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
    @IBOutlet weak var searchBar: UISearchBar!
    var alphabetizedUsers = [InfoWrapper]()
    var users: [InfoWrapper] {
        get {
            guard let searchString = searchString else {return alphabetizedUsers}
            guard searchString != "" else {return alphabetizedUsers}
            return filterUsers(users: alphabetizedUsers, search: searchString.lowercased())
        }
    }
    var searchString: String? = nil {
        didSet {
            userTableView.reloadData()
        }
    }
    
    
    private func loadData() {
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
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? UserDetailViewController, let indexPath = userTableView.indexPathForSelectedRow else {return}
        destination.person = users[indexPath.row]
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

extension UsersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
    }
}
