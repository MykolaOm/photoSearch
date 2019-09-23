//
//  FileManager.swift
//  searchPhoto
//
//  Created by Nikolas Omelianov on 9/22/19.
//  Copyright © 2019 Nikolas Omelianov. All rights reserved.
//

import Foundation
import UIKit

class FileManagerHelper {
    class func write(fileName:String, image: UIImage) -> URL?{
        do {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsURL.appendingPathComponent("\(fileName).png")
            if let pngImageData = image.pngData() {
                try pngImageData.write(to: fileURL, options: .atomic)
                return fileURL
            }
        } catch { }
        return nil
    }
    class func read(fileName: String) -> UIImage? {
        var image : UIImage?
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentsURL.appendingPathComponent("\(fileName).png").path
        if FileManager.default.fileExists(atPath: filePath) {
            image = UIImage(contentsOfFile: filePath)
        }
        return image
    }
}
