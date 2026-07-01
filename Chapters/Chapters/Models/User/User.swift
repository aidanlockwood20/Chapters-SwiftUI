import SwiftUI
import SwiftData

@Model
final class User {
    var id = UUID()
    var email: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var dateOfBirth: Date = Date()
    var gender: String = ""
    var phoneNumber: String = ""
    
    init(email: String, firstName: String, lastName: String, dateOfBirth: Date, gender: String, phoneNumber: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.phoneNumber = phoneNumber
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case firstName = "first_name"
        case lastName = "last_name"
        case dateOfBirth = "date_of_birth"
        case gender = "gender"
        case phoneNumber = "phone_number"
    }
}
