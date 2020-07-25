//
//  Algorithm.swift
//  LeeCode
//
//  Created by 崔玉冠 on 2020/7/25.
//

import Foundation

/// 题目一：
/// 获取一个数组中两数之和等于目标值的两个值
/// 思路：暴力法可以直接两次遍历，获取所有等于目标和的两个值，但是时间复杂度是O(n2)
///      利用哈希表，哈希表的查找时间复杂度是O(1)，再经过一次遍历，既可以将所有的
///      值查找出来
/// - Parameters:
///   - items: 数组
///   - target: 目标值
/// - Returns: 之和等于目标数的两个值
func sumOfTwoNum(items:Array<Int>, target:Int) -> [Int] {
    var hashMap = [String:AnyObject]()
    var ret = [Int]()
    for (index, num) in items.enumerated() {
        if hashMap.keys.contains((target - num).description) {
            ret.append(target - num)
            ret.append(num)
            continue
        }
        hashMap[num.description] = index as AnyObject
    }
    return ret
}

