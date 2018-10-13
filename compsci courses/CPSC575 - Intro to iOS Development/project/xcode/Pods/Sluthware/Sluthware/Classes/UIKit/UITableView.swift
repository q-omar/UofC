//
//  UITableView.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation
import ObjectiveC





public extension UITableView
{
	func dequeueReusableCell<T>(ofType: T.Type) -> UITableViewCell?
	{
		let identifier = String(describing: T.self)
		return self.dequeueReusableCell(withIdentifier: identifier)
	}
	
	@available(iOS 6.0, *)
	func dequeueReusableCell<T>(ofType: T.Type,
								for indexPath: IndexPath) -> UITableViewCell
	{
		let identifier = String(describing: T.self)
		return self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
	}
	
	@available(iOS 6.0, *)
	func dequeueReusableHeaderFooterView<T>(ofType: T.Type) -> UITableViewHeaderFooterView?
	{
		let identifier = String(describing: T.self)
		return self.dequeueReusableHeaderFooterView(withIdentifier: identifier)
	}
	
	
	@available(iOS 5.0, *)
	func register<T>(_ nib: UINib?, forType: T.Type)
	{
		let identifier = String(describing: T.self)
		self.register(nib, forCellReuseIdentifier: identifier)
	}
	
	@available(iOS 6.0, *)
	func register<T>(_ cellClass: AnyClass?, forType: T.Type)
	{
		let identifier = String(describing: T.self)
		self.register(cellClass, forCellReuseIdentifier: identifier)
	}
	
	
	@available(iOS 6.0, *)
	func register<T>(_ nib: UINib?, forHeaderFooterViewType: T.Type)
	{
		let identifier = String(describing: T.self)
		self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
	}
	
	@available(iOS 6.0, *)
	func register<T>(_ aClass: AnyClass?, forHeaderFooterViewType: T.Type)
	{
		let identifier = String(describing: T.self)
		self.register(aClass, forHeaderFooterViewReuseIdentifier: identifier)
	}
}





fileprivate var _prototypeCells = Selector(("_prototypeCells"))

public extension UITableView
{
	fileprivate var prototypeCells: [String: UITableViewCell] {
		get
		{
			return (objc_getAssociatedObject(self, &_prototypeCells) as? [String: UITableViewCell]) ?? [:]
		}
		set
		{
			objc_setAssociatedObject(self,
									 &_prototypeCells,
									 newValue,
									 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
	func prototypeCell(withIdentifier identifier: String) -> UITableViewCell?
	{
		if let cell = self.prototypeCells[identifier] {
			return cell
		}
		
		let cell = self.dequeueReusableCell(withIdentifier: identifier)
		self.prototypeCells[identifier] = cell
		
		return cell
	}
	
	
	
	
	
	func prototypeCell<T>(ofType: T.Type) -> UITableViewCell?
	{
		let identifier = String(describing: T.self)
		return self.prototypeCell(withIdentifier: identifier)
	}
}




