import XCTest
@testable import UserDefaultsBacked

final class UserDefaultsBackedTests: XCTestCase {
    @PrimitiveUserDefaultsBacked(key: "1")
    var value1: [String] = []
    
    @PrimitiveUserDefaultsBacked(key: "2")
    var value2: [String]?
    
    @PrimitiveUserDefaultsBacked(key: "3")
    var value3: String = ""
    
    @PrimitiveUserDefaultsBacked(key: "4")
    var value4: String?
    
    @PrimitiveUserDefaultsBacked(key: "5")
    var value5: [String: Int] = [:]
    
    @PrimitiveUserDefaultsBacked(key: "6")
    var value6: [String: Int]?
    
    @CodableUserDefaultsBacked(key: "7")
    var value7: String = ""
    
    @CodableUserDefaultsBacked(key: "8")
    var value8: String?
    
    override class func setUp() {
        super.setUp()
        
        let defaults = UserDefaults.standard

        defaults.dictionaryRepresentation().keys.forEach {
            defaults.set(nil, forKey: $0)
        }
    }
    
    func test() throws {
        let array = ["1"]
        XCTAssertEqual(value1, [])
        value1 = array
        XCTAssertEqual(value1, array)
        
        XCTAssertEqual(value2, nil)
        value2 = array
        XCTAssertEqual(value2, array)
        value2 = nil
        XCTAssertEqual(value2, nil)
        
        let string = "1"
        XCTAssertEqual(value3, "")
        value3 = string
        XCTAssertEqual(value3, string)
        
        XCTAssertEqual(value4, nil)
        value4 = string
        XCTAssertEqual(value4, string)
        value4 = nil
        XCTAssertEqual(value4, nil)
        
        let dict = ["1": 1]
        XCTAssertEqual(value5, [:])
        value5 = dict
        XCTAssertEqual(value5, dict)
        
        XCTAssertEqual(value6, nil)
        value6 = dict
        XCTAssertEqual(value6, dict)
        value6 = nil
        XCTAssertEqual(value6, nil)
        
        XCTAssertEqual(value7, "")
        value7 = string
        XCTAssertEqual(value7, string)
        
        XCTAssertEqual(value8, nil)
        value8 = string
        XCTAssertEqual(value8, string)
        value8 = nil
        XCTAssertEqual(value8, nil)
    }
}
