import Foundation

/*
public protocol ModelValidatableProperty {
    associatedtype Model
    
    var validationState: ValidationState { get }
    
    func assertPropertyRules() throws
    func assertModelRules(in model: Model) throws
}

struct ModelPropertyValidating<M: ValidatableStructure, V> {
    let validate: (inout ValidatableProperty<M, V>, M) -> Void
}

extension ModelPropertyValidating where V: ValidatableStructure {
    static func validatableStructureWitness() -> ModelPropertyValidating<M, V> {
        return ModelPropertyValidating { (prop, model) in
            prop.updateModelValidState(model)
            prop.wrappedValue.evaluateModelValidity()
        }
    }
}

extension ModelPropertyValidating {
    static func propertyWitness() -> ModelPropertyValidating<M, V> {
        return ModelPropertyValidating { (prop, model) in
            prop.updateModelValidState(model)
        }
    }
}

func validate<M, P>(property: inout ValidatableProperty<M, P>, model: M, witness: ModelPropertyValidating<M, P>) {
    witness.validate(&property, model)
}


public struct AnyModelValidatableProperty<Model>: ModelValidatableProperty {
    
    public var validationState: ValidationState { _getValidationState() }
   
    private let _getValidationState: () -> ValidationState
    private let _assertPropertyRules: () throws -> Void
    private let _assertModelRules: (Model) throws -> Void
    
    init<T>(_ property: ValidatableProperty<Model, T>) {
        _getValidationState = { property.validationState }
        _assertPropertyRules = { try property.assertPropertyRules() }
        _assertModelRules = { try property.assertModelRules(in: $0) }
    }
    
    public func assertPropertyRules() throws {
        try _assertPropertyRules()
    }
    
    public func assertModelRules(in model: Model) throws {
        try _assertModelRules(model)
    }
}
*/
