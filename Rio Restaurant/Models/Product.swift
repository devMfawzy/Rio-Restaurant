//
//  Product.swift
//  Rio Restaurant
//
//  Created by Mohamed Fawzy on 19/02/2021.
//

import CoreData

class Product: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case name, price, image, categoryId
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "Product", in: context) else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(entity: entity, insertInto: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.price = try container.decode(Double.self, forKey: .price)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        if let categoryId = decoder.userInfo[.category] as? String {
            self.categoryId = categoryId
        }
        try context.save()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
        try container.encode(image, forKey: .image)
        try container.encode(categoryId, forKey: .categoryId)
    }
    
    static func products(category: String, count: Int, page: Int) -> [Product] {
        let context = CoreDataManager.shared.managedObjectContext
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        fetchRequest.fetchLimit = count
        fetchRequest.fetchOffset = (page-1)*count
        let predicate = NSPredicate(format: "categoryId == %@", category)
        fetchRequest.predicate = predicate
        guard let result = try? context.fetch(fetchRequest) else {
            return []
        }
        return result
    }
    
}
