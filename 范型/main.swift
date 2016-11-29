//
//  main.swift
//  范型
//
//  Created by 黄启明 on 2016/11/24.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import Foundation

func swapValue<T>(_ num1: inout T, _ num2: inout T) {
    let temp = num1
    num1 = num2
    num2 = temp
    
    print(num1)
    print(num2)
}

var number1: Int = 20
var number2: Int = 10

swapValue(&number1, &number2)

print(number1)

print(number2)

print("Hello, World!")

//print(RunLoop.current)

