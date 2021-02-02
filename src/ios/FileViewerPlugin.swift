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
    var fileViewerViewController: FileViewerViewController?
    let rootViewController:UIViewController
    
    init(viewController:UIViewController) {
        self.rootViewController = viewController
    }
    
    func openDocumentFromUrl(url:URL) throws {        
        let fileViewerViewController = FileViewerViewController()
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        let navigationController = UINavigationController(rootViewController: fileViewerViewController)
        navigationController.modalPresentationStyle = .fullScreen
        
        let rightBtn = UIButton(type: .system)
        rightBtn.setTitle("Close", for: .normal)
        rightBtn.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        
        let rightButton = UIBarButtonItem(customView: rightBtn)
        fileViewerViewController.navigationItem.rightBarButtonItem = rightButton
        try fileViewerViewController.openDocumentFromUrl(url: url)
        rootViewController.present(navigationController, animated: true)
        
    }
    
    func previewDocumentFromUrl(url:URL) throws {
        let fileViewerPreview = FileViewerPreview(viewController: rootViewController)
        try fileViewerPreview.openDocumentFromUrl(url: url)
    }
    
    func previewDocumentFromLocalPath(url:URL) throws {
        guard url.path.isEmpty else { throw FileViewerErrors.invalidEmptyURL }
        guard FileManager.default.fileExists(atPath: url.path) else { throw FileViewerErrors.fileDoesNotExist }
        
        let fileViewerPreview = FileViewerPreview(viewController: rootViewController)
        try fileViewerPreview.openDocumentFromLocalPath(url: url)
    }
    
    func previewMediaContent(url:URL) throws {
        
        guard url.path.isEmpty else { throw FileViewerErrors.invalidEmptyURL }
        
        let fileViewerPreview = FileViewerPreview(viewController: rootViewController)
        try fileViewerPreview.previewMediaContent(url: url)
    }
    
    @objc func closeTapped() {
        rootViewController.dismiss(animated: false, completion: nil)
    }
    
}

