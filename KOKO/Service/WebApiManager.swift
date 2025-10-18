//
//  WebApiManager.swift
//  KOKO
//
//  Created by David Shiue on 2025/10/16.
//

import Foundation
class WebApiManager {
    static let shared = WebApiManager()
    private init() {}
    
    func jsonStringToDictionary(_ jsonString: String) -> [String: Any]? {
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("無法將字符串轉換為 Data")
            return nil
        }
        
        do {
            let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            return dictionary
        } catch {
            print("JSON 解析錯誤: \(error.localizedDescription)")
            return nil
        }
    }

    func getMan() async throws -> Man{
        var man = Man(name: "", id: "")
        do {
            let jsonString = try await NetworkManager.shared.fetchJSONStringAsyncAwait(from: "https://dimanyen.github.io/man.json")
            print(jsonString)
            if let dictionary = jsonStringToDictionary(jsonString) {
                print("解析結果:")
                print(dictionary)
                
                // 訪問具體值
                if let response = dictionary["response"] as? [NSDictionary] {
                    print("response: \(response)")
                    if response.count > 0 {
                        let manDict = response[0] 
                        print("manDict: \(manDict)")

                        if let name = manDict["name"] as? String, let kokoid = manDict["kokoid"] as? String{
                            print("name: \(name)")
                            print("kokoid: \(kokoid)")
                            man = Man(name: (name), id: kokoid)
                         }
                    }
                }
            } else {
                print("解析失敗")
            }
        } catch {
            print("请求失败: \(error)")
        }
        return man
    }
    
    func getFriends(urlString: String) async throws -> [Friend]{
        var friends = [Friend]()
        do {
            let jsonString = try await NetworkManager.shared.fetchJSONStringAsyncAwait(from: urlString)
            print(jsonString)
            if let dictionary = jsonStringToDictionary(jsonString) {
                print("解析結果:")
                print(dictionary)
                if let response = dictionary["response"] as? [NSDictionary] {
                    print("response: \(response)")
                    for friendDict in response{
                        //let manDict = response[0]
                        print("friendDict: \(friendDict)")
                        
                        if let name = friendDict["name"] as? String, let status = friendDict["status"] as? Int, let isTop = friendDict["isTop"] as? String, let fid = friendDict["fid"] as? String, let updateDate = friendDict["updateDate"] as? String{
                            print("name: \(name)")
                            print("status: \(status)")
                            print("isTop: \(isTop)")
                            print("fid: \(fid)")
                            print("updateDate: \(updateDate)")
                            let friend = Friend(name: name, status: status, isTop: isTop, fid: fid, updateDate: updateDate.replacingOccurrences(of: "/", with: ""))
                            friends.append(friend)
                        }
                    }
                }
            }

        } catch {
            print("请求失败: \(error)")
        }
        return friends
    }

    func getFriend1() async throws -> [Friend]{
        var friends = [Friend]()
        do {
            friends = try await getFriends(urlString: "https://dimanyen.github.io/friend1.json")
        } catch {
            print("请求失败: \(error)")
        }
        return friends
    }

    func getFriend2() async throws -> [Friend]{
        var friends = [Friend]()
        do {
            friends = try await getFriends(urlString: "https://dimanyen.github.io/friend2.json")
        } catch {
            print("请求失败: \(error)")
        }
        return friends
    }

    func getFriend3() async throws -> [Friend]{
        var friends = [Friend]()
        do {
            friends = try await getFriends(urlString: "https://dimanyen.github.io/friend3.json")
        } catch {
            print("请求失败: \(error)")
        }
        return friends
    }

    func getFriend4() async throws -> [Friend]{
        var friends = [Friend]()
        do {
            friends = try await getFriends(urlString: "https://dimanyen.github.io/friend4.json")
        } catch {
            print("请求失败: \(error)")
        }
        return friends
    }
}
