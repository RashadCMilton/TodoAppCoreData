//
//  TodoAppCoreDataApp.swift
//  TodoAppCoreData
//
//  Created by Rashad Milton on 3/11/25.
//

import SwiftUI

@main
struct TodoAppCoreDataApp: App {
    var body: some Scene {
        WindowGroup {
            NoteListView()
                           .environment(\.managedObjectContext, CoreDataManager.shared.context)
        }
    }
}
