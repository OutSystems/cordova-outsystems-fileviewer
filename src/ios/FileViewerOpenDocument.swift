//
//  FileViewerOpenDocument.swift
//  File Sample App
//
//  Created by Carlos Correa on 02/02/2021.
//

import UIKit

class FileViewerOpenDocument: NSObject {
    
    var documentInteractionController:UIDocumentInteractionController?
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func openDocumentFromUrl(url:URL, completion: @escaping (_ inner:ErrorCompletionHandler) -> Void) -> Void {
        FileDownloader.downloadFile(url:url, completion: { (success, inner: URLCompletionHandler) in
            do {
                let result = try inner()
                DispatchQueue.main.async {
                    self.documentInteractionController = UIDocumentInteractionController()
                    self.documentInteractionController?.delegate = self
                    self.documentInteractionController?.url = result.destinationUrl
                    if let urlStr = result.destinationUrl?.standardized {
                        self.documentInteractionController?.uti = urlStr.uti
                    }
                    self.documentInteractionController?.name = result.name
                    self.documentInteractionController?.presentPreview(animated: true)
                }
            } catch let error {
                DispatchQueue.main.async { completion({ throw error }) }
            }
        })
    }
    
    func openDocumentFromLocalPath(filePath:URL, completion: @escaping () -> Void) throws {
        self.documentInteractionController = DocumentInteractor() {
            completion()
        }
        self.documentInteractionController?.delegate = self
        self.documentInteractionController?.url = filePath.standardized
        self.documentInteractionController?.presentPreview(animated: true)
    }
    
}

extension FileViewerOpenDocument: UIDocumentInteractionControllerDelegate {
    //MARK: UIDocumentInteractionControllerDelegate
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self.viewController!
    }
    
}

extension URL {
    var uti: String {
        return (try? self.resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier ?? "public.data"
    }
}


class DocumentInteractor: UIDocumentInteractionController {

    var previewFinished: (() -> Void)
    
    init(presentationFinished: @escaping () -> Void) {
        self.previewFinished = presentationFinished
    }
    
    deinit {
        self.previewFinished()
    }
    
}
