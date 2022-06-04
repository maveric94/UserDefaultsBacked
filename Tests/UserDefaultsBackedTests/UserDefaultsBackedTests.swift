import XCTest
@testable import UserDefaultsBacked

final class UserDefaultsBackedTests: XCTestCase {
    @UserDefaultsBacked(key: "1")
    var value1: [String] = []
    
    @UserDefaultsBacked(key: "2")
    var value2: [String]?
    
    @UserDefaultsBacked(key: "3")
    var value3: String = ""
    
    @UserDefaultsBacked(key: "4")
    var value4: String?
    
    @UserDefaultsBacked(key: "5")
    var value5: [String: Int] = [:]

    @UserDefaultsBacked(key: "6")
    var value6: [String: Int]?
    
    @UserDefaultsBacked(key: "7")
    var value7: CodableTest = .init()
    
    @UserDefaultsBacked(key: "8")
    var value8: CodableTest?
    
    @UserDefaultsBacked(key: "9")
    var value9: EnumTest = .a
    
    @UserDefaultsBacked(key: "10")
    var value10: EnumTest?
        
    struct CodableTest: Codable, Equatable, UserDefaultsConvertible {
        var a = 0
    }
        
    enum EnumTest: Int, UserDefaultsConvertible {
        typealias UserDefaultsCompatibleType = RawValue
        case a, b
    }
    
    override class func setUp() {
        super.setUp()
        
        let defaults = UserDefaults.standard

        defaults.dictionaryRepresentation().keys.forEach {
            defaults.removeObject(forKey: $0)
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
        
        let str = CodableTest(a: 4)
        XCTAssertEqual(value7, .init())
        value7 = str
        XCTAssertEqual(value7, str)
        
        XCTAssertEqual(value8, nil)
        value8 = str
        XCTAssertEqual(value8, str)
        value8 = nil
        XCTAssertEqual(value8, nil)
        
        let en: EnumTest = .b
        XCTAssertEqual(value9, .a)
        value9 = en
        XCTAssertEqual(value9, en)
        
        XCTAssertEqual(value10, nil)
        value10 = en
        XCTAssertEqual(value10, en)
        value10 = nil
        XCTAssertEqual(value10, nil)
    }
}

