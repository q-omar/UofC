//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 0 colors.
  struct color {
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `GoogleService-Info.plist`.
    static let googleServiceInfoPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "GoogleService-Info", pathExtension: "plist")
    
    /// `bundle.url(forResource: "GoogleService-Info", withExtension: "plist")`
    static func googleServiceInfoPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.googleServiceInfoPlist
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 4 images.
  struct image {
    /// Image `icons8-gift-64`.
    static let icons8Gift64 = Rswift.ImageResource(bundle: R.hostingBundle, name: "icons8-gift-64")
    /// Image `icons8-herbal-medicine-64`.
    static let icons8HerbalMedicine64 = Rswift.ImageResource(bundle: R.hostingBundle, name: "icons8-herbal-medicine-64")
    /// Image `icons8-treatment-64`.
    static let icons8Treatment64 = Rswift.ImageResource(bundle: R.hostingBundle, name: "icons8-treatment-64")
    /// Image `storeSample`.
    static let storeSample = Rswift.ImageResource(bundle: R.hostingBundle, name: "storeSample")
    
    /// `UIImage(named: "icons8-gift-64", bundle: ..., traitCollection: ...)`
    static func icons8Gift64(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icons8Gift64, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icons8-herbal-medicine-64", bundle: ..., traitCollection: ...)`
    static func icons8HerbalMedicine64(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icons8HerbalMedicine64, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icons8-treatment-64", bundle: ..., traitCollection: ...)`
    static func icons8Treatment64(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icons8Treatment64, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "storeSample", bundle: ..., traitCollection: ...)`
    static func storeSample(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.storeSample, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 0 nibs.
  struct nib {
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 0 reuse identifiers.
  struct reuseIdentifier {
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 1 view controllers.
  struct segue {
    /// This struct is generated for `UserViewController`, and contains static references to 1 segues.
    struct userViewController {
      /// Segue identifier `UserRegisterViewController`.
      static let userRegisterViewController: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, UserViewController, UserRegisterViewController> = Rswift.StoryboardSegueIdentifier(identifier: "UserRegisterViewController")
      
      /// Optionally returns a typed version of segue `UserRegisterViewController`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func userRegisterViewController(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, UserViewController, UserRegisterViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.userViewController.userRegisterViewController, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 0 localization tables.
  struct string {
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try main.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UITabBarController
      
      let bundle = R.hostingBundle
      let name = "Main"
      let userViewController = StoryboardViewControllerResource<UIKit.UINavigationController>(identifier: "UserViewController")
      
      func userViewController(_: Void = ()) -> UIKit.UINavigationController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: userViewController)
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "icons8-herbal-medicine-64") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icons8-herbal-medicine-64' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icons8-gift-64") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icons8-gift-64' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icons8-treatment-64") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icons8-treatment-64' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "storeSample") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'storeSample' is used in storyboard 'Main', but couldn't be loaded.") }
        if _R.storyboard.main().userViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'userViewController' could not be loaded from storyboard 'Main' as 'UIKit.UINavigationController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}