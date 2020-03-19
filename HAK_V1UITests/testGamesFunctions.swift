//
//  testGamesFunctions.swift
//  HAK_V1UITests
//
//  Created by Reem Almalki on 21/07/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import XCTest
@testable import HAK_V1
class testGamesFunctions: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

     func testViewGamesList() {
      //must ensure there are classroom created by running add classroom test first
        let app = XCUIApplication()
        sleep(10)
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"TestUI").element.tap()
        app.buttons["قائمة الالعاب"].tap()
      // start testing view
        let numberOfGames = app.collectionViews.containing(.staticText, identifier:"الخلية").cells.count
       XCTAssert(numberOfGames != 0 , "Games list is empty")
      }
    

    func testViewGameInfo() {
     //must ensure there are classroom created by running add classroom test first
        
        let app = XCUIApplication()
        sleep(10)
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"TestUI").element.tap()
        app.buttons["قائمة الالعاب"].tap()
        sleep(5)
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"الخلية").element.tap()
        // check if info are displayed
        let check = app.staticTexts["سيحقق الطالب الاهداف التالية"]
        XCTAssert(check.exists , "Game info is not displayed ")
    }
    
    func testOpenGame() {
        
     //must ensure there are classroom created by running add classroom test first
        let app = XCUIApplication()
        sleep(10)
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"TestUI").element.tap()
        app.buttons["قائمة الالعاب"].tap()
        sleep(5)
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"الخلية").element.tap()
        // check if info are displayed
        var check = app.staticTexts["لتغيير حالة اللعبة "]
        if check.exists { // the game is closed
          app.switches["switcher"].tap()
          app.alerts["هل تريد فتح اللعبة"].scrollViews.otherElements.buttons[" تأكيد"].tap()
          app.alerts["تنبيه"].scrollViews.otherElements.buttons["حسنا"].tap()
        }
        check = app.staticTexts["لتغيير حالة اللعبة "]
        XCTAssert(!check.exists , "Game is still closed ")
        
        
        
    }
    
    

}
