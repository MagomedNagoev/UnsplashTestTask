//
//  FavoritePhoto+CoreDataProperties.swift
//  
//
//  Created by Нагоев Магомед on 09.06.2022.
//
//

import Foundation
import CoreData

extension FavoritePhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritePhoto> {
        return NSFetchRequest<FavoritePhoto>(entityName: "FavoritePhoto")
    }

    @NSManaged public var authorName: String?
    @NSManaged public var createdDate: String?
    @NSManaged public var date: Date?
    @NSManaged public var downloads: String?
    @NSManaged public var idFavoritePhoto: String?
    @NSManaged public var locationName: String?
    @NSManaged public var photoData: Data?
    @NSManaged public var avatarImage: Data?

}
