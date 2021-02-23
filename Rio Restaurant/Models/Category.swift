//
//  Category.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 19/02/2021.
//

import CoreData

class Category: NSManagedObject, Codable {
    
    enum CodingKeys: CodingKey {
      case id, name, products
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "Category", in: context) else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(entity: entity, insertInto: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        try context.save()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
    static func categories(count: Int, page: Int) -> [Category] {
        let context = CoreDataManager.shared.managedObjectContext
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.fetchLimit = count
        fetchRequest.fetchOffset = (page-1)*count
        guard let result = try? context.fetch(fetchRequest) else {
            return []
        }
        return result
    }
    
    static func category(id: String) -> Category? {
        let context = CoreDataManager.shared.managedObjectContext
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.fetchLimit = 1
        let predicate = NSPredicate(format: "id = %@", id)
        fetchRequest.predicate = predicate
        guard let result = try? context.fetch(fetchRequest) else {
            return nil
        }
        return result.first
    }
    
}
