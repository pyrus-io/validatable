import XCTest
@testable import Validatable

final class ValidatableTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Validatable().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
