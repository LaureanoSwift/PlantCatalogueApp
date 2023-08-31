//
//  PlantModel2+CoreDataProperties.swift
//  PlantCatalogue
//
//  Created by Laureano Velasco on 14/08/2023.
//
//

import Foundation
import CoreData


extension PlantModel2 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlantModel2> {
        return NSFetchRequest<PlantModel2>(entityName: "PlantModel2")
    }

    @NSManaged public var luz: String?
    @NSManaged public var nickname: String?
    @NSManaged public var plantImage: Data?
    @NSManaged public var plantName: String?
    @NSManaged public var riego: String?
    @NSManaged public var sustrato: String?

}

extension PlantModel2 : Identifiable {

}
