//
//  PasswordArray.swift
//  PasswordTest
//
//  Created by Alex Lundquist on 8/19/21.
//

import Foundation

class PasswordArray: ObservableObject, Identifiable {
	@Published var id = UUID()
	@Published var arrayPW: [Password]
	
	init(arrayPW: [Password]) {
		self.arrayPW = arrayPW
	}
}
