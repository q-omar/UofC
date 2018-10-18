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
	func medicationsObservable() -> Observable<User.Medications>
	{
		return Observable.create { observable in
			
			let collection = Firestore.firestore().collection("UserMedications")
			let document = collection.document(self.uid)
			
			let listener = document.addSnapshotListener({ snapshot, error in
				if let error = error {
					observable.onError(error)
				} else if let snapshot = snapshot {
					do {
						let medications = try User.Medications.decode(jsonObject: snapshot.data())
						observable.onNext(medications)
					} catch {
						observable.onNext(User.Medications())
//						observable.onError(error)
					}
				}
			})
			
			return Disposables.create() {
				listener.remove()
			}
		}
	}
	
	func set(_ medications: User.Medications)
	{
		let collection = Firestore.firestore().collection("UserMedications")
		let document = collection.document(self.uid)
		
		do {
			let data = try medications.encodeJsonObject([String: Any].self)
			document.setData(data, merge: true, completion: { error in
				if let error = error {
					print(#file.fileName, #function, error.localizedDescription)
				}
			})
		} catch {
			print(#file.fileName, #function, error)
		}
	}
}





extension User
{
	struct Medication: Codable
	{
		private enum CodingKeys: String, CodingKey
		{
			case name
		}
		
		
		
		
		
		var name: String
		
		
		
		
		
		init(name: String)
		{
			self.name = name
		}
		
		init(from decoder: Decoder) throws
		{
			let container = try decoder.container(keyedBy: CodingKeys.self)
			
			
			
			self.name = try container.decode(String.self, forKey: .name)
		}
	}
}





extension User
{
	struct Medications: Codable
	{
		private enum CodingKeys: String, CodingKey
		{
			case values
		}





		var values: [User.Medication]





		init(values: [User.Medication] = [])
		{
			self.values = values
		}

		init(from decoder: Decoder) throws
		{
			let container = try decoder.container(keyedBy: CodingKeys.self)



			self.values = try container.decode([User.Medication].self, forKey: .values)
		}
	}
}




