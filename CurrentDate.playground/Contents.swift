import UIKit

var str = "Hello, playground"

let date = Date()
let formatter = DateFormatter()

formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

let result = formatter.string(from: date)

print(result)
