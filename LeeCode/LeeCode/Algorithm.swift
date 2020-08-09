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

//MARK: 题目三：最长无重复子串

/// 题目描述：给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度
/// 思路：根据滑动窗口方式，依次遍历字符串字符放入数组中，并实时更新最长字符串长度，
///      当判断到下一个字符已经包含该数组中，清空数组，继续遍历
/// - Parameter string: 原始字符串
/// - Returns: 最长子串长度 + 子串元素数组
func maxLengthOfSubString(string: String) -> (Int, Array<Character>) {
    var strArr = Array<Character>()
    var maxLength = 0
    var maxSubStrArr = Array<Character>()
    
    for char in string {
        if strArr.contains(char) {
            strArr.removeAll()
        }
        strArr.append(char)
        if strArr.count > maxLength {
            maxLength = strArr.count
            maxSubStrArr = strArr
        }
    }
    return (maxLength, maxSubStrArr)
}

//MARK: 题目四：求两个正序数组的中位数

/// 方法一：先归并，再利用二分查找
/// - Parameters:
///   - list1: 数组1
///   - list2: 数组2
/// - Returns: 中位数
func middleOfTwoList1(list1:Array<Int>, list2:Array<Int>) -> Float {
    var sumArr = [Int](repeating:0, count:(list1.count + list2.count))
    var i = 0
    var j = 0
    for (index, _) in sumArr.enumerated() {
        if (i < list1.count && list1[i] <= list2[j]) || j >= list2.count {
            sumArr[index] = list1[i]
            i = i + 1
        } else {
            sumArr[index] = list2[j]
            j = j + 1
        }
    }
    if sumArr.count % 2 == 0 {
        return Float((sumArr[sumArr.count / 2 - 1] + sumArr[sumArr.count / 2])) / 2.0
    } else {
        return Float(sumArr[(sumArr.count / 2)])
    }
}

/// 方法二：满足时间复杂度是log2（m+n），由方法一启发，在归并的过程中，归并一半的时候
///        就能知道中间位是多少了
/// - Parameters:
///   - list1: 数组1
///   - list2: 数组2
/// - Returns: 中位数
func middleOfTwoList2(list1:Array<Int>, list2:Array<Int>) -> Float {
    let sumCount = list1.count + list2.count;
    var i = 0
    var j = 0
    while i + j < sumCount / 2 - 1 {
        if (i < list1.count && list1[i] <= list2[j]) || j >= list2.count {
            i = i + 1
        } else {
            j = j + 1
        }
    }
    if sumCount % 2 == 0 {
        return Float((list1[i] + list2[j])) / 2.0
    }
    if list1[i] > list2[j] {
        return Float(list1[i])
    }
    return Float(list2[j])
}

//MARK: 题目五：二叉树相关操作

// 声明二叉树节点结构体
public class TreeNode {
    var data: Int
    var lChild: TreeNode?
    var rChild: TreeNode?
    init(_ data: Int) {
        self.data = data
        self.lChild = nil
        self.rChild = nil
    }
}

// 创建二叉树
func createTree(listData:[Int]) -> TreeNode? {
    if listData.count == 0 {
        return nil
    }
    let tree = TreeNode(-1)
    for data in listData {
        createTreeByPreOrder(tree: tree, data: data)
    }
    return tree
}

// 先序创建
func createTreeByPreOrder(tree:TreeNode, data:Int) {
    if tree.data == -1 {
        tree.data = data
        return
    }
    let middle = tree.data
    if data < middle {
        if tree.lChild == nil {
            tree.lChild = TreeNode.init(data)
        } else {
            createTreeByPreOrder(tree: tree.lChild!, data: data)
        }
    } else {
        if tree.rChild == nil {
            tree.rChild = TreeNode.init(data)
        } else {
            createTreeByPreOrder(tree: tree.rChild!, data: data)
        }
    }
}
