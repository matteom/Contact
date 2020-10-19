//
//  DetailView.swift
//  Contacts (SwiftUI)
//
//  Created by Matteo Manferdini on 19/10/2020.
//  Copyright © 2020 Pure Creek. All rights reserved.
//

import SwiftUI

// MARK: - DetailView
struct DetailView: View {
	@EnvironmentObject private var stateController: StateController
	@State private var isSheetPresented = false
	
	var contact: Contact { stateController.contact }

	var body: some View {
		List {
			Header(photo: contact.photo, name: contact.name, position: contact.position)
				.frame(maxWidth: .infinity)
			Row(label: "Email", text: contact.email, destination: URL(string: "mailto:\(contact.email)")!)
			Row(label: "Phone", text: contact.phone, destination: URL(string: "tel://\(contact.phone)")!)
		}
		.listStyle(PlainListStyle())
		.navigationTitle("Contact Details")
		.toolbar {
			Button("Edit", action: { isSheetPresented = true })
		}
		.fullScreenCover(isPresented: $isSheetPresented) {
			NavigationView {
				EditContactView()
			}
			.environment(\.colorScheme, .dark)
		}
	}
}

// MARK: - Header
struct Header: View {
	let photo: UIImage
	let name: String
	let position: String
	
	var body: some View {
		VStack {
			RoundImage(image: photo)
				Text(name)
					.font(.title)
					.bold()
				Text(position)
					.font(.body)
					.foregroundColor(.gray)
		}
		.padding(.bottom, 24.0)
	}
}

// MARK: - Row
struct Row: View {
	let label: String
	let text: String
	let destination: URL
	
	var body: some View {
		VStack(alignment: .leading) {
			Text(label)
				.font(.footnote)
				.bold()
			Link(text, destination: destination)
				.buttonStyle(BorderlessButtonStyle())
		}
		.padding(.top, 8.0)
	}
}

// MARK: - Previews

struct DetailView_Previews: PreviewProvider {
    static let contact = TestData.contact

    static var previews: some View {
		Group {
			Group {
				Header(photo: contact.photo, name: contact.name, position: contact.position)
				Row(label: "Email", text: contact.email, destination: URL(string: "example.com")!)
			}
			.padding()
			.previewLayout(.sizeThatFits)
		}
    }
}
