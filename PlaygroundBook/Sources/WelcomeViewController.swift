//
//  WelcomeViewController.swift
//  Book_Sources
//
//  Created by Arthur Melo on 23/03/19.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var border: UIImageView!
    @IBOutlet weak var midfield: UIImageView!
    @IBOutlet weak var passionsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        border.frame = CGRect(x: self.view.frame.width/4 - 150, y: self.view.frame.height/2 - 160, width: 300, height: 300)
        
        midfield.frame = CGRect(x: self.view.frame.width/4 - 125, y: self.view.frame.height/2 - 135, width: 250, height: 250)
        passionsLabel.frame = CGRect(x: self.view.frame.width/4 - 60, y: self.view.frame.height/2 - 45, width: 120, height: 70)
        
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.border.transform = self.border.transform.rotated(by: CGFloat(Double.pi))
        }, completion: nil)
    }
}
