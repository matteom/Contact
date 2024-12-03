//
//  ContentView.swift
//  Contact
//
//  Created by Matteo Manferdini on 03/12/24.
//

import SwiftUI

struct ContentView: View {
	@State private var isEditing = false
	@Environment(\.colorScheme) var colorScheme
	@Environment(StateController.self) private var stateController

	var contact: Contact { stateController.contact }

	var body: some View {
		List {
			Header(photo: contact.photo, name: contact.name, position: contact.position)
				.frame(maxWidth: .infinity)
			Detail(
				label: "Email",
				text: contact.email,
				destination: URL(string: "mailto:\(contact.email)")!
			)
			Detail(
				label: "Phone",
				text: contact.phone,
				destination: URL(string: "tel://\(contact.phone)")!
			)
		}
		.listStyle(.plain)
		.navigationTitle("Contact Details")
		.toolbar {
			Button("Edit", action: { isEditing = true })
		}
		.fullScreenCover(isPresented: $isEditing) {
			EditContactView()
				.environment(\.colorScheme, colorScheme)
		}
	}
}

#Preview {
	NavigationStack {
		ContentView()
			.environment(StateController())
	}
}

private struct Header: View {
	let photo: Image
	let name: String
	let position: String

	var body: some View {
		VStack {
			photo
				.resizable()
				.scaledToFill()
				.frame(width: 200, height: 200)
				.clipShape(Circle())
				.overlay(
					Circle().stroke(Color.white, lineWidth: 2.0))
			Text(name)
				.font(.title)
				.bold()
			Text(position)
				.font(.body)
				.foregroundStyle(.secondary)
		}
		.padding(.bottom, 24)
		.frame(maxWidth: .infinity)
		.alignmentGuide(.listRowSeparatorLeading) { $0[.leading] }
	}
}

#Preview("Header") {
	List {
		let contact = Contact.default
		Header(
			photo: contact.photo,
			name: contact.name,
			position: contact.position
		)
	}
	.listStyle(.plain)
}

private struct Detail: View {
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

#Preview("Detail") {
	List {
		Detail(
			label: "Email",
			text: Contact.default.email,
			destination: URL(string: "example.com")!
		)
	}
	.listStyle(.plain)
}
