//
//  FileDownloader.swift
//  FileViewer Test
//
//  Created by Carlos Correa on 28/01/2021.
//

import Foundation

typealias ErrorCompletionHandler = () throws -> FileViewerErrors
typealias URLCompletionHandler = () throws -> URL

class FileDownloader {
    
    static func downloadFile(url: URL , completion: @escaping (_ success: Bool, _ inner: URLCompletionHandler) -> Void) -> Void {
        let itemUrl = url
        let documentsDirectoryURL = FileManager.default.temporaryDirectory
        let fileExtension = url.pathExtension
        let fileName = url.deletingPathExtension().lastPathComponent
        let destinationUrl = documentsDirectoryURL
            .appendingPathComponent(fileName)
            .appendingPathExtension(fileExtension)
    
        if FileManager.default.fileExists(atPath: destinationUrl.path) {
            completion(true, { return destinationUrl })
        } else {
            URLSession.shared.downloadTask(with: itemUrl, completionHandler: { (location, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        guard let tempLocation = location, error == nil else { return }
                        do {
                            try FileManager.default.moveItem(at: tempLocation, to: destinationUrl)
                            completion(true, { return destinationUrl } )
                        } catch {
                            completion(false, { throw FileViewerErrors.downloadFailed })
                        }
                    } else {
                        completion(false, { throw FileViewerErrors.downloadFailed })
                    }
                }
            }).resume()
        }
    }
}
