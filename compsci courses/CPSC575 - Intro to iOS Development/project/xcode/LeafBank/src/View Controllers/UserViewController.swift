//
//  UserViewController.swift
//  LeafBank
//
//  Created by Pat Sluth on 2018-10-07.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import UIKit

import Firebase
import FirebaseFirestore
import FirebaseDatabase
import RxSwift
import RxCocoa
import RxSwiftExt
import RxFirebaseAuth
import RxFirebase

import Eureka
import Alertift




class UserViewController: UIViewController
{
//	 @IBOutlet public var tableView: UITableView!
	
	
//	lazy var loginButtonRow: ButtonRow = {
//		return ButtonRow() { [unowned self] in
//
//			$0.title = "Login"
//
//			$0.onCellSelection({ cell, row in
//
//				let identifier = R.segue.userViewController.userRegisterViewController
//				self.performSegue(withIdentifier: identifier, sender: nil)
//			})
//		}
//	}()
//
//	lazy var registerButtonRow: ButtonRow = {
//		return ButtonRow() { [unowned self] in
//
//			$0.title = "Register"
//
//			$0.onCellSelection({ cell, row in
//
//				let identifier = R.segue.userViewController.userRegisterViewController
//				self.performSegue(withIdentifier: identifier, sender: nil)
//			})
//		}
//	}()
	
	
	
	
	
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		_ = User.DataSource.shared.currentUser.asObservable()
			.takeUntil(self.rx.deallocated)
			.do(onNext: { user in
				print("User", user?.email as Any)
			})
			.unwrap()
			.flatMapLatest({ user in
				user.profileObservable()
					.map({ profile in
						(user, profile)
					})
			})
			.bind(onNext: { user, profile in
				print("Profile", profile)
			})
	}
	
	override func viewWillAppear(_ animated: Bool)
	{
		super.viewWillAppear(animated)
	}
	
	override func viewDidAppear(_ animated: Bool)
	{
		super.viewDidAppear(animated)
		
		self.showLoginRegisterAlert()
	}
	
	@IBAction private func doneButtonClicked(_ sender: Any)
	{
		self.dismiss(animated: true, completion: nil)
	}
}





fileprivate extension UserViewController
{
	func showLoginRegisterAlert()
	{
		Alertift.alert(title: nil, message: nil)
			.action(.cancel("Cancel"))
			.action(.default("Login")) { _, _, _ in
				self.showLoginAlert()
			}
			.action(.default("Register")) { _, _, _ in
				self.showRegisterAlert()
			}
			.show(on: self, completion: nil)
	}
	
	func showLoginAlert()
	{
		Alertift.alert(title: "Login", message: nil)
			.textField { textField in
				textField.placeholder = "Email"
				textField.keyboardType = UIKeyboardType.emailAddress
				textField.text = "pat.sluth@gmail.com"
			}
			.textField { textField in
				textField.placeholder = "Password"
				textField.isSecureTextEntry = true
				textField.text = "abcd1234"
			}
			.action(.cancel("Cancel"))
			.action(.default("Login")) { _, _, textFields in
				guard let email = textFields?[safe: 0]?.text else { return }
				guard let password = textFields?[safe: 1]?.text else { return }
				
				let profile = User.Profile(firstName: "Pat", lastName: "Sluth", points: 7)
				User.DataSource.shared.register(email, password, profile)
			}
			.show(on: self, completion: nil)
	}
	
	func showRegisterAlert()
	{
		Alertift.alert(title: "Register", message: nil)
			.textField { textField in
				textField.placeholder = "First Name"
				textField.keyboardType = UIKeyboardType.default
				textField.text = "Pat"
			}
			.textField { textField in
				textField.placeholder = "Last Name"
				textField.keyboardType = UIKeyboardType.default
				textField.text = "Sluth"
			}
			.textField { textField in
				textField.placeholder = "Email"
				textField.keyboardType = UIKeyboardType.emailAddress
				textField.text = "pat.sluth@gmail.com"
			}
			.textField { textField in
				textField.placeholder = "Password"
				textField.isSecureTextEntry = true
				textField.text = "abcd1234"
			}
			.textField { textField in
				textField.placeholder = "Confirm Password"
				textField.isSecureTextEntry = true
				textField.text = "abcd1234"
			}
			.action(.cancel("Cancel"))
			.action(.default("Register")) { _, _, textFields in
				
				// TODO: check passwords match
				
				guard let firstName = textFields?[safe: 0]?.text else { return }
				guard let lastName = textFields?[safe: 1]?.text else { return }
				guard let email = textFields?[safe: 2]?.text else { return }
				guard let password = textFields?[safe: 3]?.text else { return }
				guard let confirmPassword = textFields?[safe: 4]?.text else { return }
				
				let profile = User.Profile(firstName: firstName, lastName: lastName, points: 0)
				User.DataSource.shared.register(email, password, profile)
			}
			.show(on: self, completion: nil)
	}
}




