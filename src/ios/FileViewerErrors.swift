//
//  FileViewerErrors.swift
//  FileViewer Test
//
//  Created by Carlos Correa on 27/01/2021.
//

import Foundation

enum FileViewerErrors: String, Error {
    case fileDoesNotExist = "The file does not exist"
    case couldNotOpenDocument = "Could not open the document"
    case invalidURL = "Invalid URL"
    case invalidEmptyURL = "Invalid empty URL"
}

extension FileViewerErrors : LocalizedError {
    var errorDescription: String? { return NSLocalizedString(rawValue, comment: "") }
}
