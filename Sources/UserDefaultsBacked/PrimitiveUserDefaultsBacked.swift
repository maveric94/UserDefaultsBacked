//
//  PrimitiveUserDefaultsBacked.swift
//  
//
//  Created by Anton Protko on 3.06.22.
//

import Foundation


public protocol PrimitiveUserDefaultsValue {
}

@propertyWrapper
public struct PrimitiveUserDefaultsBacked<Value: PrimitiveUserDefaultsValue>: UserDefaultsBacked {
    public var wrappedValue: Value {
        get {
            let value = storage.object(forKey: key) as? Value
            return value ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                storage.removeObject(forKey: key)
            } else {
                storage.set(newValue, forKey: key)
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


extension Optional: PrimitiveUserDefaultsValue where Wrapped: PrimitiveUserDefaultsValue {
}

extension Int: PrimitiveUserDefaultsValue {
}

extension String: PrimitiveUserDefaultsValue {
}

extension Bool: PrimitiveUserDefaultsValue {
}

extension Double: PrimitiveUserDefaultsValue {
}

extension Float: PrimitiveUserDefaultsValue {
}

extension Date: PrimitiveUserDefaultsValue {
}

extension Data: PrimitiveUserDefaultsValue {
}

extension Array: PrimitiveUserDefaultsValue where Element: PrimitiveUserDefaultsValue {
}

extension Dictionary: PrimitiveUserDefaultsValue where Key == String, Value: PrimitiveUserDefaultsValue {
}

extension URL: PrimitiveUserDefaultsValue {
}

private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}
