import Foundation

public protocol ValidatableStructure {
    var validatableProperties: [AnyValidatable] { get }
    var isValid: Bool { get }
    
}

extension ValidatableStructure {
    public var isValid: Bool {
        do {
            try assertValidity()
        } catch {
            return false
        }
        return true
    }
    
    func assertValidity() throws {
        for prop in validatableProperties {
            try prop.assertPropertyRules()
        }
    }
    
}

/*
@propertyWrapper
public struct ValidatableStructure<WrappedValue> {
    
    public var validatableProperties: [AnyValidatable]
    public let rules: [ValidationRule<WrappedValue>]
    
    public var projectedValue: ValidatableStructure<WrappedValue>  {
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
        validatableProperties: [AnyValidatable],
        rules: [ValidationRule<WrappedValue>] = []
    ) {
        self.storedValued = wrappedValue
        self.validatableProperties = validatableProperties
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
        
       
    }
}

extension ValidatableStructure: Equatable where WrappedValue: Equatable {
    public static func == (lhs: ValidatableStructure<WrappedValue>, rhs: ValidatableStructure<WrappedValue>) -> Bool {
        return lhs.wrappedValue == rhs.wrappedValue
    }
}
*/
