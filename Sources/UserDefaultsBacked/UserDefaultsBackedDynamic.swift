//
//  UserDefaultsBackedDynamic.swift
//  
//
//  Created by Anton Protko on 5.06.22.
//

import Foundation
import SwiftUI

@propertyWrapper
public struct UserDefaultsBackedDynamic<Value: UserDefaultsConvertible>: DynamicProperty, UserDefaultsBackedWrapper {
    public var wrappedValue: Value {
        get { _wrappedValue }
        nonmutating set { _wrappedValue = newValue }
    }
    
    public var projectedValue: Binding<Value> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    
    public let key: String
    public let defaultValue: Value
    public let storage: UserDefaults
    
    @StateObject private var observer: Observer
    
    public init(wrappedValue defaultValue: Value,
                key: String,
                storage: UserDefaults) {
        self.defaultValue = defaultValue
        self.key = key
        self.storage = storage
        self._observer = .init(wrappedValue: .init(storage: storage, key: key))
    }
}

class Observer: NSObject, ObservableObject {
    let storage: UserDefaults
    let key: String
    
    init(storage: UserDefaults, key: String) {
        self.storage = storage
        self.key = key
        
        super.init()
        
        storage.addObserver(self, forKeyPath: key, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    deinit {
        storage.removeObserver(self, forKeyPath: key)
    }
}
