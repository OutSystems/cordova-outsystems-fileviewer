//
//  FileViewerErrors.swift
//  FileViewer Test
//
//  Created by Carlos Correa on 27/01/2021.
//

import Foundation

enum FileViewerErrors: String, Error, LocalizedError {
    case fileDoesNotExist = "The file you are trying to open does not exist"
    case emptyFileName = "No file name or/and extension was provided"
    case couldNotOpenDocument = "Could not open the document"
    case invalidURL = "The URL you are trying to open is malformed"
    case invalidEmptyURL = "Path of the file to open is either null or empty"
    case downloadFailed = "The download failed"
    case missingFileExtension = "The file has no extension"

    var errorDescription: String? { return NSLocalizedString(rawValue, comment: "") }
}
