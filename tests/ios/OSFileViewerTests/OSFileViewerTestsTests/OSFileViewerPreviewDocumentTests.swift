//
//  OSFileViewerPreviewDocumentTests.swift
//  OSFileViewerTestsTests
//
//  Created by Carlos Correa on 04/02/2021.
//

import XCTest
@testable import OSFileViewerTests

class OSFileViewerPreviewDocumentTests: XCTestCase {

    func test_When_emptyPathPassed_Expect_invalidEmptyURL() throws {
        let fileViewerPlugin = FileViewerPlugin()
        do {
            try fileViewerPlugin.previewDocumentFromLocalPath(filePath: "")
            XCTFail("Did not throw error")
        } catch {
            XCTAssertEqual(error as? FileViewerErrors, .invalidEmptyURL)
        }
    }
    
    func test_When_invalidPathPassed_Expect_fileDoesNotExist() throws {
        let fileViewerPlugin = FileViewerPlugin()
        do {
            try fileViewerPlugin.previewDocumentFromLocalPath(filePath: "aaaaaaaaaaaaaa")
            XCTFail("Did not throw error")
        } catch {
            XCTAssertEqual(error as? FileViewerErrors, .fileDoesNotExist)
        }
    }
    
    func test_When_emptyUrlPassed_Expect_invalidURL() throws {
        let fileViewerPlugin = FileViewerPlugin()
        fileViewerPlugin.previewDocumentFromUrl(url: "", completion: { (inner: ErrorCompletionHandler) in
            do {
                _ = try inner()
                XCTFail("Did not throw error")
            } catch {
                XCTAssertEqual(error as? FileViewerErrors, .invalidURL)
            }
        })

    }

}
