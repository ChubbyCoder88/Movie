//
//  MovieChallengeTests.swift
//  MovieChallengeTests
//
//  Created by Matthew Corry on 6/4/2023.
//

import XCTest
@testable import MovieChallenge
import Combine
final class MovieChallengeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTransformApiData() throws {
        print("testTransformApiData")
        var data = moviesDetails(title: Optional("Lilo & Stitch"), release_date: Optional("2002-06-21"), poster_path: Optional("/d73UqZWyw3MUMpeaFcENgLZ2kWS.jpg"), overview: Optional("As Stitch, a runaway genetic experiment from a faraway planet, wreaks havoc on the Hawaiian Islands, he becomes the mischievous adopted alien \"puppy\" of an independent little girl named Lilo and learns about loyalty, friendship, and ʻohana, the Hawaiian tradition of family."), vote_average: Optional(7.505), backdrop_path: Optional("/w102m4HoCP5uxhW8Yh7Hv7QShix.jpg"), vote_count: Optional(5428))
        var expectedResult = [movieViewModel(title: "Lilo & Stitch", release_date: Optional("21 June 2002"), poster_image: Optional("/d73UqZWyw3MUMpeaFcENgLZ2kWS.jpg"), overview: Optional("As Stitch, a runaway genetic experiment from a faraway planet, wreaks havoc on the Hawaiian Islands, he becomes the mischievous adopted alien \"puppy\" of an independent little girl named Lilo and learns about loyalty, friendship, and ʻohana, the Hawaiian tradition of family."), vote_average: Optional("7.5"), backdrop_image: Optional("/w102m4HoCP5uxhW8Yh7Hv7QShix.jpg"), vote_count: Optional("5428 votes"), isFavourite: false)]
        
        var store = Set<AnyCancellable>()
        let transform = Transform()
        var actualResult = [movieViewModel]()
        var moviesStruct = moviesStruct(results: [data])
        
        XCTAssertNoThrow(try transform.refactorAndInsertIntoViewModel(data: moviesStruct).sink { [weak self] finished in
            switch finished {
            case .failure(.message(let error)): print("failure")
            case .finished:                     print("finished")
            }
        } receiveValue: { (data) in
            actualResult = data
        }.store(in: &store)
        )

        XCTAssertEqual(expectedResult[0].title, actualResult[0].title)
        XCTAssertEqual(expectedResult[0].release_date, actualResult[0].release_date)
        XCTAssertEqual(expectedResult[0].poster_image, actualResult[0].poster_image)
        XCTAssertEqual(expectedResult[0].overview, actualResult[0].overview)
        XCTAssertEqual(expectedResult[0].vote_average, actualResult[0].vote_average)
        XCTAssertEqual(expectedResult[0].backdrop_image, actualResult[0].backdrop_image)
        XCTAssertEqual(expectedResult[0].vote_count, actualResult[0].vote_count)
        XCTAssertEqual(expectedResult[0].isFavourite, actualResult[0].isFavourite)
        XCTAssertEqual(expectedResult, actualResult)
    }
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
