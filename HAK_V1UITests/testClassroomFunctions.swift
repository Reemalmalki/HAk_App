//
//  HAK_V1UITests.swift
//  HAK_V1UITests
//
//  Created by Reem Almalki on 01/06/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import XCTest
@testable import HAK_V1
class testClassroomFunctions: XCTestCase {
  //  var opject: createdClassroomViewController = createdClassroomViewController()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
         continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIApplication().launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddClassroom() {
        // UI tests must launch the application that they test.
       
        let app = XCUIApplication()
     
        app.buttons["أضف غرفة دراسية "].tap()
        app.buttons["المادة"].tap()
        
        let pickerWheel = app.pickers.children(matching: .pickerWheel).element
        pickerWheel.press(forDuration: 1.5);
        app.pickerWheels.element.adjust(toPickerWheelValue: "العلوم")
        app.buttons["المرحلة الدراسية"].tap()
        pickerWheel.press(forDuration: 1.5);
        app.pickerWheels.element.adjust(toPickerWheelValue: "رابع ابتدائي")
        app.buttons["الفصل الدراسي"].tap()
        pickerWheel.press(forDuration: 1.5);
        app.pickerWheels.element.adjust(toPickerWheelValue: "الفصل الدراسي الاول")
        let classroomnameTextField = app.textFields["classroomName"]
        classroomnameTextField.tap()
        classroomnameTextField.typeText("TestUI")
        app.buttons["أنشئ الغرفة الدراسية"].tap()
        sleep(10)

        let errorLable = app.staticTexts["errorLabel"]
        
        XCTAssert(!errorLable.exists, "Classroom Not created")
        
        }
    
   func testViewClassroomInfo() {
          // create classroom to view its info
                  let app = XCUIApplication()
                  app.buttons["أضف غرفة دراسية "].tap()
                 app.buttons["المادة"].tap()
                 let pickerWheel = app.pickers.children(matching: .pickerWheel).element
                 pickerWheel.press(forDuration: 1.5);
                 app.pickerWheels.element.adjust(toPickerWheelValue: "العلوم")
                 app.buttons["المرحلة الدراسية"].tap()
                 pickerWheel.press(forDuration: 1.5);
                 app.pickerWheels.element.adjust(toPickerWheelValue: "رابع ابتدائي")
                 app.buttons["الفصل الدراسي"].tap()
                 pickerWheel.press(forDuration: 1.5);
                 app.pickerWheels.element.adjust(toPickerWheelValue: "الفصل الدراسي الاول")
                 let classroomnameTextField = app.textFields["classroomName"]
                 classroomnameTextField.tap()
                 classroomnameTextField.typeText("TestUIViewClassroom")
                 app.buttons["أنشئ الغرفة الدراسية"].tap()
                 sleep(5)
                 app.navigationBars["إنشاء غرفة دراسية"].buttons["الصفحة الرئيسية"].tap()
                 sleep(5)
          // start testing view
                 app.collectionViews.cells.otherElements.containing(.staticText, identifier:"TestUIViewClassroom").element.tap()
                let classroomName = app.navigationBars["TestUIViewClassroom"].staticTexts["TestUIViewClassroom"]
                 XCTAssert(classroomName.exists, "Classroom info is not displayed")
          }

    func testViewClassroomList() {
    //must ensure there are classroom created by running add classroom test first
        let app = XCUIApplication()
           sleep(5)
    // start testing view
        let numberOfClassroom = app.collectionViews.cells.count
         XCTAssert(numberOfClassroom != 0 , "Classroom list is empty")
    }

    
    
    
    func testDeleteClassroom() {
        
        // create classroom first to test the remove function
        let app = XCUIApplication()
        app.buttons["أضف غرفة دراسية "].tap()
        app.buttons["المادة"].tap()
        let pickerWheel = app.pickers.children(matching: .pickerWheel).element
        pickerWheel.press(forDuration: 1.5);
        app.pickerWheels.element.adjust(toPickerWheelValue: "العلوم")
        app.buttons["المرحلة الدراسية"].tap()
        pickerWheel.press(forDuration: 1.5);
        app.pickerWheels.element.adjust(toPickerWheelValue: "رابع ابتدائي")
        app.buttons["الفصل الدراسي"].tap()
        pickerWheel.press(forDuration: 1.5);
        app.pickerWheels.element.adjust(toPickerWheelValue: "الفصل الدراسي الاول")
        let classroomnameTextField = app.textFields["classroomName"]
        classroomnameTextField.tap()
        classroomnameTextField.typeText("TestUIDelete")
        app.buttons["أنشئ الغرفة الدراسية"].tap()
        sleep(5)
        app.navigationBars["إنشاء غرفة دراسية"].buttons["الصفحة الرئيسية"].tap()
        sleep(5)
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"TestUIDelete").element.tap()
        app.staticTexts["حذف الغرفة"].tap()
        app.alerts["تنبيه"].scrollViews.otherElements.buttons[" تأكيد"].tap()
        let deletedCell = app.collectionViews.cells.otherElements.containing(.staticText, identifier:"TestUIDelete").element
        
        XCTAssert(!deletedCell.exists, "Classroom is not removed")
    }
           
   
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}



