import Foundation

public extension ValidationRule where Value == String {
    
    static let lettersAndSpaces: ValidationRule<String> = .characterSet(
        CharacterSet.letters.union(.init(charactersIn: " "))
        , errorMessage: "Letters only")
    
    static let alphanumericAndSpaces: ValidationRule<String> = .characterSet(
        CharacterSet.alphanumerics.union(.init(charactersIn: " "))
        , errorMessage: "Letters, spaces and numbers only")
    
    static let alphanumeric: ValidationRule<String> = .characterSet(
        CharacterSet.alphanumerics
        , errorMessage: "Letters and numbers only")

    static var usernameCharacters: ValidationRule<String> = .alphanumericsAnd("_")
    static var passwordCharacters: ValidationRule<String> = .alphanumericsAnd("!@#$%^&*()_-+")
    static var productNameCharacters: ValidationRule<String> = .alphanumericsAnd(" !@#$%&*()-+")
    
    static func email(
        errorMessage: String = "Invalid email"
    ) -> ValidationRule<String> {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return ValidationRule { value in
            try emailPred.evaluate(with: value)
                ^^ errorMessage
        }
    }
    
    static func alphanumeric(
        errorMessage: String = "Must contain letters and numbers only"
    ) -> ValidationRule<String> {
        return ValidationRule {
            try CharacterSet.alphanumerics
                .isSuperset(of: CharacterSet(charactersIn: $0))
                ^^ errorMessage
        }
    }
    
    static func alphanumericsAnd(
        _ characters: String,
        errorMessage: String? = nil
    ) -> ValidationRule<String> {
        let errM = errorMessage ?? "Must contain letters, numbers and '\(characters)' only"
        return ValidationRule {
            try CharacterSet(charactersIn: characters).union(.alphanumerics)
                .isSuperset(of: CharacterSet(charactersIn: $0))
                ^^ errM
        }
    }
    
    static func characterSet(
        _ characterSet: CharacterSet,
        errorMessage: String = "Contains invalid characters"
    ) -> ValidationRule<String> {
        return ValidationRule {
            try characterSet
                .isSuperset(of: CharacterSet(charactersIn: $0))
                ^^ errorMessage
        }
    }

    static func characters(
        _ characters: String,
        errorMessage: String = "Contains invalid characters"
    ) -> ValidationRule<String> {
        return ValidationRule {
            try CharacterSet(charactersIn: characters)
                .isSuperset(of: CharacterSet(charactersIn: $0))
                ^^ errorMessage
        }
    }
}
