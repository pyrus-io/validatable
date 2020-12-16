import Foundation

public enum ValidationError: Error {
    case message(String)
}

infix operator ^^: NilCoalescingPrecedence

internal func ^^ (
  value: Bool,
  errorMessage: @autoclosure () -> String
) throws {
    if !value {
        throw ValidationError.message(errorMessage())
    }
}

public struct ValidationRule<Value> {
    
    private let validator: (Value) throws -> Void
    
    public init(
        _ validator: @escaping (Value) throws -> Void
    ) {
        self.validator = validator
    }
    
    public static func combine(_ rules: ValidationRule<Value>...) -> ValidationRule<Value> {
        return ValidationRule { value in
            for rule in rules {
                try rule.validator(value)
            }
        }
    }

    public func assertValidity(with value: Value) throws {
        try validator(value)
    }
    
    public func pullback<B>(_ t: @escaping (B) -> Value) -> ValidationRule<B> {
        return ValidationRule<B> { b in
            try validator(t(b))
        }
    }
    
    public func combine(_ rule: ValidationRule<Value>) -> ValidationRule<Value> {
        return ValidationRule({ value in
            try self.validator(value)
            try rule.validator(value)
        })
    }
    
}

public extension ValidationRule where Value: Equatable {
    static func pathsMatch<T: Equatable>(
        a keyPathA: KeyPath<Value, T>,
        b keyPathB: KeyPath<Value, T>,
        errorMessage: String = "Properties do not match"
    ) -> ValidationRule<Value> {
        return ValidationRule { value in
            try (value[keyPath: keyPathA] == value[keyPath: keyPathB])
                ^^ errorMessage
        }
    }
    
    static func equals(
        _ matchingValue: Value
    ) -> ValidationRule<Value> {
        return ValidationRule {
            try ($0 == matchingValue) ^^ "Not equal to \(matchingValue)"
        }
    }
}
