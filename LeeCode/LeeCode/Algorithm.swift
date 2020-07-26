//
//  Algorithm.swift
//  LeeCode
//
//  Created by 崔玉冠 on 2020/7/25.
//

import Foundation

// MARK:题目一：两数之和
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



// MARK:题目二：两数相加
/// 声明节点结构体
public class ListNode {
    public var val: Int
    public var next: ListNode?
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

/// 遍历链表
/// - Parameter list: 链表头指针
func printListNode(list: ListNode) {
    var headNode = list
    while headNode.next != nil {
        print(headNode.val)
        if headNode.next != nil {
            headNode = headNode.next!
        }
    }
    print(headNode.val)
}


/// 初始化链表
/// - Parameter items: 链表节点元素
/// - Returns: 头指针
func initList(items:Array<Int>) -> ListNode {
    // -999是临时头结点占位
    var headNode = ListNode.init(-999)
    for (_, val) in items.enumerated() {
        let tmpNode = ListNode.init(val)
        tmpNode.next = headNode.next
        headNode.next = tmpNode
    }
    // 将占位临时头结点移除
    if headNode.next != nil && headNode.val == -999 {
        headNode = headNode.next!
    }
    return headNode
}

/// 题目描述：给出两个 非空的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。您可以假设除了数字 0 之外，这两个数都不会以 0 开头。
/// 
/// 示例：输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)
/// 输出：7 -> 0 -> 8
/// 原因：342 + 465 = 807

/// - Parameters:
///   - l1: 链表1
///   - l2: 链表2
/// - Returns: 返回相加之后的链表
func addTwoNumbers(l1: ListNode, l2: ListNode) -> ListNode? {
    let sum = ListNode.init(0)
    var p: ListNode? = l1
    var q: ListNode? = l2
    var flag = 0
    var head = sum
    while (p != nil || q != nil) {
        // 值的计算，涉及对应位数相加进位及进位之后本位取10的余数
        let tmpSumVal = (p?.val ?? 0) + (q?.val ?? 0) + flag
        let realSumVal = tmpSumVal % 10
        flag = tmpSumVal / 10
        // 节点赋值
        let tmpNode = ListNode.init(realSumVal)
        head.next = tmpNode
        // 指针移位
        head = head.next!
        p = p?.next
        q = q?.next
    }
    if flag > 0 {
        sum.next = ListNode.init(flag)
    }
    return sum.next
}

