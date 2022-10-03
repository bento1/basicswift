import UIKit

var greeting = "Hello, playground"

for i in 0...99{
    i
}

var someInt:Int = -1

print(someInt)


var someDouble: Double = 1.1

var someCharacter: Character = "가"
print(someCharacter)

var number = 10

var numbers : Array<Int> = Array()

numbers.append(1)
numbers.append(2)
numbers.append(3)
numbers.count
numbers[0]
numbers.insert(4,at:2)
numbers
numbers.remove(at: 2)
var numbers1 = [String]()
var numbers2:[String]=[]

//var dic : Dictionary<String, Int> = Dictionary()
var dic : [String : Int] = ["dongun" : 1]
dic["jehyun"]=2
dic
dic.removeValue(forKey: "jehyun")

var set : Set = Set<Int>()
set.insert(10)
set.insert(20)
set.insert(30)
set.insert(30)
set

func sum(a:Int , b:Int)-> Int{
    return a+b
}
sum(a: 5, b: 3)

func sendMessage(from myName: String, to name: String) -> String{
    return "Hello \(myName)! I'm \(name)"
}
sendMessage(from: "dongun", to: "yun")

func sendMessage(_ myName: String, to name: String) -> String{
    return "Hello \(myName)! I'm \(name)"
}
sendMessage( "dongun", to: "yun")

func sendMessage(from myName: String, to name: String...) -> String{
//    name 은 배열로 받을 수 있음
    return "Hello \(myName)! I'm \(name)"
}
sendMessage(from: "dongun", to: "yun")

let age = 12

if age>10{
    print("old")
}else{
    print("young")
}

let color = "green"

switch color {
    case "blue" :
        print("파란색ㄱ입니다.")
    case "green":
        print("green")
    default :
        print("no color")
}

let temperature = 30

switch temperature{
case -20...9:
    print("winter")
case 10...14:
    print("fall")
case 15...30:
    print("spring")
default :
    print("summer")
}

for i in 1...4{
    print(i)
}

for i in numbers{
    print(i)
}

number = 5

while number<10{
    number+=1
}

var x = 6
//한번은 무조건 실행
repeat {
    x+=2
}while x<5
print(x)


var number1 : Int? = nil

print(number1)

var nameOptional: String?

//var name:String = nameOptional
//옵셔널바인딩 해야함 느낌표 붙이면됨 -> 위험
// 비강제 옵셔널 바이닝 해야함
nameOptional="string"
print(nameOptional)
var name:String = nameOptional!
//method 1
if let result = nameOptional{
    print(result)
}else{
    
}

func optionalBinding(){
    let number: Int? = 5
    guard let result = number else{ return }
    print(result)
}
optionalBinding()

class User{
    var name : String = ""
    var age : Int = 0
    init(name : String , age : Int){
        self.name=name
        self.age=age
    }
    deinit{
        print("User delete")
    }
    
}

var user = User(name: "dong", age: 23)
user.age
user.name

var user2 : User? =  User(name: "dong", age: 23)
user2=nil

struct Stock{
    var averagePrice : Int
    var quantity : Int
    var purchasePrice : Int{
        get {
            return averagePrice*quantity
        }
        set(newPrice){
            averagePrice = newPrice/quantity
        }
    }
}
var stock = Stock(averagePrice: 10, quantity: 10)
stock.purchasePrice
stock.purchasePrice=3000
stock.averagePrice

//
//willset
//didset

import Foundation

class Vehicle{
    var currentSpeed = 0.0
    var description : String{
        return "traveling at \(currentSpeed) miless per hour"
    }
    func makeNoise(){
        print("speaker on")
    }
}

class Bicycle:Vehicle{
    var heasBasket : Bool = false
    
    
}

var bicycle = Bicycle()
bicycle.currentSpeed
bicycle.currentSpeed=15.0

class Train:Vehicle{
    override func makeNoise() {
        super.makeNoise()
        print("choo choo")
    }
}
var train = Train()
train.makeNoise()

struct Developer{
    let name: String
    
}
struct Company {
    let name: String
    var developer: Developer?
}

var developer = Developer(name: "dong")
var company = Company(name: "Gun", developer: developer)
print(company.developer?.name)


enum PhoneError: Error {
    case unknown
    case batteryLow(batteryLevel: Int)
}

//throw PhoneError.batteryLow(batteryLevel: 20)

func checkPhoneBatteryStatus(batteryLevel: Int) throws -> String{
    guard batteryLevel != -1 else {throw PhoneError.unknown}
    guard batteryLevel >= 20 else {throw PhoneError.batteryLow(batteryLevel : 20)}
    return "배터리 상태가 정상입니다."
}
//에러처리 방법
//1. 함수에 발생한 에러를 호출 위치에 표시
//2. Do - Catch 구문

do {
    
    try checkPhoneBatteryStatus(batteryLevel: 19)
}catch PhoneError.unknown{
    print("알 수 없는 에러")
    
}catch PhoneError.batteryLow(let batteryLevel) {
    print("배터리 전원 부족 남은 배터리 : \(batteryLevel)%")
}catch {
    print("그 외")
}

//closure
let hello = { () -> () in
    print("hello")
}

hello()

let hello2 = { (name: String )-> String in
    return "Hello, \(name)"
}
hello2("Gun")

func doSomethong (closure: ()->()){
    closure()
}

doSomethong(closure: { () -> () in
    print("closure test")
}
)
doSomethong() {
    print("hello2")
}
func doSomething2() -> () -> (){
    return { ()->() in
        print ("hello4")
        
    }
}
doSomething2()()

//고차 함수 map, filter reduce



