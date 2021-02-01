//
//  FileViewerErrors.swift
//  FileViewer Test
//
//  Created by Carlos Correa on 27/01/2021.
//

import Foundation

enum FileViewerErrors: String, Error {
    case empty = "The file is empty"
    case couldNotOpenDocument = "Could not open the document"
}

extension FileViewerErrors : LocalizedError {
    var errorDescription: String? { return NSLocalizedString(rawValue, comment: "") }
}
