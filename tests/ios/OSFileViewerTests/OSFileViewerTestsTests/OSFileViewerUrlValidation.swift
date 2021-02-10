//
//  OSFileViewerUrlValidation.swift
//  OSFileViewerTestsTests
//
//  Created by Carlos Correa on 05/02/2021.
//

import XCTest
@testable import OSFileViewerTests

class OSFileViewerUrlValidation: XCTestCase {
    
    func test_given_MalformedURL_When_CheckingIsURLValid_Then_URLIsNotValid() throws {
        XCTAssertFalse("aaaaaaaaaaaaaa".isValidUrl())
    }
    
    func test_given_EmptyURL_When_CheckingIsURLValid_Then_URLIsNotValid() throws {
        XCTAssertFalse("".isValidUrl())
    }

    func test_given_ValidPDF_When_CheckingIsURLValid_Then_URLIsValid() throws {
        XCTAssertTrue("https://www.tutorialspoint.com/swift/swift_tutorial.pdf".isValidUrl())
    }
    
    func test_given_ValidDocx_When_CheckingIsURLValid_Then_URLIsValid() throws {
        XCTAssertTrue("https://file-examples-com.github.io/uploads/2017/02/file-sample_100kB.docx".isValidUrl())
    }
    
    func test_given_ValidHttpURL_When_CheckingIsURLValid_Then_URLIsValid() throws {
        XCTAssertTrue("http://www.tutorialspoint.com/swift/swift_tutorial.pdf".isValidUrl())
    }
    
}

