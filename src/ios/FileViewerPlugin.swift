//
//  FileViewerPlugin.swift
//  FileViewer Test
//
//  Created by Carlos Correa on 27/01/2021.
//

import Foundation
import PDFKit

class FileViewerPlugin {
   
    var fileViewerPreview: FileViewerPreview?
    var fileViewerOpenDocument: FileViewerOpenDocument?
    let rootViewController:UIViewController
    
    init(viewController:UIViewController) {
        self.rootViewController = viewController
    }
    
    func openDocumentFromLocalPath(url:String) throws {
        guard !url.isEmpty else { throw FileViewerErrors.invalidEmptyURL }
        
        if let filePath = URL.init(string: url) {
            guard FileManager.default.fileExists(atPath: filePath.path) else { throw FileViewerErrors.fileDoesNotExist }
            
            let fileViewerOpenDocument = FileViewerOpenDocument(viewController: rootViewController)
            try fileViewerOpenDocument.openDocumentFromLocalPath(url: filePath)
        }

    }
    
    func openDocumentFromUrl(url:String) throws {
        guard url.isValidUrl() else { throw FileViewerErrors.invalidURL }
        
        if let fileUrl = URL(string: url) {
            let fileViewerOpenDocument = FileViewerOpenDocument(viewController: rootViewController)
            try fileViewerOpenDocument.openDocumentFromUrl(url: fileUrl)
        } else {
            throw FileViewerErrors.couldNotOpenDocument
        }
    }
    
    func previewDocumentFromUrl(url:String) throws {
        guard url.isValidUrl() else { throw FileViewerErrors.invalidURL}
        
        if let fileUrl = URL(string: url) {
            let fileViewerPreview = FileViewerPreview(viewController: rootViewController)
            try fileViewerPreview.previewDocumentFromUrl(url: fileUrl)
        } else {
            throw FileViewerErrors.couldNotOpenDocument
        }
    }
    
    func previewDocumentFromLocalPath(url:String) throws {
        guard !url.isEmpty else { throw FileViewerErrors.invalidEmptyURL }
        
        if let filePath = URL.init(string: url) {
            guard FileManager.default.fileExists(atPath: filePath.path) else { throw FileViewerErrors.fileDoesNotExist }
            let fileViewerPreview = FileViewerPreview(viewController: rootViewController)
            try fileViewerPreview.previewDocumentFromLocalPath(url: filePath)
        }

    }
    
    func previewMediaContent(url:String) throws {
        guard !url.isEmpty else { throw FileViewerErrors.invalidEmptyURL }
        
        if let filePath = URL.init(string: url) {
            guard FileManager.default.fileExists(atPath: filePath.path) else { throw FileViewerErrors.fileDoesNotExist }
            let fileViewerPreview = FileViewerPreview(viewController: rootViewController)
            try fileViewerPreview.previewMediaContent(url: filePath)
        } else {
            throw FileViewerErrors.couldNotOpenDocument
        }
    }
        
}

