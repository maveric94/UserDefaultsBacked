//
//  UserDefaultsBackedWrapper.swift
//  
//
//  Created by Anton Protko on 5.06.22.
//

import Foundation

public protocol UserDefaultsBackedWrapper {
    associatedtype Value: UserDefaultsConvertible
    
    var key: String { get }
    var defaultValue: Value { get }
    var storage: UserDefaults { get }
    
    init(wrappedValue defaultValue: Value,
         key: String,
         storage: UserDefaults)
}


extension UserDefaultsBackedWrapper where Value: ExpressibleByNilLiteral {
    public init(key: String, storage: UserDefaults = .standard) {
        self.init(wrappedValue: nil, key: key, storage: storage)
    }
}

extension UserDefaultsBackedWrapper {
    public init(wrappedValue defaultValue: Value, key: String) {
        self.init(wrappedValue: defaultValue, key: key, storage: .standard)
    }
}

extension UserDefaultsBackedWrapper {
    public var _wrappedValue: Value {
        get {
            guard let value = storage.object(forKey: key) as? Value.UserDefaultsCompatibleType else {
                return defaultValue
            }
            
            do {
                return try Value.init(userDefaultsCompatibleValue: value)
            } catch {
                assertionFailure(error.localizedDescription)
                return defaultValue
            }
        }
        
        nonmutating set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                storage.removeObject(forKey: key)
            } else {
                do {
                    let converted = try newValue.toUserDefaultsCompatibleValue()
                    storage.set(converted, forKey: key)
                } catch {
                    assertionFailure(error.localizedDescription)
                }
            }
        }
    }
}
