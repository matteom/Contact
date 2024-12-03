//
//  Contact.swift
//  Contacts
//
//  Created by Matteo Manferdini on 27/01/2019.
//  Copyright © 2019 Pure Creek. All rights reserved.
//

import SwiftUI

struct Contact: Codable {
	var name: String
	var position: String
	var email: String
	var phone: String
	var photo = Image(.madison)

	enum CodingKeys: CodingKey {
		case name
		case position
		case email
		case phone
	}
}

extension Contact {
	static var `default`: Self {
		Contact(
			name: "Madison Thompson",
			position: "Sales, Gale Foods",
			email: "madison@galefoods.com",
			phone: "4-(968)705-1370"
		)
	}
}
