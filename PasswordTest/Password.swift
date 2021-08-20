//
//  PasswordModel.swift
//  PasswordTest
//
//  Created by Alex Lundquist on 8/19/21.
//

import Foundation

class Password: ObservableObject {
	@Published var id = UUID()
	@Published var passwordCount: Int = 0
	@Published var password: String
	
	init(password: String) {
		self.password = password
	}
}
