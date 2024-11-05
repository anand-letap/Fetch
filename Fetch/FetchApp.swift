import SwiftUI

@main
struct FetchApp: App {
    var body: some Scene {
        WindowGroup {
            RecipesListView(viewModel: RecipesListViewModel(recipesService: RecipeServiceImpl()))
                .withErrorHandling()
        }
    }
}
