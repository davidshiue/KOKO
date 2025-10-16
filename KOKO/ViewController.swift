//
//  ViewController.swift
//  KOKO
//
//  Created by David Shiue on 2025/10/16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        WebApiManager.shared.getMan()
    }

    @IBAction func scenario1Click(_ sender: UIButton) {
        pushToSecondViewController()
    }
    
    @IBAction func scenario2Click(_ sender: UIButton) {
        pushToSecondViewController()
    }
    
    @IBAction func scenario3Click(_ sender: UIButton) {
        pushToSecondViewController()
    }
    
    // MARK: - 推送方法
    private func pushToSecondViewController() {
        // 获取 Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 通过 Storyboard ID 实例化第二个视图控制器
        guard let secondVC = storyboard.instantiateViewController(
            withIdentifier: "FriendViewController"
        ) as? FriendViewController else {
            print("无法找到 SecondViewController")
            return
        }
        
        // 传递数据
        //secondVC.userName = "张三"
        //secondVC.userId = 123
        
        // 推送页面
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

