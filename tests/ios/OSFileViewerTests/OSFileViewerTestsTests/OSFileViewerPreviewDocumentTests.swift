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
        let viewController = UIViewController()
        let fileViewerPlugin = FileViewerPlugin(viewController: viewController)
        let urlStr = ""
        
        do {
            try fileViewerPlugin.previewDocumentFromLocalPath(url: urlStr)
            XCTFail("Did not throw error")
        } catch {
            XCTAssertEqual(error as? FileViewerErrors, .invalidEmptyURL)
        }
        
    }
    
    func test_When_invalidPathPassed_Expect_fileDoesNotExist() throws {
        let viewController = UIViewController()
        let fileViewerPlugin = FileViewerPlugin(viewController: viewController)
        let urlStr = "aaaaaaaaaaaaaa"
        
        do {
            try fileViewerPlugin.previewDocumentFromLocalPath(url: urlStr)
            XCTFail("Did not throw error")
        } catch {
            XCTAssertEqual(error as? FileViewerErrors, .fileDoesNotExist)
        }
    
    }
    
    func test_When_emptyUrlPassed_Expect_invalidURL() throws {
        let viewController = UIViewController()
        let fileViewerPlugin = FileViewerPlugin(viewController: viewController)
        let urlStr = ""
        
        do {
            try fileViewerPlugin.previewDocumentFromUrl(url: urlStr)
            XCTFail("Did not throw error")
        } catch {
            XCTAssertEqual(error as? FileViewerErrors, .invalidURL)
        }
        
    }

}