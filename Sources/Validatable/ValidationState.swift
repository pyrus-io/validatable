import Foundation

public enum ValidationState {
    case unvisited
    case active
//    case filled
    case valid
    case error(String)
    
    public var isValid: Bool {
        if case .valid = self {
           return true
        }
        return false
    }
    
    public var isError: Bool {
        if case .error = self {
            return true
        }
        return false
    }
    
    public var errorMessage: String {
        if case let .error(message) = self {
            return message
        }
        return ""
    }
}
