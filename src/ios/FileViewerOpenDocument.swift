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

    func openDocumentFromUrl(url:URL) throws {
        FileDownloader.downloadfile(url: url, completion: {(success, fileLocationURL) in
            if success, let filePath = fileLocationURL {
                DispatchQueue.main.async {
                    self.documentInteractionController = UIDocumentInteractionController.init(url: filePath.standardized)
                    self.documentInteractionController?.delegate = self
                    self.documentInteractionController?.uti = filePath.uti
                    self.documentInteractionController?.presentPreview(animated: true)
                }
            }
        })
    }
    
    func openDocumentFromLocalPath(url:URL) throws {
        self.documentInteractionController = UIDocumentInteractionController.init()
        self.documentInteractionController?.delegate = self
        self.documentInteractionController?.url = url.standardized
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
