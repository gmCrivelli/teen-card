//
//  User.swift
//  TeenCard
//
//  Created by Yasmin Nogueira Spadaro Cropanisi on 26/08/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var id: Int
    var name: String
    var lastName: String
    var phone: String
    var dateOfBirth: Date
    var Cards: [Card]
    var email:String
    var CPF:String

}