# UserDefaultsBacked

## Desription
Property wrapper that uses UserDefaults to persist values of different types.

## Usage
```Swift
import UserDefaultsBacked

struct Foo: Codable, UserDefaultsConvertible {
  var value: Int
}

enum Bar: Int, UserDefaultsConvertible {
  typealias UserDefaultsCompatibleType = RawValue
  case a, b
}

@UserDefaultsBacked(key: "someKey")
var intValue: Int = 1
  
@UserDefaultsBacked(key: "anotherKey")
var codableValue: Foo?

@UserDefaultsBacked(key: "oneMoreKey")
var enumValue: Bar?

// also can be used in swiftui
struct SwiftUIView: View {
    @UserDefaultsBackedDynamic(key: "key")
    var value: Int = 0
    
    var body: some View {
      ...
    }
}

```

## Installation
### SPM
```Swift
.package(url: "https://github.com/maveric94/UserDefaultsBacked.git", .upToNextMajor(from: "1.2.0"))
```
