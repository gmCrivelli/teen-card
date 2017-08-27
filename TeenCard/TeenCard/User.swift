//
//  User.swift
//  TeenCard
//
//  Created by Yasmin Nogueira Spadaro Cropanisi on 26/08/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import UIKit
import CloudKit

class User: NovoCartaoPortador {
    
    //private(set) static var shared = User()
    // Cloudkit Record
    var record: CKRecord!
    var id: Int?
    var name: String?
    var lastName: String?
    var phone: String?
    var Cards: [Card]?
    var email:String?
    
   // private override init() {
     //   super.init()
   // }
    /// receive the person record and load its informations
    ///
    /// - Parameter record: person record in the database
    init(email: String) {
        super.init()
        self.email = email
        
    }
    
    init(withRecord record: CKRecord) {
        super.init()
        self.record = record
        self.id = record["id"] as? Int ?? 0
        self.name = record["name"] as? String
        self.email = record["email"] as? String
        self.lastName = record["lastName"] as? String
        self.phone = record["phone"] as? String
        self.cpf = record["phone"] as? String
        self.dataNascimento = record["dateOfBirth"] as? Date
        
    }
}
