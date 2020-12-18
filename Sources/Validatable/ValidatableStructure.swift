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
