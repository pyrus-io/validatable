import Foundation

public struct AnyValidatable {
    
    public var validationState: ValidationState { _getValidationState() }
   
    private let _getValidationState: () -> ValidationState
    private let _assertPropertyRules: () throws -> Void
    
    public init<T>(_ property: Validatable<T>) {
        _getValidationState = { property.validationState }
        _assertPropertyRules = { try property.assertPropertyRules() }
    }
    
    public init<T>(_ property: OptionalValidatable<T>) {
        _getValidationState = { property.validationState }
        _assertPropertyRules = { try property.assertPropertyRules() }
    }
    
    public func assertPropertyRules() throws {
        try _assertPropertyRules()
    }

}
