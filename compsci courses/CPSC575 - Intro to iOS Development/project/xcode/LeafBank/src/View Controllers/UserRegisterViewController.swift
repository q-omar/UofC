//
//  ProfileViewController.swift
//  LeafBank
//
//  Created by Pat Sluth on 2018-10-07.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import UIKit

import Firebase
import RxSwift
import RxCocoa
import RxSwiftExt
import RxFirebaseAuth

import Eureka
import Alertift





class UserRegisterViewController: FormViewController
{
//	private let rowFirstName: NameRow!
//	private let rowLastName: NameRow!
	
	
	
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		
	}
	
	override func viewWillAppear(_ animated: Bool)
	{
		super.viewWillAppear(animated)
		
		
		
		let rowFirstName = NameRow {
			$0.placeholder = "First Name"
			$0.value = "Pat"
		}

		let rowLastName = NameRow {
			$0.placeholder = "Last Name"
			$0.value = "Sluth"
		}
		
		let rowEmail = EmailRow {
			$0.placeholder = "Email"
			$0.value = "pat.sluth@gmail.com"
		}
		
		let rowPassword = PasswordRow {
			$0.placeholder = "Password"
			$0.value = "abcd1234"
		}
		
		let rowConfirmPassword = PasswordRow {
			$0.placeholder = "Confirm Password"
			$0.value = "abcd1234"
		}

		
		
		
		
		var section = Section()
		
		section <<< rowFirstName
		section <<< rowLastName
		section <<< rowPassword
		section <<< rowConfirmPassword
		
		self.form +++ section
		
		
		section = Section()
		
		section <<< ButtonRow() {
			
			$0.title = "Register"
			
			$0.onCellSelection({ cell, row in
				
				guard let firstName = rowFirstName.value else { return }
				guard let lastName = rowLastName.value else { return }
				guard let email = rowEmail.value else { return }
				guard let password = rowPassword.value else { return }
				guard let confirmPassword = rowConfirmPassword.value else { return }
				
				print(firstName, lastName, password, confirmPassword)
				
				Auth.auth()
					.createUser(withEmail: email, password: password, completion: { result, error in
						
						if let error = error {
							switch AuthErrorCode(rawValue: error._code) {
							case AuthErrorCode.invalidEmail?:
								print("invalid email")
							case AuthErrorCode.emailAlreadyInUse?:
								
								print("emailAlreadyInUse")
//								Auth.auth().signIn(withEmail: email, password: password, completion: { user, error in
//									print(user?.user.displayName)
//								})
								
								
							default:
								print("Create User Error: \(error)")
							}
						} else if let result = result {
							print("Registration Successful!")
							
							let changeRequest = result.user.createProfileChangeRequest()
							
							changeRequest.displayName = "\(firstName) \(lastName)"
							
							changeRequest.commitChanges(completion: { error in
								if let error = error {
									print(error)
								} else {
									self.navigationController?.popViewController(animated: true)
									//						self.dismiss(animated: true, completion: nil)
								}
							})
						}
					})
			})
		}
		
		self.form +++ section
	}
	
	override func viewDidAppear(_ animated: Bool)
	{
		super.viewDidAppear(animated)
		
		
//		self.authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [unowned self] auth, user in
//			if let user = user {
//				self.dismiss(animated: true, completion: nil)
//			} else {
//				print("Signed Out")
//			}
//		}
		
		
		return
		
		
		
		
		
		if let user = Auth.auth().currentUser {
			
			
			
			
			
			print(Auth.auth().currentUser?.displayName)
			return
		} else {
			
		}
		
		print(Auth.auth().currentUser?.displayName)
		
//		Alertift.alert(title: "Sign in", message: "Input your ID and Password")
//			.textField { textField in
//				textField.placeholder = "Email"
//				textField.keyboardType = UIKeyboardType.emailAddress
//				textField.text = "pat.sluth@gmail.com"
//			}
//			.textField { textField in
//				textField.placeholder = "Password"
//				textField.isSecureTextEntry = true
//				textField.text = "abcd1234"
//			}
//			.action(.cancel("Cancel"))
//			.action(.default("Sign in")) { _, _, textFields in
//				guard let email = textFields?[safe: 0]?.text else { return }
//				guard let password = textFields?[safe: 1]?.text else { return }
//
//				Auth.auth()
//					.createUser(withEmail: email, password: password, completion: { user, error in
//						if let error = error {
//							switch AuthErrorCode(rawValue: error._code) {
//							case AuthErrorCode.invalidEmail?:
//								print("invalid email")
//							case AuthErrorCode.emailAlreadyInUse?:
//
//								Auth.auth().signIn(withEmail: email, password: password, completion: { user, error in
//									print(user?.user.displayName)
//								})
//
//
//							default:
//								print("Create User Error: \(error)")
//							}
//						} else {
//							print("Registration Successful!")
//							print(user)
//						}
//					})
//			}
//			.show(on: self, completion: nil)
	}
	
	@IBAction private func doneButtonClicked(_ sender: Any)
	{
		self.dismiss(animated: true, completion: nil)
	}
}





//fileprivate extension ProfileViewController
//{
//	func login(emaial)
//}




