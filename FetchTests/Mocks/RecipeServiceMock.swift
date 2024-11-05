import Foundation
@testable import Fetch

class RecipeServiceMock: RecipeService {
    var recipes: [Recipe] = []
    var fetchRecipesCalled: Bool = false
    var shouldThrowError: Bool = false
    
    func fetchRecipes() async throws -> [Recipe] {
        if shouldThrowError {
            throw NetworkError.requestFailed
        }
        fetchRecipesCalled = true
        return recipes
    }
}

