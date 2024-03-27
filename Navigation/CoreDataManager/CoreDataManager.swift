//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Миша Вашкевич on 27.03.2024.
//

import Foundation
import CoreData
import StorageService

protocol CoreDataManagerProtocol {
    
    var posts: [Post] { get }
    func savePostToFavorite(item: PostStruct)
    func delelePostFromFvorite(atIndex: Int)
}

class CoreDataManager: CoreDataManagerProtocol {
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
      }()
    
    var posts: [Post] {
        fetchFavoritePosts()
    }
    
    func savePostToFavorite(item: PostStruct) {

        let post = Post(context: context)
        post.author = item.author
        post.image = item.image?.pngData()
        post.likes = Int32(item.likes)
        post.views = Int32(item.views)
        post.postText = item.description
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func delelePostFromFvorite(atIndex: Int) {
        let postToDelete = posts[atIndex]
        persistentContainer.viewContext.delete(postToDelete)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fetchFavoritePosts() -> [Post] {
        
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        
        do {
           let posts = try context.fetch(fetchRequest)
            return posts
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
