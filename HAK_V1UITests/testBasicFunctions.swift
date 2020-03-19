//
//  testBasicFunctions.swift
//  HAK_V1UITests
//
//  Created by Reem Almalki on 21/07/1441 AH.
//  Copyright © 1441 Reem Almalki. All rights reserved.
//

import XCTest
@testable import HAK_V1
class testBasicFunctions: XCTestCase {

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
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRegister() {
        
        
        let app = XCUIApplication()
        app.buttons["مستخدم جديد؟ "].tap()
       
        let nameTextField = app.collectionViews.textFields["الاسم"]
        nameTextField.tap()
        nameTextField.typeText("Tester")
        
       
        let emailTextField = app.collectionViews.textFields["البريد الإلكتروني"]
        nameTextField.tap()
        emailTextField.typeText("Tester@gmail.com")
        
        let IdTextField = app.collectionViews.textFields["رقم الهوية الوطنية/الإقامة"]
        IdTextField.tap()
        IdTextField.typeText("1234567890")
        
        let secureTextField = app.collectionViews.secureTextFields["كلمة المرور"]
        secureTextField.tap()
        secureTextField.typeText("123456")
        
        let secureTextField2 = app.collectionViews.secureTextFields["إعادة كلمة المرور"]
        secureTextField2.tap()
        secureTextField2.typeText("123456")
        app.collectionViews.buttons["تسجيل"].tap()
        sleep(5)
        let success = app.staticTexts["لا يوجد غرف دراسية مضافة"]
        XCTAssert(success.exists, "Register fail")

        
    }
    
    
    func testSignIn(){
        let app = XCUIApplication()
        app.textFields["البريد الإلكتروني"].tap()
        app.textFields["البريد الإلكتروني"].typeText("Tester@gmail.com")

        app.secureTextFields["كلمة المرور"].tap()
        app.secureTextFields["كلمة المرور"].typeText("123456")
        
        app.buttons["تسجيل الدخول"].tap()
        sleep(5)
       
        
       let success = app.navigationBars["الصفحة الرئيسية"].children(matching: .button).element
       XCTAssert(success.exists, "SignIn fail")
        
    }
    
    
  
    
    
    
    
    
    
    func testResetPassword(){
        
        let app = XCUIApplication()
        app.buttons["نسيت كلمة المرور ؟"].tap()
        app.alerts["نسيت كلمةالمرور؟"].scrollViews.otherElements.collectionViews.textFields["********@**"].typeText("Tester@gmail.com")
        app.alerts["نسيت كلمةالمرور؟"].scrollViews.otherElements.buttons["تأكيد"].tap()
        let success = app.alerts["تم ارسال الرسالة"].scrollViews.otherElements.buttons["حسناً"]
        XCTAssert(success.exists, "Reset Password fail")
        
    }
   
    func testSignOut(){
        
        let app = XCUIApplication()
        app.navigationBars["الصفحة الرئيسية"].children(matching: .button).element.tap()
        app.buttons["logOut"].tap()
        app.textFields["البريد الإلكتروني"].tap()
        let success =   app.textFields["البريد الإلكتروني"]
        XCTAssert(success.exists, "testSignOut fail")
          
          
          
      }
    

}
