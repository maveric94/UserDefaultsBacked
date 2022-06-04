//
//  UserDefaultsConvertible.swift
//  
//
//  Created by Anton Protko on 3.06.22.
//

import Foundation


public protocol UserDefaultsConvertible {
    associatedtype UnderlyingValue: UserDefaultsCompatible
    
    init(value: UnderlyingValue) throws
    func convert() throws -> UnderlyingValue
}

public protocol UserDefaultsCompatible: UserDefaultsConvertible {
}

extension UserDefaultsCompatible {
    public init(value: Self) throws {
        self = value
    }
    
    public func convert() throws -> Self {
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
    public typealias UnderlyingValue = Self
}

extension Dictionary: UserDefaultsCompatible, UserDefaultsConvertible where Key == String, Value: UserDefaultsCompatible {
    public typealias UnderlyingValue = Self
}

extension URL: UserDefaultsCompatible {
}

extension Optional: UserDefaultsCompatible, UserDefaultsConvertible where Wrapped: UserDefaultsConvertible {
    public typealias UnderlyingValue = Wrapped.UnderlyingValue?
    
    public init(value: UnderlyingValue) throws {
        self = try value.map { try Wrapped.init(value: $0) }
    }
    
    public func convert() throws -> UnderlyingValue {
        try self.map { try $0.convert() }
    }
}

extension UserDefaultsConvertible where Self: Codable {
    public init(value: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: value)
    }

    public func convert() throws -> Data {
        try JSONEncoder().encode(self)
    }
}

extension UserDefaultsConvertible where Self: RawRepresentable, RawValue: UserDefaultsConvertible {
    public init(value: RawValue.UnderlyingValue) throws {
        let raw = try Self.RawValue.init(value: value)
        guard let value = Self.init(rawValue: raw) else {
            throw Error.incompatibleValue(value, type: Self.self)
        }
        self = value
    }

    public func convert() throws -> RawValue.UnderlyingValue {
        try rawValue.convert()
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
