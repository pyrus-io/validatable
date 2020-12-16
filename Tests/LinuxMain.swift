import XCTest

import ValidatableTests

var tests = [XCTestCaseEntry]()
tests += ValidatableTests.allTests()
XCTMain(tests)
