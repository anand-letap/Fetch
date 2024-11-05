import SwiftUI

struct RecipesListView: View {
    @EnvironmentObject var errorHandling: ErrorHandling
    @StateObject private var recipesViewModel: RecipesListViewModel
    
    init(viewModel: RecipesListViewModel) {
        _recipesViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    List(recipesViewModel.recipeViewModels) { recipe in
                        RecipeDetailView(recipe: recipe)
                    }
                    .listRowSpacing(16)
                    .overlay(Group {
                        if recipesViewModel.recipeViewModels.isEmpty {
                            self.emptyListMessage
                        }
                    })
                }
            }
            .onAppear {
                self.loadRecipes()
            }
            .refreshable {
                self.loadRecipes()
            }
            .navigationTitle("Recipes")
        }
    }
    
    func loadRecipes() {
        Task {
            do {
                try await recipesViewModel.fetchRecipes()
            } catch {
                self.errorHandling.handle(error: error)
            }
        }
    }
    
    var emptyListMessage: some View {
        VStack {
            Text("Oops, no recipes available at the moment.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .font(.caption)
            Text("Please try again later.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .font(.caption)
        }
    }
}

#Preview {
    RecipesListView(viewModel: RecipesListViewModel(recipesService: RecipeServiceImpl()))
}
