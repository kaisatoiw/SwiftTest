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

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map(Locale.init)
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.id` struct is generated, and contains static references to accessibility identifiers.
  struct id {
    struct rateView {
      /// Accessibility identifier `RateView`.
      static let rateView: String = "RateView"

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 6 images.
  struct image {
    /// Image `Image`.
    static let image = Rswift.ImageResource(bundle: R.hostingBundle, name: "Image")
    /// Image `ic_09_star`.
    static let ic_09_star = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_09_star")
    /// Image `ic_16_balloon`.
    static let ic_16_balloon = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_16_balloon")
    /// Image `ic_16_clip`.
    static let ic_16_clip = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_16_clip")
    /// Image `ic_16_heart`.
    static let ic_16_heart = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_16_heart")
    /// Image `nihonjin_-_1`.
    static let nihonjin__1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "nihonjin_-_1")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Image", bundle: ..., traitCollection: ...)`
    static func image(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.image, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic_09_star", bundle: ..., traitCollection: ...)`
    static func ic_09_star(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_09_star, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic_16_balloon", bundle: ..., traitCollection: ...)`
    static func ic_16_balloon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_16_balloon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic_16_clip", bundle: ..., traitCollection: ...)`
    static func ic_16_clip(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_16_clip, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ic_16_heart", bundle: ..., traitCollection: ...)`
    static func ic_16_heart(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_16_heart, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "nihonjin_-_1", bundle: ..., traitCollection: ...)`
    static func nihonjin__1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.nihonjin__1, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 3 nibs.
  struct nib {
    /// Nib `PostNoImgaeCollectionViewCell`.
    static let postNoImgaeCollectionViewCell = _R.nib._PostNoImgaeCollectionViewCell()
    /// Nib `RateView`.
    static let rateView = _R.nib._RateView()
    /// Nib `RecommendCollectionViewCell`.
    static let recommendCollectionViewCell = _R.nib._RecommendCollectionViewCell()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "PostNoImgaeCollectionViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.postNoImgaeCollectionViewCell) instead")
    static func postNoImgaeCollectionViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.postNoImgaeCollectionViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "RateView", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.rateView) instead")
    static func rateView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.rateView)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "RecommendCollectionViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.recommendCollectionViewCell) instead")
    static func recommendCollectionViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.recommendCollectionViewCell)
    }
    #endif

    static func postNoImgaeCollectionViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> PostNoImgaeCollectionViewCell? {
      return R.nib.postNoImgaeCollectionViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? PostNoImgaeCollectionViewCell
    }

    static func rateView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.rateView.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    static func recommendCollectionViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> RecommendCollectionViewCell? {
      return R.nib.recommendCollectionViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? RecommendCollectionViewCell
    }

    fileprivate init() {}
  }

  /// This `R.reuseIdentifier` struct is generated, and contains static references to 2 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `PostNoImgaeCollectionViewCell`.
    static let postNoImgaeCollectionViewCell: Rswift.ReuseIdentifier<PostNoImgaeCollectionViewCell> = Rswift.ReuseIdentifier(identifier: "PostNoImgaeCollectionViewCell")
    /// Reuse identifier `RecommendCollectionViewCell`.
    static let recommendCollectionViewCell: Rswift.ReuseIdentifier<RecommendCollectionViewCell> = Rswift.ReuseIdentifier(identifier: "RecommendCollectionViewCell")

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
    #if os(iOS) || os(tvOS)
    try nib.validate()
    #endif
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib: Rswift.Validatable {
    static func validate() throws {
      try _PostNoImgaeCollectionViewCell.validate()
      try _RateView.validate()
      try _RecommendCollectionViewCell.validate()
    }

    struct _PostNoImgaeCollectionViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType, Rswift.Validatable {
      typealias ReusableType = PostNoImgaeCollectionViewCell

      let bundle = R.hostingBundle
      let identifier = "PostNoImgaeCollectionViewCell"
      let name = "PostNoImgaeCollectionViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> PostNoImgaeCollectionViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? PostNoImgaeCollectionViewCell
      }

      static func validate() throws {
        if UIKit.UIImage(named: "ic_16_balloon", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_16_balloon' is used in nib 'PostNoImgaeCollectionViewCell', but couldn't be loaded.") }
        if UIKit.UIImage(named: "ic_16_clip", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_16_clip' is used in nib 'PostNoImgaeCollectionViewCell', but couldn't be loaded.") }
        if UIKit.UIImage(named: "ic_16_heart", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_16_heart' is used in nib 'PostNoImgaeCollectionViewCell', but couldn't be loaded.") }
        if UIKit.UIImage(named: "nihonjin_-_1", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'nihonjin_-_1' is used in nib 'PostNoImgaeCollectionViewCell', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }

    struct _RateView: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "RateView"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      static func validate() throws {
        if UIKit.UIImage(named: "ic_09_star", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_09_star' is used in nib 'RateView', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }

    struct _RecommendCollectionViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType, Rswift.Validatable {
      typealias ReusableType = RecommendCollectionViewCell

      let bundle = R.hostingBundle
      let identifier = "RecommendCollectionViewCell"
      let name = "RecommendCollectionViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> RecommendCollectionViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? RecommendCollectionViewCell
      }

      static func validate() throws {
        if UIKit.UIImage(named: "ic_16_balloon", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_16_balloon' is used in nib 'RecommendCollectionViewCell', but couldn't be loaded.") }
        if UIKit.UIImage(named: "ic_16_clip", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_16_clip' is used in nib 'RecommendCollectionViewCell', but couldn't be loaded.") }
        if UIKit.UIImage(named: "ic_16_heart", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_16_heart' is used in nib 'RecommendCollectionViewCell', but couldn't be loaded.") }
        if UIKit.UIImage(named: "nihonjin_-_1", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'nihonjin_-_1' is used in nib 'RecommendCollectionViewCell', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try main.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if UIKit.UIImage(named: "Image", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Image' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = ViewController

      let bundle = R.hostingBundle
      let name = "Main"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}