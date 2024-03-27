//
//  PostStruct.swift
//  Navigation
//
//  Created by Миша Вашкевич on 06.12.2023.
//

import Foundation
import UIKit

public struct PostStruct {
    public var author: String
    public var description: String
    public var image: UIImage?
    public var likes: Int
    public var views: Int
    
    public init(author: String, description: String, image: UIImage? = nil, likes: Int, views: Int) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
    }
}

extension PostStruct {
    
    public static func make() -> [PostStruct] {
        [ 
            PostStruct(
            author: "Justin",
            description: "ahaha it's so funny",
            image: UIImage(named: "gag"),
            likes: 99,
            views: 109),
            PostStruct(
            author: "Michael",
            description: "nature",
            image: UIImage(named: "nature"),
            likes: 66,
            views: 101),
          PostStruct(
            author: "SpaceX",
            description: "let's go to stars",
            image: UIImage(named: "elon"),
            likes: 31,
            views: 34),
          PostStruct(
            author: "Discovery",
            description: "hurry up, today a new episode with BearGrils, 10 ap at Discovert channel",
            image: UIImage(named: "discovery"),
            likes: 13,
            views: 78)
        ]
    }
}
