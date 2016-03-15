//
//  LoadingViewController.swift
//  LoadingAnimation
//
//  Created by Kevin on 2015/11/27.
//  Copyright © 2015年 Kevin. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var l_label: UILabel!
    @IBOutlet weak var o_label: UILabel!
    @IBOutlet weak var a_label: UILabel!
    @IBOutlet weak var d_label: UILabel!
    @IBOutlet weak var i_label: UILabel!
    @IBOutlet weak var n_label: UILabel!
    @IBOutlet weak var g_label: UILabel!
    @IBOutlet weak var dot1_label: UILabel!
    @IBOutlet weak var dot2_label: UILabel!
    @IBOutlet weak var dot3_label: UILabel!
    @IBOutlet var labels: [UILabel]!

    var currentLabelIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animateRefreshStep1()
    }
    
    
    // MARK: animation
    func animateRefreshStep1() {
        
        self.currentLabelIndex = 0
        
        for idx in 0..<10 {
            
            let delay = Double(idx) * 0.03
            
            UIView.animateWithDuration(0.1, delay: delay, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                self.labels[idx].textColor = UIColor.yellowColor()
                self.labels[idx].transform = CGAffineTransformMakeScale(1.1, 1.1)
                
                }, completion: { (finished) -> Void in
                    
                    UIView.animateWithDuration(0.05, delay: delay, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                        self.labels[idx].transform = CGAffineTransformIdentity
                        self.labels[idx].textColor = UIColor.whiteColor()
                        
                        }, completion: { (finished) -> Void in
                            ++self.currentLabelIndex

                            if self.currentLabelIndex >= self.labels.count {
                                self.performSelector("animateRefreshStep1", withObject: nil, afterDelay: 1.0)
                            }
                    })
            })
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
