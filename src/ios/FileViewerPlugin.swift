//
//  FileViewerPlugin.swift
//  FileViewer Test
//
//  Created by Carlos Correa on 27/01/2021.
//

import Foundation
import UIKit

class FileViewerPlugin {
   
    var fileViewerPreview: FileViewerPreview?
    var fileViewerOpenDocument: FileViewerOpenDocument?
    var rootViewController:UIViewController?
    
    func openDocumentFromLocalPath(filePath:String) throws {
        guard !filePath.isEmpty else { throw FileViewerErrors.invalidEmptyURL }
        
        if let file = URL.init(string: filePath) {
            guard FileManager.default.fileExists(atPath: file.path) else { throw FileViewerErrors.fileDoesNotExist }
            
            if let viewController = rootViewController {
                let fileViewerOpenDocument = FileViewerOpenDocument(viewController: viewController)
                try fileViewerOpenDocument.openDocumentFromLocalPath(filePath: file)
            }
        }

    }
    
    func openDocumentFromUrl(url:String, completion: @escaping (_ inner: ErrorCompletionHandler) -> Void) {
        guard url.isValidUrl() else {
            return completion({ throw FileViewerErrors.invalidURL })
        }
        
        if let fileUrl = URL(string: url), let viewController = rootViewController {
            let fileViewerOpenDocument = FileViewerOpenDocument(viewController: viewController)
            fileViewerOpenDocument.openDocumentFromUrl(url:fileUrl, completion: { (inner: ErrorCompletionHandler) -> Void in
                do {
                    _ = try inner()
                } catch {
                    completion({ throw error })
                }
            })
        }

    }
    
    func previewDocumentFromUrl(url:String, completion: @escaping (_ inner: ErrorCompletionHandler) -> Void) {
        guard url.isValidUrl() else {
            return completion({ throw FileViewerErrors.invalidURL })
        }
        
        let fileViewerPreview = FileViewerPreview(viewController: rootViewController!)
        fileViewerPreview.previewDocumentFromUrl(url:URL(string: url)!, completion: { (inner: ErrorCompletionHandler) -> Void in
            do {
                _ = try inner()
            } catch {
                completion({ throw error })
            }
        })
    }
    
    func previewDocumentFromLocalPath(filePath:String) throws {
        guard !filePath.isEmpty else { throw FileViewerErrors.invalidEmptyURL }
        
        if let file = URL.init(string: filePath) {
            guard FileManager.default.fileExists(atPath: file.path) else { throw FileViewerErrors.fileDoesNotExist }

            if let viewController = rootViewController {
                let fileViewerPreview = FileViewerPreview(viewController: viewController)
                try fileViewerPreview.previewDocumentFromLocalPath(filePath: file)
            }
        }

    }
    
    func previewMediaContentFromLocalPath(filePath:String) throws {
        guard !filePath.isEmpty else { throw FileViewerErrors.invalidEmptyURL }
        
        if let file = URL.init(string: filePath) {
            guard FileManager.default.fileExists(atPath: file.path) else { throw FileViewerErrors.fileDoesNotExist }
            
            if let viewController = rootViewController {
                let fileViewerPreview = FileViewerPreview(viewController: viewController)
                try fileViewerPreview.previewMediaContent(url: file)
            }
        } else {
            throw FileViewerErrors.couldNotOpenDocument
        }
    }

    func previewMediaContentFromUrl(url:String) throws {
        guard url.isValidUrl() else { throw FileViewerErrors.invalidURL }
        
        if let fileUrl = URL(string: url), let viewController = rootViewController {
            let fileViewerPreview = FileViewerPreview(viewController: viewController)
            try fileViewerPreview.previewMediaContent(url: fileUrl)
        }
    }
    
    func openDocumentFromResources(fileName: String, ext: String) throws {
        guard !fileName.isEmpty && !ext.isEmpty else { throw FileViewerErrors.emptyFileName }
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: ext, inDirectory: "www/resources") else { throw FileViewerErrors.fileDoesNotExist }
            let url:URL = URL.init(fileURLWithPath: filePath)
            guard FileManager.default.fileExists(atPath: url.path) else { throw FileViewerErrors.fileDoesNotExist }
            if let viewController = rootViewController {
                let fileViewerOpenDocument = FileViewerOpenDocument(viewController: viewController)
                try fileViewerOpenDocument.openDocumentFromLocalPath(filePath: url)
            }
    }
    
    func previewDocumentFromResources(fileName: String, ext: String) throws {
        guard !fileName.isEmpty && !ext.isEmpty else { throw FileViewerErrors.emptyFileName }
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: ext, inDirectory: "www/resources") else { throw FileViewerErrors.fileDoesNotExist }
            let url:URL = URL.init(fileURLWithPath: filePath)
            guard FileManager.default.fileExists(atPath: url.path) else { throw FileViewerErrors.fileDoesNotExist }
            if let viewController = rootViewController {
                let fileViewerPreview = FileViewerPreview(viewController: viewController)
                try fileViewerPreview.previewDocumentFromLocalPath(filePath: url)
            }
    }
    
    func previewMediaContentFromResources(fileName: String, ext: String) throws {
        guard !fileName.isEmpty && !ext.isEmpty else { throw FileViewerErrors.emptyFileName }
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: ext, inDirectory: "www/resources") else { throw FileViewerErrors.fileDoesNotExist }
            let url:URL = URL.init(fileURLWithPath: filePath)
            guard FileManager.default.fileExists(atPath: url.path) else { throw FileViewerErrors.fileDoesNotExist }
            if let viewController = rootViewController {
                let fileViewerPreview = FileViewerPreview(viewController: viewController)
                try fileViewerPreview.previewMediaContent(url: url)
            }
    }
    
}

