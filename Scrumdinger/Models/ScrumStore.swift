//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by Luko on 19/11/2022.
//

import Foundation
import SwiftUI

// ObservableObject is a class-constrained protocol for connecting external model data to SwiftUI views.
class ScrumStore: ObservableObject {
    
    // An ObservableObject includes an objectWillChange publisher that emits when one of its @Published properties is about to change. Any view observing an instance of ScrumStore will render again when the scrums value changes.
    @Published var scrums: [DailyScrum] = []
    
    // Scrumdinger will load and save scrums to a file in the user’s Documents folder. You’ll add a function that makes accessing that file more convenient.
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        // Call appendingPathComponent(_:) to return the URL of a file named scrums.data.
        .appendingPathComponent("scrums.data")
    }
    
    // Result is a single type that represents the outcome of an operation, whether it’s a success or failure. The load function accepts a completion closure that it calls asynchronously with either an array of scrums or an error.
    static func load(completion: @escaping (Result<[DailyScrum], Error>) -> Void) {
        
        // You’ll use dispatch queues to choose which tasks run on the main thread or background threads.
        DispatchQueue.global(qos: .background).async {
            
            // Success scenario
            do {
                
                let fileURL = try fileURL()
                
                // Because scrums.data doesn’t exist when a user launches the app for the first time, you call the completion handler with an empty array if there’s an error opening the file handle.
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                
                // Decode the file’s available data into a local constant named dailyScrums.
                let dailyScrums = try JSONDecoder().decode([DailyScrum].self, from: file.availableData)

                // You perform the longer-running tasks of opening the file and decoding its contents on a background queue. When those tasks complete, you switch back to the main queue.
                DispatchQueue.main.async {
                       completion(.success(dailyScrums))
                }
                
              // Failure scenario
              } catch {
                  DispatchQueue.main.async {
                    completion(.failure(error))
                  }
              }
        }
    }
    
    static func save(scrums: [DailyScrum], completion: @escaping (Result<Int, Error>) -> Void)
    
    {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(scrums)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(scrums.count))
                }

            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
}
