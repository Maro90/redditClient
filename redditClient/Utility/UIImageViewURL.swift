//
//  UIImageViewURL.swift
//  redditClient
//
//  Created by Mauro Gonzalez on 5/7/17.
//  Copyright © 2017 Mauro Gonzalez. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

var imageRequestKey = "Alamofire.ImageView.Request"

func setAssociatedObject(_ object: AnyObject!, key: UnsafeRawPointer, value: AnyObject!){
    objc_setAssociatedObject(object, key, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
}

func associatedObject(_ object: AnyObject!, key: UnsafeRawPointer) -> AnyObject! {
    return objc_getAssociatedObject(object, key) as AnyObject!
}

final class ImageCache : NSCache<AnyObject, AnyObject> {
    class var sharedInstance : ImageCache {
        struct Static {
            static let instance : ImageCache = ImageCache()
        }
        return Static.instance
    }
}

extension UIImageView {
    public var request: Alamofire.Request? {
        get {
            return associatedObject(self, key: &imageRequestKey) as! Alamofire.Request?
        }
        set {
            setAssociatedObject(self, key: &imageRequestKey, value: newValue)
        }
    }
    
    public func imageURL(_ url:String, placeholder: UIImage? = nil, handler: @escaping (Bool) -> Void){
        self.request?.cancel()
        self.request = nil
        self.image = placeholder
        if let cachedImage = ImageCache.sharedInstance.object(forKey: url as AnyObject) as? UIImage {
            self.image = cachedImage
            handler(true)
        } else {
            self.request = Alamofire.request(url).validate().responseData(completionHandler: { (data) in
                if let image = UIImage(data: data.data!, scale: UIScreen.main.scale) {
                    ImageCache.sharedInstance.setObject(image, forKey: url as AnyObject)
                    self.image = image
                    handler(true)
                } else {
                    handler(false)
                }
                
            })
        }
    }
    
    public func imageURL(_ url:String, placeholder: UIImage? = nil){
        self.request?.cancel()
        self.request = nil
        self.image = placeholder
        if let cachedImage = ImageCache.sharedInstance.object(forKey: url as AnyObject) as? UIImage {
            self.image = cachedImage
        } else {
            self.request = Alamofire.request(url).validate().responseData(completionHandler: { (data) in
                if let image = UIImage(data: data.data!, scale: UIScreen.main.scale) {
                    ImageCache.sharedInstance.setObject(image, forKey: url as AnyObject)
                    self.image = image
                }
            })
        }
    }
}
