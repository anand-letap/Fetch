import XCTest
@testable import Fetch

@MainActor class RecipesListViewModelTests: XCTestCase {
    private var recipeServiceMock: RecipeServiceMock!
    private var viewModel: RecipesListViewModel!
    
    @MainActor override func setUp() {
        super.setUp()
        
        recipeServiceMock = RecipeServiceMock()
        viewModel = RecipesListViewModel(recipesService: recipeServiceMock)
    }
    
    func test_whenViewModelIsInitialized_recipesAreNotFetched() {
        XCTAssertEqual(recipeServiceMock.fetchRecipesCalled, false)
    }
    
    func test_whenFetchRecipesIsCalled_recipesAreFetched() async throws {
        try await viewModel.fetchRecipes()
        XCTAssertEqual(recipeServiceMock.fetchRecipesCalled, true)
    }
    
    func test_whenRecipesFetched_recipeModelsAreSet() async throws {
        let recipes: [Recipe] = [Recipe.previewModel!]
        recipeServiceMock.recipes = recipes
        
        try await viewModel.fetchRecipes()
        let recipeModels = recipes.map(RecipeViewModel.init)
        XCTAssertEqual(viewModel.recipeViewModels, recipeModels)
    }
    
    func test_whenFetchRecipesFails_errorIsThrown() async throws {
        recipeServiceMock.shouldThrowError = true
        var caughtError: NetworkError?
        do {
            try await viewModel.fetchRecipes()
        } catch {
            caughtError = error as? NetworkError
        }
        
        if caughtError == NetworkError.requestFailed {
            XCTAssertTrue(true)
        } else {
            XCTFail("No error was thrown")
        }
    }
}
