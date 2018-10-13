//
//  Codable.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-10-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension Decodable
{
	static func decode(data: Data?) throws -> Self
	{
		guard let data = data else {
			throw Errors.Message("\(String(describing: Self.self)) \(#function) failed")
		}
		let decoder = JSONDecoder()
		return try decoder.decode(Self.self, from: data)
	}
	
	static func decode(string: String?) throws -> Self
	{
		guard let data = string?.removingPercentEncodingSafe.data(using: String.Encoding.utf8) else {
			throw Errors.Message("\(String(describing: Self.self)) \(#function) failed")
		}
		
		return try Self.decode(data: data)
	}
	
	static func decode<T>(jsonObject: T?) throws -> Self
	{
		guard let jsonObject = jsonObject else {
			throw Errors.Message("\(String(describing: Self.self)) \(#function) failed")
		}
		let data = try JSONSerialization.data(withJSONObject: jsonObject)
		return try self.decode(data: data)
	}
	
	static func decode<T>(_ jsonObjectType: T.Type, fileURL: URL) throws -> Self
	{
		guard let jsonObject = NSDictionary(contentsOf: fileURL) as? T else {
			throw Errors.Message("\(String(describing: Self.self)) \(#function) failed")
		}
		let data = try JSONSerialization.data(withJSONObject: jsonObject)
		return try self.decode(data: data)
	}
}




