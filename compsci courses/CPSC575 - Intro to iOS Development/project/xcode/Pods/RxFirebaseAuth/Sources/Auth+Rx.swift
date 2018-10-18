//
//  Auth+Rx.swift
//  RxFirebase
//
//  Created by suguru-kishimoto on 2017/10/17.
//  Copyright © 2017年 Suguru Kishimoto. All rights reserved.
//

import Foundation
import FirebaseAuth
import RxSwift

public enum AuthError: Error {
    case userNotFound
}

// MARK: - Listener
extension Reactive where Base: Auth {
    public func addStateDidChangeListener() -> Observable<(Auth, User?)> {
        return .create { observer in
            let handle = self.base.addStateDidChangeListener { (auth, user) in
                observer.onNext((auth, user))
            }
            return Disposables.create {
                self.base.removeStateDidChangeListener(handle)
            }
        }
    }

    public func addIDTokenDidChangeListener() -> Observable<(Auth, User?)> {
        return .create { observer in
            let handle = self.base.addIDTokenDidChangeListener { (auth, user) in
                observer.onNext((auth, user))
            }
            return Disposables.create {
                self.base.removeIDTokenDidChangeListener(handle)
            }
        }
    }
}

// MARK: - Create user
extension Reactive where Base: Auth {
    public func createUser(withEmail email: String, password: String) -> Single<AuthDataResult> {
        return .create { observer in
            self.base.createUser(withEmail: email, password: password, completion: singleEventHandler(observer))
            return Disposables.create()
        }
    }
}


// MARK: - Sign in
extension Reactive where Base: Auth {
    public func signInAnonymously() -> Single<AuthDataResult> {
        return .create { observer in
            self.base.signInAnonymously(completion: singleEventHandler(observer))
            return Disposables.create()
        }
    }
    
    public func signIn(withEmail email: String, password: String) -> Single<AuthDataResult> {
        return .create { observer in
            self.base.signIn(withEmail: email, password: password, completion: singleEventHandler(observer))
            return Disposables.create()
        }
    }
    
    public func signInWith(customToken: String) -> Single<AuthDataResult> {
        return .create { observer in
            self.base.signIn(withCustomToken: customToken, completion: singleEventHandler(observer))
            return Disposables.create()
        }
    }

    public func signInWithFacebook(withAccessToken accessToken: String) -> Single<AuthDataResult> {
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
        return signInAndRetriveData(with: credential)
    }

    public func signInWithTwitter(withToken token: String, secret: String) -> Single<AuthDataResult> {
        let credential = TwitterAuthProvider.credential(withToken: token, secret: secret)
        return signInAndRetriveData(with: credential)
    }

    public func signInWithPhoneAuth(withVerificationID verificationID: String, verificationCode code: String) -> Single<AuthDataResult> {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        return signInAndRetriveData(with: credential)
    }

    public func signInWithGitHub(withToken token: String) -> Single<AuthDataResult> {
        let credential = GitHubAuthProvider.credential(withToken: token)
        return signInAndRetriveData(with: credential)
    }

    public func signInAndRetriveData(with credential: AuthCredential) -> Single<AuthDataResult> {
        return .create { observer in
            self.base.signInAndRetrieveData(with: credential, completion: singleEventHandler(observer))
            return Disposables.create()
        }
    }
}

// MARK: - Link
extension Reactive where Base: Auth {
    public func linkWithFacebook(withAccessToken accessToken: String) -> Single<AuthDataResult> {
        return link(with: FacebookAuthProvider.credential(withAccessToken: accessToken))
    }

    public func linkWithTwitter(withToken token: String, secret: String) -> Single<AuthDataResult> {
        return link(with: TwitterAuthProvider.credential(withToken: token, secret: secret))
    }

    public func linkWithPhoneAuth(withVerificationID verificationID: String, verificationCode code: String) -> Single<AuthDataResult> {
        return link(with: PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code))
    }

    public func linkWithGitHub(withToken token: String) -> Single<AuthDataResult> {
        return link(with: GitHubAuthProvider.credential(withToken: token))
    }

    func linkWithEmailAuth(email: String, password: String) -> Single<AuthDataResult> {
        return link(with: EmailAuthProvider.credential(withEmail: email, password: password))
    }

    public func link(with credential: AuthCredential) -> Single<AuthDataResult> {
        return base.currentUser.map { $0.rx.linkAndRetrieveData(with: credential) } ?? .error(AuthError.userNotFound)
    }

    public func unlink(with provider: String) -> Single<User> {
        return base.currentUser.map { $0.rx.unlink(with: provider) } ?? .error(AuthError.userNotFound)
    }
}

// MARK: - Reload user
extension Reactive where Base: Auth {
    public func reloadUser() -> Single<User> {
        return base.currentUser
            .map {
                $0.rx
                    .reload()
                    .flatMap { Auth.auth().currentUser.map(Single.just) ?? .error(AuthError.userNotFound) }
            } ?? .error(AuthError.userNotFound)
    }
}

// MARK: - Sign out
extension Reactive where Base: Auth {
    public func signOut() -> Single<Void> {
        return .create { observer in
            do {
                try self.base.signOut()
                observer(.success(()))
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
}


// MARK: - Send password reset
extension Reactive where Base: Auth {
    public func sendPasswordReset(withEmail email: String) -> Single<Void> {
        return .create { observer in
            self.base.sendPasswordReset(withEmail: email, completion: singleEventErrorHandler(observer))
            return Disposables.create()
        }
    }

    public func sendPasswordReset(withEmail email: String, actionCodeSettings: ActionCodeSettings) -> Single<Void> {
        return .create { observer in
            self.base.sendPasswordReset(withEmail: email, actionCodeSettings: actionCodeSettings, completion: singleEventErrorHandler(observer))
            return Disposables.create()
        }
    }
}
