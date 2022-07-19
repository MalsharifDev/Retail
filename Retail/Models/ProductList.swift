//
//  ProductList.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/16/22.
//

//import RealmSwift
//
//class ProductList: Object {
//    @objc dynamic var id = ""
//    var products = List<WritableProduct>()
//
//    override static func primaryKey() -> String? {
//        return "id"
//    }
//}
//
//class WritableProduct: Object {
//    @objc dynamic var id = ""
//    @objc dynamic var sku = ""
//    @objc dynamic var name = ""
//    @objc dynamic var brand = ""
//    @objc dynamic var price = 0
//    @objc dynamic var originalPrice = -1
//    var badges = List<String>()
//    @objc dynamic var image = ""
//
//    override static func primaryKey() -> String? {
//        return "id"
//    }
//}
//
//extension WritableProduct {
//
//    convenience init(
//        id: String = "",
//        sku: String = "",
//        name: String = "",
//        brand: String = "",
//        price: Int = 0,
//        originalPrice: Int = -1,
//        badges: List<String> = List<String>(),
//        image: String = ""
//    ) {
//        self.init()
//
//        self.id = id
//        self.sku = sku
//        self.name = name
//        self.brand = brand
//        self.price = price
//        self.originalPrice = originalPrice
//        self.image = image
//        self.badges = badges
//    }
//
//}
//
//extension Array where Element == Product {
//
//    var writableFormat: ProductList {
//        let list = ProductList()
//
//        for product in self {
//            let writableProduct = WritableProduct(
//                id: product.id,
//                sku: product.sku,
//                name: product.name,
//                brand: product.brand,
//                price: product.price,
//                image: product.image
//            )
//
//            let stringBadges = product.badges.map { $0.rawValue }
//            writableProduct.badges.append(objectsIn: stringBadges)
//            writableProduct.originalPrice = product.originalPrice == nil ? -1 : product.originalPrice ?? 0
//
//            list.products.append(writableProduct)
//        }
//
//        return list
//    }
//
//}
//
//extension Array where Element == WritableProduct {
//
//    var readableFormat: [Product] {
//        var array: [Product] = []
//
//        for product in self {
//            let badges: [Product.Badge] = product.badges.toArray().compactMap { Product.Badge(rawValue: $0) }
//            let originalPrice = product.originalPrice == -1 ? nil : product.originalPrice
//
//            let product = Product(
//                id: product.id,
//                sku: product.sku,
//                name: product.name,
//                brand: product.brand,
//                price: product.price,
//                originalPrice: originalPrice,
//                badges: badges,
//                image: product.image
//            )
//
//            array.append(product)
//        }
//
//        return array
//    }
//
//}
//
//extension RealmCollection {
//
//    func toArray<T>() -> [T] {
//        return self.compactMap{$0 as? T}
//    }
//
//}
//
//extension Results {
//    var list: List<Element> {
//        reduce(.init()) { list, element in
//            list.append(element)
//            return list
//        }
//    }
//}
