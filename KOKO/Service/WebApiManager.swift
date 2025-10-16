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
    
    func getMan(){
        Task {
            do {
                let jsonString = try await NetworkManager.shared.fetchJSONStringAsyncAwait(from: "https://dimanyen.github.io/man.json")
                print(jsonString)
            } catch {
                print("请求失败: \(error)")
            }
        }
    }
    
    func getFriend1(){
        Task {
            do {
                let jsonString = try await NetworkManager.shared.fetchJSONStringAsyncAwait(from: "https://dimanyen.github.io/friend1.json")
                print(jsonString)
            } catch {
                print("请求失败: \(error)")
            }
        }
    }

    func getFriend2(){
        Task {
            do {
                let jsonString = try await NetworkManager.shared.fetchJSONStringAsyncAwait(from: "https://dimanyen.github.io/friend1.json")
                print(jsonString)
            } catch {
                print("请求失败: \(error)")
            }
        }
    }

    func getFriend3(){
        Task {
            do {
                let jsonString = try await NetworkManager.shared.fetchJSONStringAsyncAwait(from: "https://dimanyen.github.io/friend1.json")
                print(jsonString)
            } catch {
                print("请求失败: \(error)")
            }
        }
    }

    func getFriend4(){
        Task {
            do {
                let jsonString = try await NetworkManager.shared.fetchJSONStringAsyncAwait(from: "https://dimanyen.github.io/friend1.json")
                print(jsonString)
            } catch {
                print("请求失败: \(error)")
            }
        }
    }

}
