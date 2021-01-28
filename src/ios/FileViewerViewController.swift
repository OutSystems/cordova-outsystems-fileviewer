//
//  FileViewerViewController.swift
//  FileViewer Test
//
//  Created by Carlos Correa on 25/01/2021.
//

import Foundation
import PDFKit
import AVKit

class FileViewerViewController: UIViewController {
    
    let pdfView = PDFView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func openDocumentFromUrl(url:URL) throws {
        guard let data = try? Data(contentsOf: url) else {
            throw FileViewerErros.couldNotOpenDocument
        }
        
        guard let document = PDFDocument(data: data) else {throw FileViewerErros.couldNotOpenDocument }
        pdfView.autoScales = true
        pdfView.document = document

    }
    
}
