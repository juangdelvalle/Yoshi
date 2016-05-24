//
//  AppDelegate.swift
//  YoshiExample
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import Yoshi

struct Notifications {
    static let EnvironmentUpdatedNotification = "EnvironmentUpdatedNotification"
    static let EnvironmentDateUpdatedNotification = "EnvironmentDateUpdatedNotification"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        #if DEBUG
            setupDebugMenu()
        #endif

        return true
    }

    func setupDebugMenu() {
        var menu = [YoshiMenu]()

        menu.append(setupEnvironments())
        menu.append(setupDateSelector())
        menu.append(setupCustom())

        Yoshi.setupDebugMenu(menu)
    }

    private func setupEnvironments() -> YoshiTableViewMenu {
        let production = MenuItem(name: "Production")
        let staging = MenuItem(name: "Staging")
        let qa = MenuItem(name: "QA", selected: true)

        let environmentItems: [YoshiTableViewMenuItem] = [production, staging, qa]

        return TableViewMenu(title: "Environment",
                             subtitle: nil,
                             displayItems: environmentItems,
                             didSelectDisplayItem: { (displayItem) in
                                NSNotificationCenter.defaultCenter()
                                    .postNotificationName(Notifications.EnvironmentUpdatedNotification,
                                        object: displayItem.name)
        })
    }

    private func setupDateSelector() -> YoshiDateSelectorMenu {
        return DateSelector(title: "Environment Date",
                            subtitle: nil,
                            didUpdateDate: { (dateSelected) in
                                NSNotificationCenter.defaultCenter()
                                    .postNotificationName(Notifications.EnvironmentDateUpdatedNotification,
                                        object: dateSelected)
        })
    }

    private func setupCustom() -> YoshiMenu {
        return TestMenuItem()
    }


    // MARK: - Yoshi Invocation options
    // Implement the functionality you want!

    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        Yoshi.motionBegan(motion, withEvent: event)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Yoshi.touchesBegan(touches, withEvent: event)
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Yoshi.touchesMoved(touches, withEvent: event)
    }
}
