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
        
        let nums = [1, 2, 4, 5, 6, 28, 32, 33]
        
        let ret = sumOfTwoNum(items: nums, target: 34)
        
        print(ret)
    }


}

