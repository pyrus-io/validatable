import Foundation

public extension ValidationRule where Value: Collection {
    
    static func notEmpty(
        errorMessage: String = "Can not be empty"
    ) -> ValidationRule<Value> {
        return ValidationRule {
            try !$0.isEmpty ^^ errorMessage
        }
    }

    static func length(
        min: Int,
        max: Int
    ) -> ValidationRule<String> {
        return ValidationRule<String>
            .minLength(min)
            .combine(.maxLength(max))
    }
    
    static func minLength(
        _ minLength: Int,
        errorMessage: String? = nil
    ) -> ValidationRule<Value> {
        let errorMessage: String = errorMessage ?? "Minimum length is \(minLength)"
        return ValidationRule {
            try ($0.count >= minLength) ^^ errorMessage
        }
    }
    
    static func maxLength(
        _ maxLength: Int,
        errorMessage: String? = nil
    ) -> ValidationRule<Value> {
        let errorMessage: String = errorMessage ?? "Maximum length is \(maxLength)"
        return ValidationRule {
            try ($0.count <= maxLength) ^^ errorMessage
        }
    }
}

public extension ValidationRule where Value: Collection {
    static func childrenPassing(
        rules: ValidationRule<Value.Element>...,
        errorMessage: String = "Issue with section"
    ) -> ValidationRule<Value> {
        return ValidationRule { values in
            do {
                try values.forEach { value in
                    try rules.forEach { rule in
                        try rule.assertValidity(with: value)
                    }
                }
            } catch {
                throw ValidationError.message(errorMessage)
            }
        }
    }
}

//extension ValidationRule where Value: Collection, Value.Element: ValidatableStructure {
//    static func validChildren (
//        errorMessage: String = "Issue with section"
//    ) -> ValidationRule<Value> {
//        return ValidationRule { values in
//            do {
//                try values.forEach { value in
//                    try value.assertValidity()
//                }
//            } catch {
//                throw ValidationError.message(errorMessage)
//            }
//        }
//    }
//}
