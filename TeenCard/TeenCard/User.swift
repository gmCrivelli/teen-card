//
//  User.swift
//  TeenCard
//
//  Created by Yasmin Nogueira Spadaro Cropanisi on 26/08/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import UIKit

class User: NovoCartaoPortador {
    
    private(set) static var shared = User()
    var id: Int?
    var name: String?
    var lastName: String?
    var phone: String?
    var dateOfBirth: Date?
    var Cards: [Card]?
    var email:String?
    var CPF:String?
    
    private override init() {
        super.init()
    }
    
}
