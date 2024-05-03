//
//  Constants.swift
//  FinalWordsChat
//
//  Created by Brandon Shaw on 6/27/18.
//  Copyright © 2018 Brandon Shaw. All rights reserved.
//

import Firebase

struct Constants {
    struct refs {
        static let databaseRoot = Database.database().reference()
        static let databaseChatsFive = databaseRoot.child("chatPercent5")
        static let databaseChatsFour = databaseRoot.child("chatPercent4")
        static let databaseChatsThree = databaseRoot.child("chatPercent3")
        static let databaseChatsTwo = databaseRoot.child("chatPercent2")
        static let databaseChatsOne = databaseRoot.child("chatPercent1")
    }
    
//    class mainAPI {
//        var REF_USERSONLINE = Database.database().reference().child("numberOnline")
//
//        func fetchCountUsersOnline(_ completion: @escaping (Int) -> Void) {
//            REF_USERSONLINE.observe(.value, with: {
//                snapshot in
//                let count = Int(snapshot.childrenCount)
//                completion(count)
//            })
//        }
//    }
}
