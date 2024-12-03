//
//  EditContactView.swift
//  Contact
//
//  Created by Matteo Manferdini on 03/12/24.
//

import SwiftUI

struct EditContactView: View {
	@State private var viewModel: ViewModel?
	@Environment(\.dismiss) private var dismiss
	@Environment(StateController.self) private var stateController

	var body: some View {
		NavigationStack {
			if let viewModel {
				Form {
					@Bindable var viewModel = viewModel
					EditableDetail(title: "Name", text: $viewModel.draft.name)
					EditableDetail(title: "Position", text: $viewModel.draft.position)
					EditableDetail(title: "Email", text: $viewModel.draft.email)
					EditableDetail(title: "Phone", text: $viewModel.draft.phone)
				}
				.navigationTitle("Edit Contact")
				.toolbar {
					ToolbarItem(placement: .navigationBarLeading) {
						Button("Cancel") { dismiss() }
					}
					ToolbarItem(placement: .navigationBarTrailing) {
						Button("Save") {
							stateController.contact = viewModel.draft
							dismiss()
						}
						.disabled(!viewModel.canSave)
					}
				}
			}
		}
		.task {
			self.viewModel = ViewModel(draft: stateController.contact)
		}
	}
}

#Preview {
	EditContactView()
		.environment(StateController())
}

struct EditableDetail: View {
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

#Preview("Editable Row") {
	@Previewable @State var name: String = Contact.default.name
	List {
		EditableDetail(title: "Name", text: $name)
	}
}

@Observable
private class ViewModel {
	var draft: Contact

	var canSave: Bool {
		!draft.name.isEmpty
	}

	init(draft: Contact) {
		self.draft = draft
	}
}
