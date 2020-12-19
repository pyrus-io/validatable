import Foundation

@propertyWrapper
public struct Validatable<WrappedValue> {
    
    public let rules: [ValidationRule<WrappedValue>]
    
    public var projectedValue: Validatable<WrappedValue>  {
        get { self }
        set { self = newValue }
    }
    
    public var validationState: ValidationState = .unvisited
    
    public var isValid: Bool {
        do {
            try assertPropertyRules()
        } catch {
            return false
        }
        return true
    }
    
    private var storedValued: WrappedValue
    
    public var wrappedValue: WrappedValue {
        set {
            storedValued = newValue
            validationState = .active
            updatePropertyValidState()
        }
        get { storedValued }
    }

    public init(
        wrappedValue: WrappedValue,
        rules: [ValidationRule<WrappedValue>] = []
    ) {
        self.storedValued = wrappedValue
        self.rules = rules
    }
    
    public mutating func updatePropertyValidState() {
        do {
            try assertPropertyRules()
            self.validationState = .valid
        } catch {
            if let e = error as? ValidationError,
               case let .message(m) = e {
                self.validationState = .error(m)
            } else {
                self.validationState = .error("Unknown validation error")
            }
        }
    }
    
    public func assertPropertyRules() throws {
        try rules.forEach { rule in
            try rule.assertValidity(with: wrappedValue)
        }
        
        if let structure = wrappedValue as? ValidatableStructure {
            try structure.assertValidity()
        }
    }
}

extension Validatable: Equatable where WrappedValue: Equatable {
    public static func == (lhs: Validatable<WrappedValue>, rhs: Validatable<WrappedValue>) -> Bool {
        return lhs.wrappedValue == rhs.wrappedValue
    }
}
