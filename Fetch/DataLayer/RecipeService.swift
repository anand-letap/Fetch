import Foundation

protocol RecipeService {
    func fetchRecipes() async throws -> [Recipe]
}

class RecipeServiceImpl: RecipeService {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchRecipes() async throws -> [Recipe] {
        let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.badNetwork
        }
        
        guard let recipesResponse = try? JSONDecoder().decode(RecipesResponse.self, from: data) else {
            throw NetworkError.requestFailed
        }
        return recipesResponse.recipes
    }
}
