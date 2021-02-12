//
//  FileViewerErrors.swift
//  FileViewer Test
//
//  Created by Carlos Correa on 27/01/2021.
//

import Foundation

enum FileViewerErrors: String, Error {
    case fileDoesNotExist = "The file you are trying to open does not exist"
    case couldNotOpenDocument = "Could not open the document"
    case invalidURL = "The URL you are trying to open is malformed"
    case invalidEmptyURL = "Path of the file to open is either null or empty"
    case downloadFailed = "The download failed"
}

extension FileViewerErrors : LocalizedError {
    var errorDescription: String? { return NSLocalizedString(rawValue, comment: "") }
}
