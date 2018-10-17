//
//  DemoViewController.swift
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/17.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func m1Action(_ sender: Any) {
        let sharedAppdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        sharedAppdelegate.window?.rootViewController = sharedAppdelegate.mainTabBarVc
    }
    @IBAction func m2action(_ sender: Any) {
        let carry = CarryMissionDetailViewController()
        carry.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(carry, animated: true)
      
    }
  

    @IBAction func m3action(_ sender: Any) {
        let clean = CleanMissionDetailViewController()
        clean.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(clean, animated: true)
    }
    
    
    
    @IBAction func m4acion(_ sender: Any) {
        let repair = RepairMissionDetailViewController()
        repair.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(repair, animated: true)
    }
    
    @IBAction func m6action(_ sender: Any) {
        let reply = CertifApplyController()
        reply.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(reply, animated: true)
    }
    
    @IBAction func m7action(_ sender: Any) {
        let feedback=QueFeedbackController()
        feedback.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(feedback, animated: true)
    }
    
    @IBAction func m8action(_ sender: Any) {
        let bank=BankAccountController()
        bank.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(bank, animated: true)
    }
}
