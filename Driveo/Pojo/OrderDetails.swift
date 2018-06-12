//
//  OrderDetails.swift
//  Driveo
//
//  Created by Admin on 6/12/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import UIKit

class OrderDetails {
    var title:String?
    var description: String?
    var images: [UIImage]?
    var imagesURL:[String]?
    
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
