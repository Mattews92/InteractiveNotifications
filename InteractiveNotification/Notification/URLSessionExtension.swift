//
//  URLSessionExtension.swift
//  InteractiveNotification
//
//  Created by Mathews on 21/06/18.
//  Copyright © 2018 experion. All rights reserved.
//

import Foundation

extension URLSession {
    
    static func downloadImageFrom(url: String, completionHandler: @escaping (Data?) -> Void) {
        guard let imageUrl = URL(string: url) else {
            completionHandler(nil)
            return
        }
        self.shared.dataTask(with: imageUrl) { (data, response, error) in
            completionHandler(data)
        }
    }
    
}
