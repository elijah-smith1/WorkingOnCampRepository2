//
//  OnCampAppApp.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/8/23.
//

import SwiftUI
import FirebaseCore
import Firebase
import FirebaseInAppMessaging
import FirebaseMessaging
import UserNotifications


class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()

        // Set Firebase Messaging delegate
        Messaging.messaging().delegate = self

        // Set up user notifications
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                    print("Notification permission granted.")
                }
            } else if let error = error {
                print("Error in requesting notifications authorization: \(error)")
            }
        }

        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNS Token received")
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                // Handle the retrieved token as needed
            }
        }
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error)")
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let fcmToken = fcmToken else { return }
        print("Firebase registration token: \(fcmToken)")
        // Additional handling of the FCM token
    }

    // Add other necessary delegate methods if needed
}

// The rest of your SwiftUI App structure remains unchanged
@main
struct OnCampAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var userData = UserData()

    var body: some Scene {
        WindowGroup {
            if Auth.auth().currentUser?.uid != nil {
                /*Signoutbutton*/
                tabBar()
                    .environmentObject(UserData())
                // Use the existing userData
            } else {
                Landing()
            }
        }
    }
}
