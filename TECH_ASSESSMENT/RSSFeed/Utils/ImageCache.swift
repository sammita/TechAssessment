//
//  ImageCache.swift
//  RSSFeed
//
//  Created by Rajesh Sammita on 13/02/20.
//  Copyright © 2020 Tech. All rights reserved.
//

// Class which handles caching of all the album images into local Cache of the device
import UIKit

class ImageCache: NSObject {
    static let sharedImageCache = ImageCache()
    private let cache = NSCache<NSString, NSData>()
    
    //Fetch the image from cache
    ///- Parameter url: url of the cached image
    func getCachedImageDataFor(url: String) -> Data?{
        if let nsData = self.cache.object(forKey: url as NSString) {
            return Data(nsData)
        }
        return nil
    }
    
    //Save the image to cache
    ///- Parameter imageData: image to cache as Data , url : URL of the image to cache
    func saveImageDataToCache(imageData: Data, url: String) {
        self.cache.setObject(NSData(data: imageData), forKey: url as NSString)
    }
}
