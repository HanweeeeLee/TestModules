![FlexibleModelProtocolImage](https://user-images.githubusercontent.com/60125719/97803827-3761f600-1c8f-11eb-9b45-432601ff2603.png)

# FlexibleModelProtocol

Model protocol with flexible, diverse types of conversion


## Requirements

- iOS 11.0+ / macOS 10.13+ / tvOS 13.0+ / watchOS 6.0+
- Xcode 11+
- Swift 5.0+

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate FlexibleModelProtocol into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'FlexibleModelProtocol', '~> 1.1'
```
## Usage

### example model 
```swift
import FlexibleModelProtocol

struct MyModel: FlexibleModelProtocol {
    ...
}
```

### From Data

 - JSON
 ```swift
 let myModel: MyModel? = MyModel.fromJson(jsonData: data, object: MyModel())
 ```
 
 - XML
 ```swift
 let myModel: MyModel? = MyModel.fromXML(xmlData: data, object: MyModel())
 ```
 
 - Dictionary
 ```swift
 let myModel: MyModel? = MyModel.fromDictionary(dictionary: data, object: MyModel())
 ```
 
 - NSDictionary
 ```swift
 let myModel: MyModel? = MyModel.fromNSDictionary(nsDictionary: data, object: MyModel())
 ```


### To Data

- JSON
```swift
let jsonString: String = myModel.toJson()
```

- XML
```swift
let xmlString: String? = myModel.toXML()
```

- Dictionary
```swift
let dictionary: [String:Any]? = myModel.toDictionary()
```

- NSDictionary
```swift
let nsDictionary: NSDictionary? = myModel.toNSDictionary()
```

### Copy on Write

### example model 
```swift
struct MyModel: FlexibleModelProtocol {
    ...
}
```

```swift
struct MyCopyOnWriteModel: CopyOnWriteModelProtocol {
    typealias ModelType = MyModel
    var dataWrapper: DataWrapper<MyModel>? = nil
}
```

### FlexibleModelProtocolModel to CopyOnWriteModelProtocolModel

```swift
let model: MyModel = MyModel(...)
var emptyCowObj: MyCopyOnWriteModel = MyCopyOnWriteModel()
let cowData: MyCopyOnWriteModel? = model.toCopyOnWriteModel(object: &emptyCowObj)
```

### CopyOnWriteModelProtocolModel to FlexibleModelProtocolModel

```swift
let cowModel: MyCopyOnWriteModel = CowModel(dataWrapper: DataWrapper(originModel: MyModel(...)))
let flexibleModel: MyModel? = cowModel.toFlexibleProtocolModel()
```



## Contact Us
Email : mobiledev@kakao.com

## License

FlexibleModelProtocol is released under the MIT license. See LICENSE for details.
