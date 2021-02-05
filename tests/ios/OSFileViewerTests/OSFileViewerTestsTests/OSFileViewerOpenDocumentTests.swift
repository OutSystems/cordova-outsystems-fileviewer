//
//  OSFileViewerOpenDocumentTests.swift
//  OSFileViewerTestsTests
//
//  Created by Carlos Correa on 04/02/2021.
//

import XCTest
@testable import OSFileViewerTests

class OSFileViewerOpenDocumentTests: XCTestCase {
    
    func test_When_emptyUrlPassed_Expect_invalidEmptyURL() throws {
        let fileViewerPlugin = FileViewerPlugin()
        do {
            try fileViewerPlugin.openDocumentFromLocalPath(filePath: "")
            XCTFail("Did not throw error")
        } catch {
            XCTAssertEqual(error as? FileViewerErrors, .invalidEmptyURL)
        }
    }
    
    func test_When_invalidPathPassed_Expect_fileDoesNotExist() throws {
        let fileViewerPlugin = FileViewerPlugin()
        do {
            try fileViewerPlugin.openDocumentFromLocalPath(filePath: "aaaaaaaaaaaaaa")
            XCTFail("Did not throw error")
        } catch {
            XCTAssertEqual(error as? FileViewerErrors, .fileDoesNotExist)
        }
    }
    
    func test_When_emptyUrlPassed_Expect_invalidURL() throws {
        let fileViewerPlugin = FileViewerPlugin()
        do {
            try fileViewerPlugin.openDocumentFromUrl(url: "")
            XCTFail("Did not throw error")
        } catch {
            XCTAssertEqual(error as? FileViewerErrors, .invalidURL)
        }
    }

}
