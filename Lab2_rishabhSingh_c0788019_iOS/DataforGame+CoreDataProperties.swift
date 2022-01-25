//
//  DataforGame+CoreDataProperties.swift
//  TicTacToe-template
//
//  Created by Rishabh Singh on 24/01/22.
//  Copyright © 2022 mohammadkiani. All rights reserved.
//
//

import Foundation
import CoreData


extension DataforGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataforGame> {
        return NSFetchRequest<DataforGame>(entityName: "DataforGame")
    }

    @NSManaged public var gamer: Int16
    @NSManaged public var gameActive: Bool
    @NSManaged public var counting: Int16
    @NSManaged public var scoreCross: Int16
    @NSManaged public var scoreNought: Int16
    @NSManaged public var lastButtonPosition: Int16
    @NSManaged public var recordInput:[NSNumber]

}

extension DataforGame : Identifiable {

}
