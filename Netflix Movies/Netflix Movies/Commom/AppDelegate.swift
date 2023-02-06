//
//  AppDelegate.swift
//  Netflix Movies
//
//  Created by Khanh on 15/11/2022.
//

import UIKit
import CoreData
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

       lazy var persistentContainer: NSPersistentContainer = {
           let container = NSPersistentContainer(name: "NetflixMovieData")
           container.loadPersistentStores(completionHandler: { (storeDescription, error) in
               if let error = error as NSError? {
                   fatalError("Unresolved error \(error), \(error.userInfo)")
               }
           })
           return container
       }()
}

