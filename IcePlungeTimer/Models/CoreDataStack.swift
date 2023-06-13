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

    // You would no longer use this saveContext() function,
    // as saving will be handled by the @Environment(\.managedObjectContext) in your SwiftUI views.
    // However, you can still call this function when your app is going to background or terminating.

    func fetchPlungeByDate(context: NSManagedObjectContext, date: Date) -> [Plunge] {
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
    
    func fetchAllPlunges(context: NSManagedObjectContext) -> [Plunge]  {
        let request: NSFetchRequest<Plunge> = Plunge.fetchRequest()
        
        do {
            let plunges = try context.fetch(request)
            return plunges
        } catch {
            print("Failed to fetch Plunges: \(error)")
        }
        return []
    }
    
    func savePlunge(minutes: Int,seconds:Int,temperature: Float, caloricBurn:Int, context: NSManagedObjectContext) {
        let newPlunge = Plunge(context: context)
        newPlunge.temperature = temperature
        newPlunge.date = Date()
        newPlunge.caloricBurn = Int32(caloricBurn)
        newPlunge.minutes = Int32(minutes)
        newPlunge.seconds = Int32(seconds)
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteAllPlunges(context: NSManagedObjectContext) {
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
