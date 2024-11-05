import XCTest
@testable import Fetch

class RecipeServiceTests: XCTestCase {
    var recipeService: RecipeService!
    var url: URL!
    
    override func setUp() {
        super.setUp()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        recipeService = RecipeServiceImpl(session: session)
        url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
    }
    
    func testFetchRecipes_success() async throws {
        let recipeResponse: [String: [Recipe]] = ["recipes": [Recipe.previewModel!]]
        let mockData = try JSONEncoder().encode(recipeResponse)
        
        let mockResponse = HTTPURLResponse(url: url,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        MockURLProtocol.requestHandler = { request in
            return (mockResponse, mockData)
        }
        
        let expectation = XCTestExpectation(description: "Fetch recipes")
        Task {
            let result = try await recipeService.fetchRecipes()
            XCTAssertEqual(result, [Recipe.previewModel])
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2)
    }
    
    func testFetchRecipes_badNetwork() async throws {
        let recipeResponse: [String: [Recipe]] = ["recipes": [Recipe.previewModel!]]
        let mockData = try JSONEncoder().encode(recipeResponse)
        
        let mockResponse = HTTPURLResponse(url: url,
                                       statusCode: 400,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        MockURLProtocol.requestHandler = { request in
            return (mockResponse, mockData)
        }
        
        let expectation = XCTestExpectation(description: "Fetch recipes")
        Task {
            do {
                let result = try await recipeService.fetchRecipes()
            } catch {
                XCTAssertEqual(error as! NetworkError, NetworkError.badNetwork)
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 2)
    }
    
    func testFetchRecipes_requestFailed() async throws {
        let badResponse: [String: [Recipe]] = ["rEcIpEssss": [Recipe.previewModel!]]
        let mockData = try JSONEncoder().encode(badResponse)
        
        let mockResponse = HTTPURLResponse(url: url,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        MockURLProtocol.requestHandler = { request in
            return (mockResponse, mockData)
        }
        
        let expectation = XCTestExpectation(description: "Fetch recipes")
        Task {
            do {
                let result = try await recipeService.fetchRecipes()
            } catch {
                XCTAssertEqual(error as! NetworkError, NetworkError.requestFailed)
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation], timeout: 2)
    }
}
