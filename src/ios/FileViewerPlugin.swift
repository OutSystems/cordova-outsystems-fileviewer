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
    
    func openDocumentFromLocalPath(url:URL) throws {
        guard url.path.isEmpty else { throw FileViewerErrors.invalidEmptyURL }
        guard FileManager.default.fileExists(atPath: url.path) else { throw FileViewerErrors.fileDoesNotExist }
        let fileViewerOpenDocument = FileViewerOpenDocument(viewController: rootViewController)
        try fileViewerOpenDocument.openDocumentFromLocalPath(url: url)
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
    
    func previewDocumentFromLocalPath(url:URL) throws {
        guard url.path.isEmpty else { throw FileViewerErrors.invalidEmptyURL }
        guard FileManager.default.fileExists(atPath: url.path) else { throw FileViewerErrors.fileDoesNotExist }
        
        let fileViewerPreview = FileViewerPreview(viewController: rootViewController)
        try fileViewerPreview.previewDocumentFromLocalPath(url: url)
    }
    
    func previewMediaContent(url:URL) throws {
        let fileViewerPreview = FileViewerPreview(viewController: rootViewController)
        try fileViewerPreview.previewMediaContent(url: url)
    }
    
}

