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
        let viewController = UIViewController()
        let fileViewerPlugin = FileViewerPlugin(viewController: viewController)
        let urlStr = ""
        
        do {
            try fileViewerPlugin.openDocumentFromLocalPath(url: urlStr)
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
            try fileViewerPlugin.openDocumentFromLocalPath(url: urlStr)
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
            try fileViewerPlugin.openDocumentFromUrl(url: urlStr)
            XCTFail("Did not throw error")
        } catch {
            XCTAssertEqual(error as? FileViewerErrors, .invalidURL)
        }
        
    }

}
