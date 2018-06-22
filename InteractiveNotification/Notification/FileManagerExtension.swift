//
//  FileManagerExtension.swift
//  InteractiveNotification
//
//  Created by Mathews on 21/06/18.
//  Copyright © 2018 experion. All rights reserved.
//

import Foundation

extension FileManager {
    
    /// Saves an image from a url to the disk
    ///
    /// - Parameter urlString: url of image
    /// - Returns: file path of the saved image
    static func saveImageFrom(urlString: String) -> URL? {
        if let url = URL(string: urlString) {
            guard let imageData = try? Data(contentsOf: url) else {
                return nil
            }
            let folderName = ProcessInfo.processInfo.globallyUniqueString
            let folderUrl = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(folderName, isDirectory: true)
            do {
                try self.default.createDirectory(at: folderUrl!, withIntermediateDirectories: true, attributes: nil)
                let fileUrl = folderUrl?.appendingPathComponent(url.lastPathComponent)
                try imageData.write(to: fileUrl!, options: [])
                return fileUrl
            } catch let error {
                print(error)
            }
        }
        return nil
    }
}
