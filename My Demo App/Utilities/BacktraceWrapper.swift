//
//  BacktraceWrapper.swift
//  My Demo App
//
//  Created by Vincent Lussenburg on 1/28/22.
//

import Foundation
import Backtrace

class BacktraceWrapper {
    public static let BACKTRACE_TOKEN = "459bd6c479f30dfd9043ca25e82822f9a8f46acd99d834faf8e9cc71df61c77a"
    
    public static func begin() {
        let backtraceCredentials = BacktraceCredentials(endpoint: URL(string: "https://cd03.sp.backtrace.io:6098/")!,
                                                        token: BACKTRACE_TOKEN)
               BacktraceClient.shared = try? BacktraceClient(credentials: backtraceCredentials)

    }
    
    public static func log(_ message: String!) {
        print("\(message ?? "")")
        BacktraceClient.shared?.send(attachmentPaths: []) { (message) in
            print(message)
        }
    }
}
