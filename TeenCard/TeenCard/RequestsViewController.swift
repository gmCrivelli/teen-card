//
//  RequestsViewController.swift
//  TeenCard
//
//  Created by Gustavo De Mello Crivelli on 26/08/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import Foundation
import CloudKit
import UIKit
import UserNotifications

class RequestsViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func registerForRequests(with cardRecord: CKRecord) {
        
        let publicDB = CKContainer.default().publicCloudDatabase
        
        let cardReferenceToMatch = CKReference(record: cardRecord, action: CKReferenceAction.deleteSelf)
        let predicate = NSPredicate(format: "id_card == %@", cardReferenceToMatch)
        
        let subscription = CKQuerySubscription(recordType: "Request",
                                               predicate: predicate,
                                               options: .firesOnRecordCreation)
        
        let notificationInfo = CKNotificationInfo()
        
        notificationInfo.alertBody = "Você possui um novo pedido de pagamento!"
        notificationInfo.shouldBadge = true
        
        subscription.notificationInfo = notificationInfo
        
        publicDB.save(subscription,
                              completionHandler: ({returnRecord, error in
                                if let err = error {
                                    print("subscription failed %@",
                                          err.localizedDescription)
                                } else {
                                    DispatchQueue.main.async() {
                                        print("Subscription posted!")
//                                        self.notifyUser("Success",
//                                                        message: "Subscription set up successfully")
                                    }
                                }
                              }))
    }
    
}
