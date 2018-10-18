//
//  MedicationsViewController.swift
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

import Alertift





class MedicationsViewController: BaseTabViewController
{
	private var disposeBag = DisposeBag()
	
	
	
	
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		_ = User.DataSource.shared.currentUser.asObservable()
			.do(onNext: { user in
			})
			.unwrap()
			.flatMapLatest({ user in
				user.medicationsObservable()
					.do(onNext: { medications in
						
						let title = "\(medications.values.count) Medications"
						var message = ""
						medications.values.forEach {
							message += "\($0)\n"
						}
						
						Alertift.alert(title: title, message: message)
							.textField { textField in
								textField.placeholder = "Medication Name"
								textField.keyboardType = UIKeyboardType.namePhonePad
							}
							.action(.cancel("Cancel"))
							.action(.default("Add Medication")) { _, _, textFields in
								guard let medicationName = textFields?[safe: 0]?.text else { return }
								
								var medications = medications
								let medication = User.Medication(name: medicationName)
								medications.values.append(medication)
								
								user.set(medications)
							}
							.show(on: self, completion: nil)
						
					})
			})
			.subscribe()
			.disposed(by: self.disposeBag)
	}
}




