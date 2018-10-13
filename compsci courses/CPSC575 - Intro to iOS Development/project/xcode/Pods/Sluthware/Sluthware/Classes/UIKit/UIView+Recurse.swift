//
//  UIView.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation





public extension UIView
{
	public typealias RecurseBlock = (_ view: UIView, _ stop: inout Bool) -> Void
	
	
	
	
	
    func recurseSubviews(_ block: UIView.RecurseBlock)
    {
        var stop = false
        
        block(self, &stop)
        
        guard !stop else { return }
        
        for subview in self.subviews {
            subview.recurseSubviews(block)
        }
    }
    
    func recurseSuperviews(_ block: UIView.RecurseBlock)
    {
        var stop = false
        
        block(self, &stop)
        
        guard !stop else { return }
        guard let superview = self.superview else { return }
        
        superview.recurseSubviews(block)
    }
}




