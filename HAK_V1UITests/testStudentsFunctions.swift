//
//  testStudentsFunctions.swift
//  HAK_V1UITests
//
//  Created by Reem Almalki on 20/07/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import XCTest
@testable import HAK_V1

class testStudentsFunctions: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddStudent() {
        let app = XCUIApplication()
        sleep(10) // wait to load
        // here start testing the addition " Select the name of classroom before run the test "
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"TestStudentFunctions").element.tap()
        app.buttons["قائمة الطلاب"].tap()
        app.buttons["icons8 add 100"].tap()
        // here must add id of existing student
        let textField = app.alerts["إضافة طالب"].scrollViews.otherElements.collectionViews.textFields["1D3f5"]
        textField.tap()
        textField.typeText("P1qr5")
        app.alerts["إضافة طالب"].scrollViews.otherElements.buttons["تأكيد"].tap()
        sleep(2)
        let successAlert = app.collectionViews/*@START_MENU_TOKEN@*/.buttons["icons8 delete 50"]/*[[".cells.buttons[\"icons8 delete 50\"]",".buttons[\"icons8 delete 50\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssert(successAlert.exists, "student did Not added")
    }
    
    func testRewardStudent() {
          let app = XCUIApplication()
          sleep(10) // wait to load
          // here start testing the reward student with 100 points  " Select the name of classroom before run the test "
          app.collectionViews.cells.otherElements.containing(.staticText, identifier:"TestAddStudent").element.tap()
          app.buttons["قائمة الطلاب"].tap()

           app.collectionViews/*@START_MENU_TOKEN@*/.buttons["كآفئ"]/*[[".cells.buttons[\"كآفئ\"]",".buttons[\"كآفئ\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
           
           let elementsQuery = app.alerts["مكافأة طالب"].scrollViews.otherElements
           elementsQuery.collectionViews/*@START_MENU_TOKEN@*/.textFields["50"]/*[[".cells.textFields[\"50\"]",".textFields[\"50\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
           elementsQuery.collectionViews/*@START_MENU_TOKEN@*/.textFields["50"]/*[[".cells.textFields[\"50\"]",".textFields[\"50\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("100")
           elementsQuery.buttons["تأكيد"].tap()
           let successAlert  =   app.alerts["تم تقديم المكافأة بنجاح"].scrollViews.otherElements.buttons["حسناً"]
           XCTAssert(successAlert.exists, "student did not rewarded")
    }
     
    func testViewStudentsInfo() {
             let app = XCUIApplication()
             sleep(10) // wait to load
             // here start testing the reward student with 100 points  " Select the name of classroom before run the test "
             app.collectionViews.cells.otherElements.containing(.staticText, identifier:"TestStudentFunctions").element.tap()
             app.buttons["قائمة الطلاب"].tap()

              let successsButton = app.collectionViews/*@START_MENU_TOKEN@*/.buttons["icons8 delete 50"]/*[[".cells.buttons[\"icons8 delete 50\"]",".buttons[\"icons8 delete 50\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
              sleep(5) 
              XCTAssert(successsButton.exists, "students info did not displayed")
        
        
        
        
       }
    
    
    
           
    
    func testDeleteStudent() {
    let app = XCUIApplication()
    sleep(10) // wait to load
    // here start testing the delete student  " Select the name of classroom before run the test "
    app.collectionViews.cells.otherElements.containing(.staticText, identifier:"TestStudentFunctions").element.tap()
    app.buttons["قائمة الطلاب"].tap()
       app.collectionViews/*@START_MENU_TOKEN@*/.buttons["icons8 delete 50"]/*[[".cells.buttons[\"icons8 delete 50\"]",".buttons[\"icons8 delete 50\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["تنبيه"].scrollViews.otherElements.buttons[" تأكيد"].tap()
        let successAlert  =  app.alerts["تم حذف الطالب"].scrollViews.otherElements.buttons["حسنا"]
        XCTAssert(successAlert.exists, "student did Not removed")
    }
    
    
    
}
