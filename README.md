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

```

## Installation
### SPM
```Swift
.package(url: "https://github.com/maveric94/UserDefaultsBacked.git", .upToNextMajor(from: "1.0.0"))
```
