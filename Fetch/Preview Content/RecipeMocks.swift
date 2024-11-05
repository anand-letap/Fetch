import Foundation

extension Recipe {
    
    static var mockJson: String {
                """
        {
                    "cuisine": "British",
                    "name": "Bakewell Tart",
                    "photo_url_large": "https://some.url/large.jpg",
                    "photo_url_small": "https://some.url/small.jpg",
                    "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
                    "source_url": "https://some.url/index.html",
                    "youtube_url": "https://www.youtube.com/watch?v=some.id"
                }
        """
    }
    
    static var previewModel: Recipe? {
        let data = mockJson.data(using: .utf8)!
        do {
            return try JSONDecoder().decode(Recipe.self, from: data)
        } catch {
            print("Error decoding \(error)")
        }
        return nil
    }
}
