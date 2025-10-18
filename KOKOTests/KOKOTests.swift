//
//  KOKOTests.swift
//  KOKOTests
//
//  Created by David Shiue on 2025/10/16.
//

import XCTest
@testable import KOKO

final class KOKOTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        XCTAssert(true)
    }
    
    func testJsonStringToDictionary(){
        let jsonString = "{\"response\":[{\"name\":\"黃靖僑\",\"status\":0,\"isTop\":\"0\",\"fid\":\"001\",\"updateDate\":\"20190801\"}]}"
        if let dictionary = WebApiManager.shared.jsonStringToDictionary(jsonString) {
            print("解析結果:")
            print(dictionary)
        } else {
            XCTAssert(false)
        }
        XCTAssert(true)
    }
    
    func testGetMan(){
        Task {
            do {
                let man = try await WebApiManager.shared.getMan()
                print(man)
            } catch {
                print("请求失败: \(error)")
                XCTAssert(false)
            }
            XCTAssert(true)
        }
    }

    func testGetFriend1() async throws {
        var friends = [Friend]()
        do {
            friends = try await WebApiManager.shared.getFriend1()
        } catch {
            print("请求失败: \(error)")
            XCTAssert(false)
        }
        if friends.count > 0 {
            XCTAssert(true)
        }
    }

    func testGetFriend2() async throws {
        var friends = [Friend]()
        do {
            friends = try await WebApiManager.shared.getFriend2()
        } catch {
            print("请求失败: \(error)")
            XCTAssert(false)
        }
        if friends.count > 0 {
            XCTAssert(true)
        }
    }

    func testGetFriend3() async throws{
        var friends = [Friend]()
        do {
            friends = try await WebApiManager.shared.getFriend3()
        } catch {
            print("请求失败: \(error)")
            XCTAssert(false)
        }
        if friends.count > 0 {
            XCTAssert(true)
        }
    }

    func testGetFriend4() async throws{
        var friends = [Friend]()
        do {
            friends = try await WebApiManager.shared.getFriend4()
        } catch {
            print("请求失败: \(error)")
            XCTAssert(false)
        }
        if friends.count == 0 {
            XCTAssert(false)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
