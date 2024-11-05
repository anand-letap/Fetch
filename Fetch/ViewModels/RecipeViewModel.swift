import Foundation

struct RecipeViewModel: Identifiable, Equatable {
    let recipe: Recipe
    
    var id: String { recipe.uuid }
    
    var name: String { recipe.name }
    
    var cuisine: String { recipe.cuisine }
    
    var photoURL: URL? {
        guard let url = recipe.photoURLLarge else { return nil }
        return URL(string: url)
    }
}
