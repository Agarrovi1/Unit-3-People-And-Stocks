//
//  UserDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Angela Garrovillas on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    
    var person: InfoWrapper?
    var pic = UIImage() {
        didSet {
            userImageView.image = pic
        }
    }
    private func loadPic() {
        guard let person = person else {return}
        do {
            guard let imageUrl = URL(string: person.picture.large) else {return}
            let data = try Data(contentsOf: imageUrl)
            let image = UIImage(data: data)
            userImageView.image = image
        } catch {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let person = person else {return}
        nameLabel.text = person.getFullNameUppercased()
        emailLabel.text = person.email
        nationalityLabel.text = "Nat: \(person.nat)"
        phoneLabel.text = person.phone
        loadPic()
    }

}
