//
//  UI_403App.swift
//  UI-403
//
//  Created by nyannyan0328 on 2021/12/26.
//

import SwiftUI
import RealmSwift

@main
struct UI_403App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
              .environment(\.realmConfiguration, Realm.Configuration())
        }
    }
}
