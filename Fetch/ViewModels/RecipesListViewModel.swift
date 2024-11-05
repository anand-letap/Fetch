import Foundation

@MainActor
class RecipesListViewModel: ObservableObject {
    private let recipesService: RecipeService
    
    @Published var recipeViewModels: [RecipeViewModel] = []
    
    init(recipesService: RecipeService) {
        self.recipesService = recipesService
    }
    
    func fetchRecipes() async throws {
        do {
            let recipes = try await recipesService.fetchRecipes()
            self.recipeViewModels = recipes.map(RecipeViewModel.init)
        } catch {
            throw error
        }
    }
}
