//
//  UserDataSource.swift
//  LeafBank
//
//  Created by Pat Sluth on 2018-10-17.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation

import Firebase
import FirebaseFirestore
import FirebaseDatabase
import RxSwift
import RxCocoa
import RxSwiftExt
import RxFirebase
import PromiseKit





extension User
{
	final class DataSource
	{
		static let shared = User.DataSource()
		
		
		
		private let _currentUser = BehaviorRelay<User?>(value: nil)
		var currentUser: Observable<User?> {
			return self._currentUser.asObservable().distinctUntilChanged()
		}
		
		
		
		
		
		private init()
		{
			_ = Auth.auth().rx.addIDTokenDidChangeListener()
				.bind(onNext: { auth, user in
					if let user = user {
						user.getIDTokenForcingRefresh(true, completion: { token, error in
							if let error = error {
								print(#file.fileName, #function, error.localizedDescription)
								self._currentUser.accept(nil)
							} else {
								self._currentUser.accept(user)
							}
						})
					} else {
						self._currentUser.accept(nil)
					}
				})
		}
		
		//	static func current() -> Observable<User?>
		//	{
		//		return Observable<User?>.create { observable in
		//
		//			let authStateObservable = Auth.auth().rx.addStateDidChangeListener()
		//				.bind(onNext: { auth, user in
		//					if let user = user {
		//						user.getIDTokenForcingRefresh(true, completion: { token, error in
		//							observable.onNext(user)
		//						})
		//					} else {
		//						observable.onNext(nil)
		//					}
		//				})
		//
		//			return Disposables.create() {
		//				authStateObservable.dispose()
		//			}
		//
		//			//			var handle: AuthStateDidChangeListenerHandle!
		//			//			handle = Auth.auth().addStateDidChangeListener { [unowned self] auth, user in
		//			//				if let user = user {
		//			//					user.getIDTokenForcingRefresh(true, completion: { token, error in
		//			//						if let error = error {
		//			//							resolver(nil)
		//			//						} else {
		//			//							resolver(user)
		//			//						}
		//			//					})
		//			//				} else {
		//			//					resolver(nil)
		//			//				}
		//			//
		//			//				Auth.auth().removeStateDidChangeListener(<#T##listenerHandle: AuthStateDidChangeListenerHandle##AuthStateDidChangeListenerHandle#>)
		//		}
		//	}
		
		func login(_ email: String, _ password: String)// -> Promise<User>
		{
			//return Promise<User> { resolver in
			
			Auth.auth()
				.signIn(withEmail: email, password: password)//, completion: { user, error in
			//self.currentUser.accept(user?.user)
			//				if let error = error {
			//					resolver.reject(error)
			//				} else if let user = user {
			//					resolver.fulfill(user.user)
			//				} else {
			//					resolver.reject(Errors.Message("Login Failed"))
			//				}
			//})
			
			//}
		}
		
		func register(_ email: String,
					  _ password: String,
					  _ profile: User.Profile)
		{
			//return Promise<User> { resolver in
			
			Auth.auth()
				.createUser(withEmail: email, password: password, completion: { user, error in
					if let error = error {
						if AuthErrorCode(rawValue: error._code) == AuthErrorCode.emailAlreadyInUse {
							self.login(email, password)
							//							User.login(email: email, password: password)
							//								.done({ user in
							//									resolver.fulfill(user)
							//								})
							//								.catch({ error in
							//									resolver.reject(error)
							//								})
						}
					} else if let user = user?.user {
						let collection = Firestore.firestore().collection("UserProfiles")
						let document = collection.document(user.uid)
						
						if let data = try? profile.encodeJsonObject([String: Any].self) {
							document.setData(data, merge: true, completion: { error in
								if let error = error {
									print(#file.fileName, #function, error.localizedDescription)
								}
							})
						}
					}
					//						else {
					//							self.currentUser.accept(nil)
					////							resolver.reject(error)
					//						}
					//					} else {
					//						self.currentUser.accept(nil)
					////						resolver.fulfill(user!.user)
					//					}
				})
			
			//}
		}
		
		//	func getProfile(_ email: String, _ password: String, _ profile: UserProfile)// -> Promise<User>
		//	{
		//		//return Promise<User> { resolver in
		//
		//	}
	}
}






