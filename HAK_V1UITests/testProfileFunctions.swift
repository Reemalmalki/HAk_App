//
//  testProfileFunctions.swift
//  HAK_V1UITests
//
//  Created by Reem Almalki on 22/07/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import XCTest
@testable import HAK_V1
class testProfileFunctions: XCTestCase {

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

    func testViewProfile() {
        
        let app = XCUIApplication()
        app.navigationBars["الصفحة الرئيسية"].children(matching: .button).element.tap()
        app.buttons["profile"].tap()
        sleep(3)
       let success =  app.staticTexts["الإسم"]
       XCTAssert(success.exists, "testSignOut fail")
    }
    
    
    func testEditName(){
        
        let app = XCUIApplication()
        app.navigationBars["الصفحة الرئيسية"].children(matching: .button).element.tap()
        app.buttons["profile"].tap()
        app.buttons["editName"].tap()
        
        let elementsQuery = app.alerts["تعديل الاسم"].scrollViews.otherElements
        elementsQuery.collectionViews/*@START_MENU_TOKEN@*/.textFields["الاسم"]/*[[".cells.textFields[\"الاسم\"]",".textFields[\"الاسم\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery.collectionViews/*@START_MENU_TOKEN@*/.textFields["الاسم"]/*[[".cells.textFields[\"الاسم\"]",".textFields[\"الاسم\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("Tester")
        elementsQuery.buttons["تأكيد"].tap()
        sleep(3)
       let success =  app.alerts["تم تعديل الإسم"].scrollViews.otherElements.staticTexts["تم تعديل الإسم"]
        XCTAssert(success.exists, "Edit Name fail")
    }
    
    
    func testEditEmail(){
        
         let app = XCUIApplication()
        app.navigationBars["الصفحة الرئيسية"].children(matching: .button).element.tap()
        app.buttons["profile"].tap()
        app.buttons["editEmail"].tap()
        
        let elementsQuery = app.alerts["تعديل البريد الإلكتروني"].scrollViews.otherElements
        elementsQuery.collectionViews/*@START_MENU_TOKEN@*/.textFields["******@****"]/*[[".cells.textFields[\"******@****\"]",".textFields[\"******@****\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery.collectionViews/*@START_MENU_TOKEN@*/.textFields["******@****"]/*[[".cells.textFields[\"******@****\"]",".textFields[\"******@****\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("Tester@gmail.com")
        let success = elementsQuery.buttons["تأكيد"].exists
        elementsQuery.buttons["تأكيد"].tap()
        // success =  app.alerts["تم تعديل الإسم"].scrollViews.otherElements.staticTexts["تم تعديل الإسم"]
        XCTAssert(success, "Edit Email fail")
    }
    
    
    func testEditPassword(){
        let app = XCUIApplication()
        app.navigationBars["الصفحة الرئيسية"].children(matching: .button).element.tap()
        app.buttons["profile"].tap()
        app.buttons["editPassword"].tap()
               
        let elementsQuery = app.alerts["تعديل كلمة المرور"].scrollViews.otherElements
        elementsQuery.collectionViews/*@START_MENU_TOKEN@*/.textFields["*********"]/*[[".cells.textFields[\"*********\"]",".textFields[\"*********\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery.collectionViews/*@START_MENU_TOKEN@*/.textFields["*********"]/*[[".cells.textFields[\"*********\"]",".textFields[\"*********\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("111111")
       let success = elementsQuery.buttons["تأكيد"].exists
        elementsQuery.buttons["تأكيد"].tap()
        // success =  app.alerts["تم التعديل كلمة المرور".scrollViews.otherElements.staticTexts["تم التعديل كلمة المرور"]
        XCTAssert(success, "Edit Password fail")
        
        
      
                
        
        
    }

}
