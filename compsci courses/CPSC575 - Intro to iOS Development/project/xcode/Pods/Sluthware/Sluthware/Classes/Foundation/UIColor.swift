//
//  Array.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





#if os(iOS)

extension UIColor
{
	public func getRGBA(r: inout CGFloat, g: inout CGFloat, b: inout CGFloat, a: inout CGFloat) throws
	{
		r = 0.0
		g = 0.0
		b = 0.0
		a = 0.0
		
		if !self.getRed(&r, green: &g, blue: &b, alpha: &a) {
			throw Errors.Message(String(format: "%@ failed", #function))
		}
	}
}

#endif




