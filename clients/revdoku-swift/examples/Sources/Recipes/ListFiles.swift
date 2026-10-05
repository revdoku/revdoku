import Foundation
import RevdokuAPI

public func listFiles() async throws {
    RevdokuAPIAPI.customHeaders["Authorization"] = "Bearer \(try requiredEnvironment("REVDOKU_API_KEY"))"
    let mailbox = try requiredEnvironment("REVDOKU_BUCKET_ID")
    var offset = 0
    while true {
        let response: ListMailboxFiles200Response = try await withCheckedThrowingContinuation { continuation in
            DefaultAPI.listMailboxFiles(id: mailbox, limit: 100, offset: offset, accountId: accountID()) { result, error in
                if let error = error { continuation.resume(throwing: error) }
                else if let result = result { continuation.resume(returning: result) }
                else { continuation.resume(throwing: ExampleError.missingResponse) }
            }
        }
        for file in response.data.files { print(String(decoding: try JSONEncoder().encode(file), as: UTF8.self)) }
        if !response.data.pagination.hasMore { break }
        guard let next = response.data.pagination.nextOffset, next > offset else { throw ExampleError.pagination }
        offset = next
    }
}
