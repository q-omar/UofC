//
//  BaseTabViewController.swift
//  LeafBank
//
//  Created by Pat Sluth on 2018-10-07.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import UIKit

import Rswift
import RxSwift
import RxCocoa
import Sluthware





class BaseTabViewController: UIViewController
{
	private var disposeBag = DisposeBag()
	
	
	
	
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		guard let navigationBar = self.navigationController?.navigationBar else { return }
		let profileButton = ProfileButton(type: UIButton.ButtonType.custom)
		
		if let largeTitleView = navigationBar.largeTitleView {
			navigationBar.addSubview(profileButton)
			
			NSLayoutConstraint.activate([
				profileButton.topAnchor.constraint(equalTo: largeTitleView.topAnchor),
				profileButton.widthAnchor.constraint(equalTo: profileButton.heightAnchor, multiplier: 1.0),
				profileButton.bottomAnchor.constraint(equalTo: navigationBar.layoutMarginsGuide.bottomAnchor),
				profileButton.rightAnchor.constraint(equalTo: navigationBar.layoutMarginsGuide.rightAnchor),
				])
		} else {
			self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
			
			NSLayoutConstraint.activate([
				profileButton.widthAnchor.constraint(equalTo: profileButton.heightAnchor, multiplier: 1.0),
				])
		}
		
		profileButton.rx.tap
			.asDriver()
			.throttle(1.0)
			.drive(onNext: { [unowned self] in
				guard let profileViewController = R.storyboard.main.profileViewController() else { return }
				self.show(profileViewController, sender: profileButton)
			})
			.disposed(by: self.disposeBag)
	}
}




