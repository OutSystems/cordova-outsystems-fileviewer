//
//  FileViewerErrors.swift
//  FileViewer Test
//
//  Created by Carlos Correa on 27/01/2021.
//

import Foundation

enum FileViewerErros: Error {
    case empty
    case couldNotOpenDocument
    
    var description: String {
        switch self {
        case .empty:
            return "The file is empty"
        case .couldNotOpenDocument:
            return "Could not open the document"
        }
    }
}
