import Foundation

enum ExampleError: Error {
    case missingEnvironment(String), missingResponse, invalidDownload, pagination
}

func requiredEnvironment(_ name: String) throws -> String {
    guard let value = ProcessInfo.processInfo.environment[name], !value.isEmpty else {
        throw ExampleError.missingEnvironment(name)
    }
    return value
}

func accountID() -> String? {
    ProcessInfo.processInfo.environment["REVDOKU_ACCOUNT_ID"].flatMap { $0.isEmpty ? nil : $0 }
}
