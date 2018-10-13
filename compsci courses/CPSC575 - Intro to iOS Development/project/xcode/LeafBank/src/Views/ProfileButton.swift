//
//  BaseTabViewController.swift
//  LeafBank
//
//  Created by Pat Sluth on 2018-10-07.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import UIKit





class ProfileButton: UIButton
{
	override func willMove(toSuperview newSuperview: UIView?)
	{
		super.willMove(toSuperview: newSuperview)
		
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = UIColor.blue
		self.layer.masksToBounds = true
	}
	
	override func layoutSubviews()
	{
		super.layoutSubviews()
		
		self.layer.cornerRadius = self.bounds.midX
	}
}




