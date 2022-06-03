//
//  CodableUserDefaultsBacked.swift
//  
//
//  Created by Anton Protko on 3.06.22.
//

import Foundation

@propertyWrapper
public struct CodableUserDefaultsBacked<Value: Codable>: UserDefaultsBacked {
    public var wrappedValue: Value {
        get {
            guard let data = storage.data(forKey: key) else { return defaultValue }
            let value = try? JSONDecoder().decode(Value.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            storage.set(data, forKey: key)
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
