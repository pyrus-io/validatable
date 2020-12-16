import Foundation

//public struct ModelValidationRule<Value, M> {
//
//    private let validator: (Value, M) throws -> Void
//
//    init(
//        _ validator: @escaping (Value, M) throws -> Void
//    ) {
//        self.validator = validator
//    }
//    
//    func assertValidity(with value: Value, on model: M) throws {
//        try validator(value, model)
//    }
//}
//
//extension ModelValidationRule where Value: Equatable {
//    static func equalToKeyPath(
//        _ keyPath: KeyPath<M, Value>,
//        errorMessage: String = "Properties do not match"
//    ) -> ModelValidationRule<Value, M> {
//        return ModelValidationRule { value, model in
//            try (model[keyPath: keyPath] == value) ^^ errorMessage
//        }
//    }
//}
