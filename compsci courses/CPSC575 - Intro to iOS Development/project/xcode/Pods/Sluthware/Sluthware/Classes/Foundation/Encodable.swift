//
//  Encodable.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-10-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension Encodable
{
	func encode() throws -> Data
	{
		let encoder = JSONEncoder()
		encoder.outputFormatting = JSONEncoder.OutputFormatting.prettyPrinted
		return try encoder.encode(self)
	}
	
	func encodeString() throws -> String
	{
		let data = try self.encode()
		guard let string = String(data: data, encoding: String.Encoding.utf8) else {
			throw Errors.Message("\(String(describing: Self.self)) \(#function) failed")
		}
		return string
	}
	
	func encodeJsonObject<T>(_ type: T.Type) throws -> T
	{
		let encoder = JSONEncoder()
		encoder.outputFormatting = JSONEncoder.OutputFormatting.prettyPrinted
		let data = try encoder.encode(self)
		guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? T else {
			throw Errors.Message("\(String(describing: Self.self)) \(#function) failed")
		}
		return jsonObject
	}
}




