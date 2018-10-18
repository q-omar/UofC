//
//  User+Profile.swift
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
import RxFirebaseAuth





extension User
{
	func profileObservable() -> Observable<User.Profile>
	{
		return Observable.create { observable in
			
			let collection = Firestore.firestore().collection("UserProfiles")
			let document = collection.document(self.uid)
			
			let listener = document.addSnapshotListener({ snapshot, error in
				if let error = error {
					observable.onError(error)
				} else if let snapshot = snapshot {
					do {
						let profile = try User.Profile.decode(jsonObject: snapshot.data())
						observable.onNext(profile)
					} catch {
						observable.onError(error)
					}
				}
			})
			
			return Disposables.create() {
				listener.remove()
			}
		}
	}
	
	func set(_ profile: User.Profile)
	{
		let collection = Firestore.firestore().collection("UserProfiles")
		let document = collection.document(self.uid)
		
		if let data = try? profile.encodeJsonObject([String: Any].self) {
			document.setData(data, merge: true, completion: { error in
				if let error = error {
					print(#file.fileName, #function, error.localizedDescription)
				}
			})
		}
	}
}





extension User
{
	struct Profile: Codable
	{
		private enum CodingKeys: String, CodingKey
		{
			case firstName
			case lastName
			case points
		}
		
		
		
		
		
		var firstName: String
		var lastName: String
		var points: Int
		
		
		
		
		
		init(firstName: String, lastName: String, points: Int)
		{
			self.firstName = firstName
			self.lastName = lastName
			self.points = points
		}
		
		init(from decoder: Decoder) throws
		{
			let container = try decoder.container(keyedBy: CodingKeys.self)
			
			
			
			self.firstName = try container.decode(String.self, forKey: .firstName)
			self.lastName = try container.decode(String.self, forKey: .lastName)
			self.points = try container.decode(Int.self, forKey: .points)
		}
	}
}




