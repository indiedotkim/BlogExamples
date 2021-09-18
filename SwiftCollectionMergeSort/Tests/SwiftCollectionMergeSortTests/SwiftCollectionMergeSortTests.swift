    import XCTest
    @testable import SwiftCollectionMergeSort

    final class SwiftCollectionMergeSortTests: XCTestCase {
        func testEmptyArray() {
            var emptyArray: [Int] = []
            sort(array: &emptyArray)
            XCTAssertEqual(emptyArray, [])
        }
        
        func testIntArray() {
            self.mergeSortTest([ 2, 6, 1, 9, 1, 4, 5, 7 ])
        }
        
        func testStringArray() {
            self.mergeSortTest([ "d", "a", "b", "b", "z", "y", "abc" ])
        }
        
        func testDoubleArray() {
            self.mergeSortTest([ 0.5, 0.75, 1.0, 0.25, 0.125, 0.25 ])
        }
        
        // Random testing: this is a proof-of-concept and it is demonstrating
        // how unit-tests can be utilized to test cases which you might have
        // not thought of.
        //
        // An actual random test would initialize 
        func testRandomArray() {
            var unsortedArray: [Int] = Array(1...1000)
            for _ in 0..<100 {
                unsortedArray.shuffle()
                mergeSortTest(unsortedArray)
            }
        }
        
        private func mergeSortTest<T: Comparable>(_ array: [T]) {
            var mergeSortArray = array
            sort(array: &mergeSortArray)
            XCTAssertEqual(mergeSortArray, array.sorted())
        }
    }
