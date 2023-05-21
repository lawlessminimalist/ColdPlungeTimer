import CoreData
import Foundation

class CoreDataStack {

    static let shared = CoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PlungeData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func savePlunge(duration: Int, temperature: Float) {
        let context = persistentContainer.viewContext
        let newPlunge = Plunge(context: context)
        newPlunge.duration = Int16(duration)
        newPlunge.temperature = temperature
        newPlunge.date = Date()
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchPlungeByDate(date: Date) -> [Plunge] {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let request: NSFetchRequest<Plunge> = Plunge.fetchRequest()
        let datePredicate = NSPredicate(format: "date == %@", date as NSDate)
        request.predicate = datePredicate

        do {
            let plunges = try context.fetch(request)
            return plunges
        } catch {
            print("Failed to fetch Plunges: \(error)")
            return []
        }
    }
    
    func fetchAllPlunges() {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let request: NSFetchRequest<Plunge> = Plunge.fetchRequest()
        
        do {
            let plunges = try context.fetch(request)
            for plunge in plunges {
                print("Duration: \(plunge.duration), Temperature: \(plunge.temperature), Date: \(plunge.date)")
            }
        } catch {
            print("Failed to fetch Plunges: \(error)")
        }
    }
    
    func deleteAllPlunges() {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Plunge")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to delete Plunges: \(error)")
        }
    }
    
}
