import XCTest
@testable import PerfectCArray
import CoreFoundation

class PerfectCArrayTests: XCTestCase {
    func testExample() {
      let helper = CArray<UnsafeMutablePointer<Int8>>()
      var array = UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>(bitPattern: 0)
      XCTAssertTrue(helper.append(pArray: &array, element: strdup("hello")))
      XCTAssertTrue(helper.append(pArray: &array, element: strdup("world")))
      XCTAssertTrue(helper.append(pArray: &array, element: strdup("love")))

      let expectation = ["hello", "world", "love"]
      var result = [String]()
      helper.forEach(array: array!) { str in
        let s = String(cString: str)
        result.append(s)
      }//next
      XCTAssertEqual(expectation, result)
      print(result)

      let total = helper.withArray(of: array!) { a -> Int in
        return a.count
      }//end total
      XCTAssertEqual(total, 4)
      print(total)
    }


    static var allTests : [(String, (PerfectCArrayTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
