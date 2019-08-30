//
//  File.swift
//  PeopleAndAppleStockPrices
//
//  Created by Angela Garrovillas on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct Users: Codable {
    let results: [InfoWrapper]
    
    static func getUsers(from data: Data) -> [InfoWrapper] {
        do {
            let users = try JSONDecoder().decode(Users.self, from: data)
            return users.results
        } catch {
            print(error)
        }
        return [InfoWrapper]()
    }
}

func alphabetizeUsers(users: [InfoWrapper]) -> [InfoWrapper] {
    return users.sorted(by: {$0.getFullName() < $1.getFullName()})
}

struct InfoWrapper: Codable {
    let name: Name
    let location: Location
    let email: String
    let phone: String
    let nat: String
    let picture: Picture
    
    func getFullName() -> String {
        return name.first + " " + name.last
    }
    func getFullNameUppercased() -> String {
        return name.first.firstUppercased + " " + name.last.firstUppercased
    }
}
struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct Location: Codable {
    let street: String
    let city: String
    let state: String
}

struct Picture: Codable {
    let medium: String
}

extension StringProtocol {
    var firstUppercased: String {
        return prefix(1).uppercased()  + dropFirst()
    }
    var firstCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }
}
