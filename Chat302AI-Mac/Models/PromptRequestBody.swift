//
//  PromptRequestBody.swift
//  Chat302AI-Mac
//
//  Created by Cyril Zakka on 8/23/24.
//

import Foundation

struct PromptRequestBody: Encodable {
    let id: String?
    let files: [String]? = nil
    let inputs: String?
    let isRetry: Bool?
    let isContinue: Bool?
    let webSearch: Bool?
    
    init(id: String? = nil, inputs: String? = nil, isRetry: Bool = false, isContinue: Bool = false, webSearch: Bool = false) {
        self.id = id
        self.inputs = inputs
        self.isRetry = isRetry
        self.isContinue = isContinue
        self.webSearch = webSearch
    }
}

 
