//
//  AniTestViewController.swift
//  ViewControllerChangeAnim
//
//  Created by Murph Lu on 2017/5/11.
//  Copyright © 2017年 Murph Lu. All rights reserved.
//

import UIKit

class AniTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        // Do any additional setup after loading the view.
        let btn = UIButton()
        btn.setTitle("dismiss", for: .normal)
        btn.addTarget(self, action: #selector(dismissControl), for: .touchUpInside)
        btn.frame = CGRect.init(x: 100, y: 100, width: 100, height: 100)
        self.view.addSubview(btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    @objc func dismissControl(){
        self.dismiss(animated: true) { 
            
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
