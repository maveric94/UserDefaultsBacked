//
//  UserDefaultsConvertible.swift
//  
//
//  Created by Anton Protko on 3.06.22.
//

import Foundation


public protocol UserDefaultsConvertible {
    associatedtype UserDefaultsCompatibleType: UserDefaultsCompatible
    
    init(userDefaultsCompatibleValue: UserDefaultsCompatibleType) throws
    func toUserDefaultsCompatibleValue() throws -> UserDefaultsCompatibleType
}

public protocol UserDefaultsCompatible: UserDefaultsConvertible {
}

extension UserDefaultsCompatible {
    public init(userDefaultsCompatibleValue: Self) throws {
        self = userDefaultsCompatibleValue
    }
    
    public func toUserDefaultsCompatibleValue() throws -> Self {
        self
    }
}

extension Int: UserDefaultsCompatible {
}

extension String: UserDefaultsCompatible {
}

extension Bool: UserDefaultsCompatible {
}

extension Double: UserDefaultsCompatible {
}

extension Float: UserDefaultsCompatible {
}

extension Date: UserDefaultsCompatible {
}

extension Data: UserDefaultsCompatible {
}

extension Array: UserDefaultsCompatible, UserDefaultsConvertible where Element: UserDefaultsCompatible {
    public typealias UserDefaultsCompatibleType = Self
}

extension Dictionary: UserDefaultsCompatible, UserDefaultsConvertible where Key == String, Value: UserDefaultsCompatible {
    public typealias UserDefaultsCompatibleType = Self
}

extension URL: UserDefaultsCompatible {
}

extension Optional: UserDefaultsCompatible, UserDefaultsConvertible where Wrapped: UserDefaultsConvertible {
    public typealias UserDefaultsCompatibleType = Wrapped.UserDefaultsCompatibleType?
    
    public init(userDefaultsCompatibleValue: UserDefaultsCompatibleType) throws {
        self = try userDefaultsCompatibleValue.map { try Wrapped.init(userDefaultsCompatibleValue: $0) }
    }
    
    public func toUserDefaultsCompatibleValue() throws -> UserDefaultsCompatibleType {
        try self.map { try $0.toUserDefaultsCompatibleValue() }
    }
}

extension UserDefaultsConvertible where Self: Codable {
    public init(userDefaultsCompatibleValue: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: userDefaultsCompatibleValue)
    }

    public func toUserDefaultsCompatibleValue() throws -> Data {
        try JSONEncoder().encode(self)
    }
}

extension UserDefaultsConvertible where Self: RawRepresentable, RawValue: UserDefaultsConvertible {
    public init(userDefaultsCompatibleValue: RawValue.UserDefaultsCompatibleType) throws {
        let raw = try Self.RawValue.init(userDefaultsCompatibleValue: userDefaultsCompatibleValue)
        guard let value = Self.init(rawValue: raw) else {
            throw Error.incompatibleValue(userDefaultsCompatibleValue, type: Self.self)
        }
        self = value
    }

    public func toUserDefaultsCompatibleValue() throws -> RawValue.UserDefaultsCompatibleType {
        try rawValue.toUserDefaultsCompatibleValue()
    }
}

enum Error: Swift.Error {
    case incompatibleValue(_ value: Any, type: Any.Type)
}

protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}
