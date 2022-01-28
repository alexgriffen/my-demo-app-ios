//
//  BacktraceWrapper.swift
//  My Demo App
//
//  Created by Vincent Lussenburg on 1/28/22.
//

import Foundation
import Backtrace

class BacktraceWrapper {
    public static let BACKTRACE_TOKEN = "f5eeec8488793fad19f79bb538d4ebb80efdf26b879b59765f57bdb5749aa56b"
    
    public static func begin() {
        let backtraceCredentials = BacktraceCredentials(endpoint: URL(string: "https://cd03.sp.backtrace.io:6098/")!, token: BACKTRACE_TOKEN)
        let configuration = BacktraceClientConfiguration(credentials: backtraceCredentials,
                                                         dbSettings: BacktraceDatabaseSettings(),
                                                         reportsPerMin: 10,
                                                         allowsAttachingDebugger: true,
                                                         detectOOM: true)
        BacktraceClient.shared = try? BacktraceClient(configuration: configuration)
        BacktraceClient.shared?.metrics.enable(settings: BacktraceMetricsSettings())
        
        // send example report
        BacktraceClient.shared?.send(attachmentPaths: []) { result in print("Backtrace startup") }
    }
    
    public static func log(_ message: String!) {
        print("\(message ?? "")")
        BacktraceClient.shared?.send(attachmentPaths: []) { (message) in
            print(message)
        }
    }
    
    public static func die() {
        fatalError()
    }
}
