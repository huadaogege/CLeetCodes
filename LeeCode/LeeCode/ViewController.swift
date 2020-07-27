//
//  ViewController.swift
//  LeeCode
//
//  Created by 崔玉冠 on 2020/7/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 题目一
        // let nums = [1, 2, 4, 5, 6, 28, 32, 33]
        // let ret = sumOfTwoNum(items: nums, target: 34)
        
        // 题目二
        let l1Vals = [2, 4, 3]
        let list1 = initList(items: l1Vals)
        
        let l2Vals = [5, 6, 4]
        let list2 = initList(items: l2Vals)
        
        let newList = addTwoNumbers(l1: list1, l2: list2)
        printListNode(list: newList!)
        
        // 题目三
        let s = "abcdeababcabcd"
        let (max, subString) = maxLengthOfSubString(string: s)
        print(max, subString)
        
        
        
        
        
    }


}

