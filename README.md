# UserDefaultsBacked

## Desription
Property wrappers that use UserDefaults to persist values.

## Usage
```Swift
import UserDefaultsBacked

struct Foo: Codable {
  var value: Int
}

class Bar {
  @PrimitiveUserDefaultsBacked(key: "someKey")
  var value: Int = 1
  
  @CodableUserDefaultsBacked(key: "anotherKey")
  var value2: Foo?
}

let baz = Bar()
baz.value = 2
baz.value2 = Foo(value: 3)

```

## Installation
### SPM
```Swift
.package(url: "https://github.com/maveric94/UserDefaultsBacked.git", .upToNextMajor(from: "1.0"))
```
