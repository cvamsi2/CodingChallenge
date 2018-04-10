//
//  CustomImageView.swift
//  ChannelsCodingChallenge
//
//  Created by Vamsi Chebolu on 4/8/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation
import UIKit

/* Caching images for performance */
let imageCache = NSCache<NSString, UIImage>()
class CustomImageView: UIImageView {
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        imageUrlString = urlString
        guard let url = URL(string: urlString) else { return }
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        // Configure SessionManager and download the Image
        let conf = BackendConfiguration(baseURL: url)
        let sessionManager = SessionManager(conf)
        sessionManager.requestDataWithURL { [weak self] (data, response, error) in
            guard error == nil, let imageData = data else {
                return
            }
            DispatchQueue.main.async {
                if let imageToCache = UIImage(data: imageData) {
                    if self?.imageUrlString == urlString {
                        self?.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: urlString as NSString)
                }
            }
        }
    }
}
