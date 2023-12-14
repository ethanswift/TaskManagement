//
//  CoreDataManager.swift
//  TaskManagement
//
//  Created by ehsan sat on 12/14/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager: ObservableObject {
    @Published var tasks: [Task] = []
    static let sharedManager: CoreDataManager = CoreDataManager()
    private init() {}
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskManagement")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load persistent store")
            }
        }
        return container
    }()
    func saveContext() {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                print("Context didn't load")
                print(error)
                print(error.userInfo)
                fatalError()
            }
        }
    }
//    func getTask(completion: @escaping () -> Void) {
//        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<Task>(entityName: "TaskEntity")
//        do {
//            let retrievedTasks = try managedContext.fetch(fetchRequest)
//            let targetTasks = retrievedTas.first! as UserProfile
//            print("Target Profile:",targetProfile)
//            userProfile.bio = targetProfile.bio ?? " "
//            userProfile.displayName = targetProfile.displayName ?? " "
//            userProfile.location = targetProfile.location ?? " "
//            userProfile.website = targetProfile.website ?? " "
//            var userLocalPhoto: UserLocalPhoto = UserLocalPhoto()
//            userLocalPhoto.id = targetProfile.images?.id ?? " "
//            userLocalPhoto.dateAdded = targetProfile.images?.dateAdded ?? " "
//            userLocalPhoto.image = targetProfile.images?.image ?? Data()
//            userProfile.profilePicture = userLocalPhoto
//            completion()
//        } catch let error as NSError {
//            print("Error fetching profile : ", error, error.userInfo)
//        }
//    }
}
