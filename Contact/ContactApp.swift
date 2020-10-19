//
//  ContactApp.swift
//  Contacts (SwiftUI)
//
//  Created by Matteo Manferdini on 19/10/2020.
//  Copyright © 2020 Pure Creek. All rights reserved.
//

import SwiftUI

@main
struct ContactApp: App {
    @StateObject private var stateController = StateController()

	var body: some Scene {
		WindowGroup {
			NavigationView {
				DetailView()
					.environmentObject(stateController)
			}
			.environment(\.colorScheme, .dark)
		}
	}
}
