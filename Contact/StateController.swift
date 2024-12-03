//
//  StateController.swift
//  Contact
//
//  Created by Matteo Manferdini on 03/12/24.
//

import Foundation
import Observation

@Observable
class StateController {
	private let contactURL = URL
		.documentsDirectory
		.appendingPathComponent("contacts")
		.appendingPathExtension("json")

	var contact: Contact {
		didSet {
			guard let data = try? JSONEncoder().encode(contact) else { return }
			try? data.write(to: contactURL)
		}
	}

	init() {
		guard let data = try? Data(contentsOf: contactURL),
			  let contact = try? JSONDecoder().decode(Contact.self, from: data)
		else {
			self.contact = .default
			return
		}
		self.contact = contact
	}
}
