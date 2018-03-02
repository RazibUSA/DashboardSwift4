//
//  VisitorCountModel.swift
//  Dashboard
//
//  Created by Mollick, Md Razib Uddin on 2/23/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import Foundation
import RealmSwift

class VisitorCountModel: Object {
    @objc dynamic var date: Date = Date()
    @objc dynamic var count: Int = Int(0)
    
    
    func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}
