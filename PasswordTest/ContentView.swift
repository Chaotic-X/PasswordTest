//
//  ContentView.swift
//  PasswordTest
//
//  Created by Alex Lundquist on 8/19/21.
//

import SwiftUI

struct ContentView: View {
	
	@State private var isTesting = false
	@State private var pwText: String = ""
	@State private var numPW: Int = 0
	@ObservedObject private var passwordVM = Password(password: "")
	@ObservedObject private var pwArray = PasswordArray(arrayPW: [])
	@State private var pwCount: String = ""
    
	var body: some View {
		NavigationView {
			Form{
				Section(header: Text("Number of passwords to test")) {
					TextField("", value: $passwordVM.passwordCount, formatter: NumberFormatter()) { number in
						if number {
							pwText = ""
							self.isTesting = false
							passwordVM.passwordCount = 0
							numPW = 0
							pwArray.arrayPW = []
						} else {
							numPW = passwordVM.passwordCount
							pwCount = String(passwordVM.passwordCount)
							print(pwCount)
							
							for _ in 0..<numPW {
								let emptyString = Password(password: "")
								pwArray.arrayPW.append(emptyString)
							}
						}
					} // End of TextField
					//					.keyboardType(.default)
					.multilineTextAlignment(.center)
				}
				Section(header: Text("\(numPW == 0 ? 0 : numPW) Passwords")){
					if numPW != 0 {
						ForEach(0..<numPW, id: \.self) { index in
							if isTesting {
								let tempTest = pwArray.arrayPW[index].password
								let passFail = pwArray.arrayPW[index].password.stringFulfillsRegex()
								HStack {
									Text( tempTest )
									Spacer()
									Text( passwordStrength(score: passwordScore(password: pwArray.arrayPW[index].password)) )
										.font(.caption)
									Spacer()
									Image(systemName: passFail ? "checkmark.circle.fill" : "x.circle.fill")
										.foregroundColor(passFail ? .green : .red)
										.frame(width: 20, height: 20, alignment: .trailing)
								}
								HStack {
									Text(passFail ? "YES":"NO")
										.bold()
										.font(.caption)
										.foregroundColor(passFail ? .green : .red )
									Spacer()
									Text(passFail ? "" : tempTest.missing)
										.bold()
										.font(.caption)
										.foregroundColor(.cyan)
								}
							} else {
								TextField("Password to test", text: $pwArray.arrayPW[index].password) { text in
									if !text {
										print("No Text")
									} else {
										let tempString = Password(password: pwArray.arrayPW[index].password)
										pwArray.arrayPW[index] = tempString
										print(pwArray.arrayPW[index].password)
									}
								}
								.autocapitalization(.none)
								.disableAutocorrection(true)
							}
						}
					}
				}
				
			} // End of Form
			.navigationBarTitle("Password Test")
			.navigationBarItems(trailing: Button(action: {
				// Valiation code
				self.isTesting.toggle()
			}) {
				Text("Test Password")
			})
		} // End of NavigationView
	} // End of Body
	
	func passwordScore(password: String) -> Int {
		let special = Int(password.special) ?? 0
		let number = Int(password.numbers) ?? 0
		return special + number
	}
	
	func passwordStrength(score: Int) -> String {
		switch score {
			case 0...2:
				return "Weak"
			case 3...5:
				return "Medium"
			case 6... :
				return "Strong"
			default:
				return "No valid score"
		}
	} // End of Password Strength
}


















struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
