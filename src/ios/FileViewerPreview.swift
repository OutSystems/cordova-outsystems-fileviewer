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
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func previewDocumentFromLocalPath(filePath:URL) throws {
        DispatchQueue.main.async {
            let previewController = QLPreviewController()
            self.previewItem = filePath.standardized as NSURL
            previewController.dataSource = self
            self.viewController?.present(previewController, animated: true, completion: nil)
        }
    }
    
    func previewDocumentFromUrl(url:URL, completion: @escaping (_ inner:ErrorCompletionHandler) -> Void) -> Void {
        FileDownloader.downloadFile(url:url, completion: { (success, inner: URLCompletionHandler) in
            do {
                let result = try inner()
                DispatchQueue.main.async {
                    self.previewItem = result.standardized as NSURL
                    let previewController = QLPreviewController()
                    previewController.dataSource = self
                    self.viewController?.present(previewController, animated: true, completion: nil)
                }
            } catch let error {
                DispatchQueue.main.async { completion({ throw error }) }
            }
        })
    }
    
    func previewMediaContent(url:URL) throws {
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
