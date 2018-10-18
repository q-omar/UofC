//
//  BaseTabViewController.swift
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





class BaseTabViewController: UIViewController
{
	private var disposeBag = DisposeBag()
	
	
	
	
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		
		
		guard let navigationBar = self.navigationController?.navigationBar else { return }
		
		
		
		let userButton = UserButton(type: UIButton.ButtonType.custom)
		userButton.translatesAutoresizingMaskIntoConstraints = false
		
		let pointsLabel = UILabel()
		pointsLabel.translatesAutoresizingMaskIntoConstraints = false
		
		
		
		if let largeTitleView = navigationBar.largeTitleView,
			let contentView = navigationBar.contentView {
			
			contentView.addSubview(userButton)
			largeTitleView.addSubview(pointsLabel)
			
			NSLayoutConstraint.activate([
				userButton.heightAnchor.constraint(equalTo: contentView.heightAnchor),
				userButton.widthAnchor.constraint(equalTo: userButton.heightAnchor),
				userButton.rightAnchor.constraint(equalTo: navigationBar.layoutMarginsGuide.rightAnchor),
//				pointsLabel.leftAnchor.constraint(equalTo: navigationBar.layoutMarginsGuide.leftAnchor),
				pointsLabel.bottomAnchor.constraint(equalTo: navigationBar.layoutMarginsGuide.bottomAnchor),
				pointsLabel.rightAnchor.constraint(equalTo: navigationBar.layoutMarginsGuide.rightAnchor),
				])
		} else {
			self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: userButton)
			
			NSLayoutConstraint.activate([
				userButton.widthAnchor.constraint(equalTo: userButton.heightAnchor),
				])
		}
//		if let largeTitleView = navigationBar.largeTitleView {
//
//			navigationBar.addSubview(userButton)
//
//			NSLayoutConstraint.activate([
//				userButton.topAnchor.constraint(equalTo: largeTitleView.topAnchor),
//				userButton.widthAnchor.constraint(equalTo: userButton.heightAnchor),
//				userButton.bottomAnchor.constraint(equalTo: navigationBar.layoutMarginsGuide.bottomAnchor),
//				userButton.rightAnchor.constraint(equalTo: navigationBar.layoutMarginsGuide.rightAnchor),
//				])
//		} else {
//			self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: userButton)
//
//			NSLayoutConstraint.activate([
//				userButton.widthAnchor.constraint(equalTo: userButton.heightAnchor),
//				])
//		}
		
		userButton.rx.tap
			.asDriver()
			.throttle(1.0)
			.drive(onNext: { [unowned self] in
				guard let userViewController = R.storyboard.main.userViewController() else { return }
				self.show(userViewController, sender: userButton)
			})
			.disposed(by: self.disposeBag)
		
		
		
		_ = User.DataSource.shared.currentUser.asObservable()
			.do(onNext: { user in
				userButton.setTitle(nil, for: UIControl.State.normal)
				
				pointsLabel.text = nil
			})
			.unwrap()
			.flatMapLatest({ user in
				user.profileObservable()
					.do(onNext: { profile in
						let firstLetter = profile.firstName.first ?? Character("")
						let lastLetter = profile.lastName.first ?? Character("")
						userButton.setTitle("\(firstLetter)\(lastLetter)", for: UIControl.State.normal)
						
						pointsLabel.text = "\(profile.points) ⭐️"
						
						
						var profile = profile
						profile.points += 1
						Invoke.after(delay: 2.0, {
							user.set(profile)
						})
					})
			})
			.subscribe()
			.disposed(by: self.disposeBag)
	}
}




