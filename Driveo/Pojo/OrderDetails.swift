//
//  OrderDetails.swift
//  Driveo
//
//  Created by Admin on 6/12/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import UIKit

final class OrderDetails {
    var title:String?
    var description: String?
    var images: [UIImage]?
    var imagesURL:[String]?
    
    init(){}
    
    init(withTitle title:String,andDescription description:String?,andImagesArray images:[UIImage]) {
        self.title=title
        self.description=description
        self.images=images
    }
    
    func getImagesInBase64() -> [Data] {
        var base64Array = [Data]()
        for img:UIImage in self.images!{
            let pngImg = UIImagePNGRepresentation(img) as! Data
            let base64Img = pngImg.base64EncodedData()
            base64Array.append(base64Img)
        }
        return base64Array
    }
    
    func isComplete() -> Bool {
        if title != nil, title?.trimmingCharacters(in: CharacterSet.whitespaces) != "" {
            return true
        }else
        {
            return false
        }
    }
}

// MARK : Encoding and Decoding
extension OrderDetails : Codable  {
    
    enum CodingKeys: String, CodingKey {
        case title = "order_title"
        case description = "order_description"
        case images = "order_images"
        case imagesURL = "order_images_urls"
    }
    
    public convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        imagesURL = try container.decode(Array<String>.self, forKey: .imagesURL)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(self.getImagesInBase64(), forKey: .images)
        try container.encode(["URL1","URL2"], forKey: .imagesURL)
    }
}
