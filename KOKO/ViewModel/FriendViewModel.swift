//
//  FriendViewModel.swift
//  KOKO
//
//  Created by David Shiue on 2025/10/17.
//

import UIKit

class FriendViewModel:NSObject{
    var man: Man = Man(name: "unknow", id: ""){
        didSet {
            self.bindManToViewController()
        }
    }
    var friends: [Friend] = [Friend](){
        didSet {
            var invite_items = [Friend]()
            var list_items = [Friend]()
            for friend in friends {
                if friend.status == 0 {
                    invite_items.append(friend)
                } else {
                    list_items.append(friend)
                }
            }
            friends_invite = invite_items
            friends_list = list_items
            self.bindFriendsToViewController()
        }
    }
    var friends_invite: [Friend] = [Friend]()
    var friends_list: [Friend] = [Friend]()


    public var bindManToViewController: (() -> ()) = {}
    public var bindFriendsToViewController: (() -> ()) = {}

    func getMan(){
        Task {
            do {
                man = try await WebApiManager.shared.getMan()
                
                print(man)
                
            } catch {
                print("请求失败: \(error)")
            }

        }
    }
    
    func mergeFriends(friendsA: [Friend], friendsB: [Friend]) -> [Friend] {
        var friends_merage = [Friend]()
        friends_merage.append(contentsOf: friendsA)
        for (indexB, friendsB_item) in friendsB.enumerated() {
            var checkFidFlag = false
            for (indexA, friendsA_item) in friendsA.enumerated() {
                if friendsB_item.fid == friendsA_item.fid{
                    checkFidFlag = true
                    if friendsB_item.updateDate > friendsA_item.updateDate{
                        friends_merage[indexA] = friendsB_item
                    }
                    
                    break
                }
            }
            if !checkFidFlag {
                friends_merage.append(friendsB_item)
            }
        }
        return friends_merage
    }
    
    func getFriends(sceneIndex: Int){
        
        switch sceneIndex{
        case 0:
            Task {
                do {
                    friends = try await WebApiManager.shared.getFriend4()
                    
                    print(friends)
                    
                } catch {
                    print("请求失败: \(error)")
                }

            }

            break
        case 1:
            Task {
                do {
                    let friends1 = try await WebApiManager.shared.getFriend1()
                    let friends2 = try await WebApiManager.shared.getFriend2()
                    friends = mergeFriends(friendsA: friends1, friendsB: friends2)

                    print(friends)
                    
                } catch {
                    print("请求失败: \(error)")
                }

            }
           break
        case 2:
            Task {
                do {
                    friends = try await WebApiManager.shared.getFriend3()
                    
                    print(friends)
                    
                } catch {
                    print("请求失败: \(error)")
                }

            }
            break
        default:
            break
        }
        
        
    }

}
