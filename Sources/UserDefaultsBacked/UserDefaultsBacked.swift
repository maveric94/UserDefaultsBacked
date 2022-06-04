//
//  UserDefaultsBacked.swift
//
//
//  Created by Anton Protko on 3.06.22.
//

import Foundation

@propertyWrapper
public struct UserDefaultsBacked<Value: UserDefaultsConvertible> {
    public var wrappedValue: Value {
        get {
            guard let value = storage.object(forKey: key) as? Value.UnderlyingValue else {
                return defaultValue
            }
            
            do {
                return try Value.init(value: value)
            } catch {
                assertionFailure(error.localizedDescription)
                return defaultValue
            }
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                storage.removeObject(forKey: key)
            } else {
                do {
                    let converted = try newValue.convert()
                    storage.set(converted, forKey: key)
                } catch {
                    assertionFailure(error.localizedDescription)
                }
            }
        }
    }

    private let key: String
    private let defaultValue: Value
    private let storage: UserDefaults
    
    public init(wrappedValue defaultValue: Value,
                key: String,
                storage: UserDefaults) {
        self.defaultValue = defaultValue
        self.key = key
        self.storage = storage
    }
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


