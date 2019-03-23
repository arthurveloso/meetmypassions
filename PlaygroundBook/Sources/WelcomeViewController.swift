//
//  WelcomeViewController.swift
//  Book_Sources
//
//  Created by Arthur Melo on 23/03/19.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var border: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.border.transform = self.border.transform.rotated(by: CGFloat(Double.pi))
        }, completion: nil)

        // Do any additional setup after loading the view.
    }
}
