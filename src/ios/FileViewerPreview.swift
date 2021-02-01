//
//  FileViewerPreview.swift
//  FileViewer Test
//
//  Created by Carlos Correa on 27/01/2021.
//

import Foundation
import QuickLook
import AVKit

class FileViewerPreview {
    
    lazy var previewItem = NSURL()
    var url: URL?
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func openDocumentFromLocalPath(url:URL) throws {
        if url.absoluteString.isEmpty {
            throw FileViewerErrors.couldNotOpenDocument
        }
        DispatchQueue.main.async {
            let previewController = QLPreviewController()
            self.previewItem = url.standardized as NSURL
            previewController.dataSource = self
            self.viewController?.present(previewController, animated: true, completion: nil)
        }

    }
    
    func openDocumentFromUrl(url:URL) throws {
        if url.absoluteString.isEmpty {
            throw FileViewerErrors.couldNotOpenDocument
        }
        
        self.url = url
        FileDownloader.downloadfile(url: url, completion: {(success, fileLocationURL) in
            if success {
                DispatchQueue.main.async {
                    self.previewItem = fileLocationURL!.standardized as NSURL
                    let previewController = QLPreviewController()
                    previewController.dataSource = self
                    self.viewController?.present(previewController, animated: true, completion: nil)
                }
            }
        })
        
    }
    
    func previewMediaContent(url:URL) throws {
        if url.absoluteString.isEmpty {
            throw FileViewerErrors.couldNotOpenDocument
        }
        
        let player = AVPlayer(url: url.standardized)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        viewController?.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        
    }
    
}

//MARK:- QLPreviewController DataSource
extension FileViewerPreview: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return self.previewItem as QLPreviewItem
    }
}
