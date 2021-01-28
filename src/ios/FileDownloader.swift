//
//  FileDownloader.swift
//  FileViewer Test
//
//  Created by Carlos Correa on 28/01/2021.
//

import Foundation

class FileDownloader {
    static func downloadfile(url: URL ,completion: @escaping (_ success: Bool,_ fileLocation: URL?) -> Void){
        let itemUrl = url
        let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationUrl = documentsDirectoryURL.appendingPathComponent("filename.pdf")
    
        if FileManager.default.fileExists(atPath: destinationUrl.path) {
            completion(true, destinationUrl)
        } else {
            URLSession.shared.downloadTask(with: itemUrl, completionHandler: { (location, response, error) -> Void in
                guard let tempLocation = location, error == nil else { return }
                do {
                    try FileManager.default.moveItem(at: tempLocation, to: destinationUrl)
                    completion(true, destinationUrl)
                } catch let error as NSError {
                    print(error.localizedDescription)
                    completion(false, nil)
                }
            }).resume()
        }
    }
}