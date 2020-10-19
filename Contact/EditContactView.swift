//
//  EditContactView.swift
//  Contacts (SwiftUI)
//
//  Created by Matteo Manferdini on 19/10/2020.
//  Copyright © 2020 Pure Creek. All rights reserved.
//

import SwiftUI

struct EditContactView: View {
	@State private var draft: Contact = TestData.contact
	@Environment(\.presentationMode) private var presentationMode
	@EnvironmentObject private var stateController: StateController
		
	var body: some View {
		List {
			RoundImage(image: draft.photo)
			EditableRow(title: "Name", text: $draft.name)
			EditableRow(title: "Position", text: $draft.position)
			EditableRow(title: "Email", text: $draft.email)
			EditableRow(title: "Phone", text: $draft.phone)
		}
		.navigationTitle("Edit Contact")
		.onAppear { draft = stateController.contact }
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Button("Cancel", action: cancel)
			}
			ToolbarItem(placement: .navigationBarTrailing) {
				Button("Save", action: save)
			}
		}
	}
}

extension EditContactView {
	func save() {
		stateController.contact = Contact(
			photo: draft.photo,
			name: draft.name,
			position: draft.position,
			email: draft.email,
			phone: draft.phone)
		presentationMode.wrappedValue.dismiss()
	}
	
	func cancel() {
		presentationMode.wrappedValue.dismiss()
	}
}

// MARK: - EditableRow
struct EditableRow: View {
	let title: String
	@Binding var text: String
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			Text(title)
				.font(.footnote)
				.bold()
			TextField("", text: $text)
		}
		.padding(.top, 8.0)
	}
}

// MARK: Previews
struct EditContactView_Previews: PreviewProvider {
	static let contact = TestData.contact
	
	static var previews: some View {
		Group {
			EditableRow(title: "Name", text: .constant(contact.name))
				.previewLayout(.sizeThatFits)
		}
	}
}
