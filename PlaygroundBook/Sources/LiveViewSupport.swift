//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit
import PlaygroundSupport

public func instantiateLiveView() -> PlaygroundLiveViewable {
    let storyboard = UIStoryboard(name: "LiveView", bundle: nil)

    guard let viewController = storyboard.instantiateInitialViewController() else {
        fatalError("LiveView.storyboard does not have an initial scene; please set one or update this function")
    }

    guard let liveViewController = viewController as? WelcomeViewController else {
        fatalError("LiveView.storyboard's initial scene is not a PassionsViewController; please either update the storyboard or this function")
    }

    return liveViewController
}

public func instantiateRadio() -> PlaygroundLiveViewable {
    let storyboard = UIStoryboard(name: "LiveView", bundle: nil)
    
    let viewController = storyboard.instantiateViewController(withIdentifier: "radio")
    
    guard let liveViewController = viewController as? RadioViewController else {
        fatalError("LiveView.storyboard's initial scene is not a PassionsViewController; please either update the storyboard or this function")
    }
    
    return liveViewController
}

public func instantiateStadium() -> PlaygroundLiveViewable {
    let storyboard = UIStoryboard(name: "LiveView", bundle: nil)

    let viewController = storyboard.instantiateViewController(withIdentifier: "stadium")
    
    guard let liveViewController = viewController as? StadiumViewController else {
        fatalError("LiveView.storyboard's initial scene is not a PassionsViewController; please either update the storyboard or this function")
    }
    
    return liveViewController
}
