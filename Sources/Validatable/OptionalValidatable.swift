import Foundation

@propertyWrapper
public struct OptionalValidatable<WrappedValue> {
    public let rules: [ValidationRule<WrappedValue>]
    
    public var projectedValue: OptionalValidatable<WrappedValue>  {
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
    
    private var storedValued: WrappedValue?
    
    public var wrappedValue: WrappedValue? {
        set {
            storedValued = newValue
            validationState = .active
            updatePropertyValidState()
        }
        get { storedValued }
    }

    public init(
        wrappedValue: WrappedValue?,
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
        guard let value = wrappedValue else { return }
        
        try rules.forEach { rule in
            try rule.assertValidity(with: value)
        }
        
        if let structure = value as? ValidatableStructure {
            try structure.assertValidity()
        }
    }
}

extension OptionalValidatable: Equatable where WrappedValue: Equatable {
    public static func == (lhs: OptionalValidatable<WrappedValue>, rhs: OptionalValidatable<WrappedValue>) -> Bool {
        return lhs.wrappedValue == rhs.wrappedValue
    }
}
