import Foundation

public protocol UserDefaultsBacked {
    associatedtype Value
    
    init(wrappedValue defaultValue: Value, key: String, storage: UserDefaults)
}

extension UserDefaultsBacked where Value: ExpressibleByNilLiteral {
    public init(key: String, storage: UserDefaults = .standard) {
        self.init(wrappedValue: nil, key: key, storage: storage)
    }
}

extension UserDefaultsBacked {
    public init(wrappedValue defaultValue: Value, key: String) {
        self.init(wrappedValue: defaultValue, key: key, storage: .standard)
    }
}


