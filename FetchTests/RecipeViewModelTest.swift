import XCTest
@testable import Fetch

class RecipeViewModelTestCase: XCTestCase {
    let recipe = Recipe.previewModel!
    var viewModel: RecipeViewModel!
    
    override func setUp() {
        super.setUp()
        
        viewModel = RecipeViewModel(recipe: recipe)
    }
    
    func test_id_isEqualTo_recipeUuid() {
        XCTAssertEqual(recipe.uuid, viewModel.id)
    }
    
    func test_name_isEqualTo_recipeName() {
        XCTAssertEqual(recipe.name, viewModel.name)
    }
    
    func test_cuisine_isEqualTo_recipeCuisine() {
        XCTAssertEqual(recipe.cuisine, viewModel.cuisine)
    }
    
    func test_photoUrl_isEqualTo_recipePhotoUrlLarge() {
        XCTAssertEqual(recipe.photoURLLarge, viewModel.photoURL?.absoluteString)
    }
}
