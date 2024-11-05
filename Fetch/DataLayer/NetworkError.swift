import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case badNetwork
    case requestFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: 
            return "Invalid URL. Our engineers are on it!"
        case .badNetwork:
            return "Network is unavailable. Please try again later."
        case .requestFailed: 
            return "The request failed due to malformed data. Our engineers are on it!"
        }
    }
}
