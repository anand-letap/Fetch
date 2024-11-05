import SwiftUI

struct RecipeDetailView: View {
    let recipe: RecipeViewModel
    
    var body: some View {
        HStack( spacing: 12) {
            CachedAsyncImage(url: recipe.photoURL) { phase in
                switch phase {
                case .failure(let error):
                    let _ = print(error.localizedDescription)
                    Image(systemName: "photo")
                        .font(.largeTitle)
                case .success(let image):
                    image.resizable()
                default:
                    ProgressView()
                }
            }.frame(width: 64, height: 64)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(recipe.name)
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Text(recipe.cuisine)
                    .foregroundStyle(.gray)
                    .font(.subheadline)
            }
            Spacer()
        }
        .background(Color.white)
    }
}

#Preview {
    guard let recipe = Recipe.previewModel else { return EmptyView() }
    let viewModel = RecipeViewModel(recipe: recipe)
    return RecipeDetailView(recipe: viewModel)
}
