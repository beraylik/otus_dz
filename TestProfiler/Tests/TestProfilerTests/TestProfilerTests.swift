import XCTest
@testable import TestProfiler

final class TestProfilerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(TestProfiler().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
