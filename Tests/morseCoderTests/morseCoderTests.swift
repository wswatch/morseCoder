import XCTest
@testable import morseCoder

class morseCoderTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(morseCoder().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
