//
//  Idea.swift
//  ideaHub
//
//  Created by Derek Lopes on 3/20/17.
//  Copyright © 2017 San Jose State University. All rights reserved.
//

import UIKit

class Idea: NSObject {
    var id: Int?
    var title: String?
    var content: String?
    var date: String?
    var category: String?
    var likes: Int?
    var author: String?
    
    init(id: Int, title: String, content: String, date: String, category: String, likes: Int, author: String) {
        self.id = id
        self.title = title
        self.content = content
        self.date = date
        self.category = category
        self.likes = likes
        self.author = author
    }
    
}
