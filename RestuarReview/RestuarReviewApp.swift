//
//  RestuarReviewApp.swift
//  RestuarReview
//
//  Created by Denilson Washuma on 29/06/2024.
//

import SwiftUI

import FirebaseCore

//firebase setup https://youtu.be/PxAchicsUYY?list=PL9VJ9OpT-IPSM6dFSwQCIl409gNBsqKTe

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct RestuarReviewApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
