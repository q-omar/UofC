//
//  UserButton.swift
//  LeafBank
//
//  Created by Pat Sluth on 2018-10-07.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import UIKit





class UserButton: UIButton
{
	override func willMove(toSuperview newSuperview: UIView?)
	{
		super.willMove(toSuperview: newSuperview)
		
		self.layer.masksToBounds = true
		self.layer.borderWidth = 2.0
		self.layer.borderColor = self.tintColor.cgColor
		self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 4.0, bottom: 0.0, right: 4.0)
		
		self.titleLabel?.minimumScaleFactor = 0.1
		self.titleLabel?.numberOfLines = 1
		self.titleLabel?.adjustsFontSizeToFitWidth = true
		self.titleLabel?.textAlignment = NSTextAlignment.center
		self.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
		self.titleLabel?.baselineAdjustment = UIBaselineAdjustment.alignCenters
		
		self.setTitleColor(self.tintColor, for: UIControl.State.normal)
	}
	
	override func layoutSubviews()
	{
		super.layoutSubviews()
		
		self.layer.cornerRadius = self.bounds.midX
	}
}




