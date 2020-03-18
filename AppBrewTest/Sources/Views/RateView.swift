//
//  RateView.swift
//  AppBrewTest
//
//  Created by Kaishi Sato on 2020/03/18.
//  Copyright © 2020 Kaishi Sato. All rights reserved.
//

import UIKit

class RateView: UIView {

    @IBOutlet weak var fisrtStar: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    @IBOutlet weak var fourthStar: UIImageView!
    @IBOutlet weak var fifthStar: UIImageView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let STAR_COLOR = UIColor(red: 255/255, green: 209/255, blue: 87/255, alpha: 1)

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }

    func loadNib() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }

    func setRate(rate: Int) {
        if rate > 0 {
            fisrtStar.tintColor = STAR_COLOR
        }
        if rate > 1 {
            secondStar.tintColor = STAR_COLOR
        }
        if rate > 2 {
            thirdStar.tintColor = STAR_COLOR
        }
        if rate > 3 {
            fourthStar.tintColor = STAR_COLOR
        }
        if rate > 4 {
            fifthStar.tintColor = STAR_COLOR
        }
    }

}
