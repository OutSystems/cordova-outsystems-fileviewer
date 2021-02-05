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
    
    func previewMediaContent(filePath:String) throws {
        guard !filePath.isEmpty else { throw FileViewerErrors.invalidEmptyURL }
        
        if let file = URL.init(string: filePath) {
            guard FileManager.default.fileExists(atPath: file.path) else { throw FileViewerErrors.fileDoesNotExist }
            
            if let viewController = rootViewController {
                let fileViewerPreview = FileViewerPreview(viewController: viewController)
                try fileViewerPreview.previewMediaContent(filePath: file)
            }
        } else {
            throw FileViewerErrors.couldNotOpenDocument
        }
    }
    
}

