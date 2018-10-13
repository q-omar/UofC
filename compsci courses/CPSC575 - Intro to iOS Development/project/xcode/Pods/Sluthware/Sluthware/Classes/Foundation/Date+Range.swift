//
//  Date+Range.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-07.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension TimeInterval
{
	static var second: TimeInterval { return 1.0 }
	static var minute: TimeInterval { return 60.0 }
	static var hour: TimeInterval { return 3600.0 }
	static var day: TimeInterval { return 86400.0 }
	static var week: TimeInterval { return 604800.0 }
	static var month: TimeInterval { return 2592000.0 }
	static var year: TimeInterval { return 30758400.0 }
}





public extension Date
{
	public struct Range
	{
		public let startDate: Date
		fileprivate let _endDate: Date?
		public var endDate: Date {
			return self._endDate ?? Date()
		}
		
		
		
		
		
		public init(_ startDate: Date, _ endDate: Date?)
		{
			self.startDate = startDate
			self._endDate = endDate
		}
		
		public static func forYear(_ year: Int) -> Date.Range?
		{
			guard let startDate = Date(year: year, month: 1, day: 1, hour: 0, minute: 0, second: 0) else { return nil }
			guard let endDate = Date(year: year, month: 12, day: 31, hour: 0, minute: 0, second: 0) else { return nil }
			
			return Date.Range(startDate, endDate)
		}
	}
}




