//
//  MemoStore+CoreDataProperties.swift
//  CoreDataTest
//
//  Created by ShinokiRyosei on 2016/05/06.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MemoStore {

    @NSManaged var date: NSDate?
    @NSManaged var memo: String?

}
