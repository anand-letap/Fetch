import Foundation

struct RecipesResponse: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable, Equatable {
    let uuid: String
    let name: String
    let cuisine: String
    let photoURLLarge: String?
    let photoURLSmall: String?
    let sourceURL: String?
    let youtubeURL: String?
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case cuisine
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}
