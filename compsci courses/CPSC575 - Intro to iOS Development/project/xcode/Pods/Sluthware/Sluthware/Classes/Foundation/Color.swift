//
//  Color.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public final class Color: Codable
{
	fileprivate enum CodingKeys: String, CodingKey
	{
		case r
		case g
		case b
		case a
	}
	
	
	
	
	
	let r: CGFloat
	let g: CGFloat
	let b: CGFloat
	let a: CGFloat
	
	#if os(iOS)
	
	public lazy var color: UIColor = {
		return UIColor(red: self.r, green: self.g, blue: self.b, alpha: self.a)
	}()
	
	#endif
	
	
	
	
	
	init<T: Sluthware.FloatingPointType>(r: T, g: T, b: T, a: T)
	{
		self.r = r.to()
		self.g = g.to()
		self.b = b.to()
		self.a = a.to()
	}
	
	#if os(iOS)
	init(color: UIColor) throws
	{
		var _r: CGFloat = 0.0
		var _g: CGFloat = 0.0
		var _b: CGFloat = 0.0
		var _a: CGFloat = 0.0
		
		try color.getRGBA(r: &_r, g: &_g, b: &_b, a: &_a)
		
		self.r = _r
		self.g = _g
		self.b = _b
		self.a = _a
	}
	#endif
}




