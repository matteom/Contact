//
//  ContactApp.swift
//  Contact
//
//  Created by Matteo Manferdini on 03/12/24.
//

import SwiftUI

@main
struct ContactApp: App {
	@State private var stateController = StateController()

    var body: some Scene {
        WindowGroup {
			NavigationStack {
				ContentView()
			}
			.environment(\.colorScheme, .dark)
			.environment(stateController)
        }
    }
}
