//
//  UserDefaultsBacked.swift
//
//
//  Created by Anton Protko on 3.06.22.
//

import Foundation


@propertyWrapper
public struct UserDefaultsBacked<Value: UserDefaultsConvertible>: UserDefaultsBackedWrapper {
    public var wrappedValue: Value {
        get { _wrappedValue }
        nonmutating set { _wrappedValue = newValue }
    }

    public let key: String
    public let defaultValue: Value
    public let storage: UserDefaults
    
    public init(wrappedValue defaultValue: Value,
                key: String,
                storage: UserDefaults) {
        self.defaultValue = defaultValue
        self.key = key
        self.storage = storage
    }
}
