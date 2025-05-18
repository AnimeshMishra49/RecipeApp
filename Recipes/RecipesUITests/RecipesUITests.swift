//
//  RecipesUITests.swift
//  RecipesUITests
//
//  Created by Animesh Mishra on 18/5/2025.
//

import XCTest

final class RecipesUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testScrollViewAndSelection() throws {
        let app = XCUIApplication()
        app.activate()

        // Swipe up on the scroll view (ingredients or detail section)
        let scrollView = app.scrollViews.firstMatch
        scrollView.swipeUp()

        // Swipe up on a specific static text (ingredient)
        let ingredientText = app.staticTexts["• 200g grape kumato tomatoes, halved"]
        XCTAssertTrue(ingredientText.waitForExistence(timeout: 2), "Expected ingredient text to exist")
        ingredientText.swipeUp()

        // Swipe left through horizontal scroll (recipe carousel or grid)
        let porkRaguImage = app.images["Pork ragu served on top of polenta with fennel and fried sage on top with bread on the side"]
        XCTAssertTrue(porkRaguImage.exists, "Expected pork ragu image to exist")
        porkRaguImage.swipeLeft()

        // Tap on another recipe image
        let lambImage = app.images["Lamb shank ragu served on pappardelle with shaved parmesan and flat leaf parsley"]
        XCTAssertTrue(lambImage.waitForExistence(timeout: 2), "Expected Lamb shank ragu to be tappable")
        lambImage.tap()
        scrollView.swipeDown()
        scrollView.swipeUp()
    }
    
    @MainActor
    func testPullToRefreshAndScroll() throws {
        let app = XCUIApplication()
        app.activate()
        // Pull to refresh
        let scrollView = app.scrollViews.firstMatch
        XCTAssertTrue(scrollView.waitForExistence(timeout: 3), "Expected scrollView to exist before pull to refresh.")
        scrollView.swipeDown()

        // Swipe up on the scroll view (ingredients or detail section)
        scrollView.swipeUp()

        // Swipe up on a specific static text (ingredient)
        let ingredientText = app.staticTexts["• 200g grape kumato tomatoes, halved"]
        XCTAssertTrue(ingredientText.waitForExistence(timeout: 2), "Expected ingredient text to exist")
        ingredientText.swipeUp()
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
