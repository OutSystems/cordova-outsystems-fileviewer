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
    
    func openDocumentFromLocalPath(url:String) throws {
        guard !url.isEmpty else { throw FileViewerErrors.invalidEmptyURL }
        
        if let filePath = URL.init(string: url) {
            guard FileManager.default.fileExists(atPath: filePath.path) else { throw FileViewerErrors.fileDoesNotExist }
            
            if let viewController = rootViewController {
                let fileViewerOpenDocument = FileViewerOpenDocument(viewController: viewController)
                try fileViewerOpenDocument.openDocumentFromLocalPath(url: filePath)
            }
        }

    }
    
    func openDocumentFromUrl(url:String) throws {
        guard url.isValidUrl() else { throw FileViewerErrors.invalidURL }
        
        if let fileUrl = URL(string: url), let viewController = rootViewController {
            let fileViewerOpenDocument = FileViewerOpenDocument(viewController: viewController)
            try fileViewerOpenDocument.openDocumentFromUrl(url: fileUrl)
        } else {
            throw FileViewerErrors.couldNotOpenDocument
        }
    }
    
    func previewDocumentFromUrl(url:String) throws {
        guard url.isValidUrl() else { throw FileViewerErrors.invalidURL}
        
        if let fileUrl = URL(string: url), let viewController = rootViewController {
            let fileViewerPreview = FileViewerPreview(viewController: viewController)
            try fileViewerPreview.previewDocumentFromUrl(url: fileUrl)
        } else {
            throw FileViewerErrors.couldNotOpenDocument
        }
    }
    
    func previewDocumentFromLocalPath(url:String) throws {
        guard !url.isEmpty else { throw FileViewerErrors.invalidEmptyURL }
        
        if let filePath = URL.init(string: url) {
            guard FileManager.default.fileExists(atPath: filePath.path) else { throw FileViewerErrors.fileDoesNotExist }

            if let viewController = rootViewController {
                let fileViewerPreview = FileViewerPreview(viewController: viewController)
                try fileViewerPreview.previewDocumentFromLocalPath(url: filePath)
            }
        }

    }
    
    func previewMediaContent(url:String) throws {
        guard !url.isEmpty else { throw FileViewerErrors.invalidEmptyURL }
        
        if let filePath = URL.init(string: url) {
            guard FileManager.default.fileExists(atPath: filePath.path) else { throw FileViewerErrors.fileDoesNotExist }
            
            if let viewController = rootViewController {
                let fileViewerPreview = FileViewerPreview(viewController: viewController)
                try fileViewerPreview.previewMediaContent(url: filePath)
            }
        } else {
            throw FileViewerErrors.couldNotOpenDocument
        }
    }
    
}

