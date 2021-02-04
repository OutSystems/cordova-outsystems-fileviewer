//
//  OSFileViewerPreviewMediaTests.swift
//  OSFileViewerTestsTests
//
//  Created by Carlos Correa on 04/02/2021.
//

import XCTest
@testable import OSFileViewerTests

class OSFileViewerPreviewMediaTests: XCTestCase {

    func test_When_emptyUrlPassed_Expect_invalidEmptyURL() throws {
        let fileViewerPlugin = FileViewerPlugin()
        let urlStr = ""
        
        do {
            try fileViewerPlugin.previewMediaContent(url: urlStr)
            XCTFail("Did not throw error")
        } catch {
            XCTAssertEqual(error as? FileViewerErrors, .invalidEmptyURL)
        }
        
    }
    
    func test_When_invalidPathPassed_Expect_fileDoesNotExist() throws {
        let fileViewerPlugin = FileViewerPlugin()
        let urlStr = "aaaaaaaaaaaaaa"
        
        do {
            try fileViewerPlugin.previewMediaContent(url: urlStr)
            XCTFail("Did not throw error")
        } catch {
            XCTAssertEqual(error as? FileViewerErrors, .fileDoesNotExist)
        }
    
    }

}
