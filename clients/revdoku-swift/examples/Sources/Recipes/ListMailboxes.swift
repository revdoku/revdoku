import Foundation
import RevdokuAPI

public func listMailboxes() async throws {
    RevdokuAPIAPI.customHeaders["Authorization"] = "Bearer \(try requiredEnvironment("REVDOKU_API_KEY"))"
    var offset = 0
    while true {
        let response: ListMailboxes200Response = try await withCheckedThrowingContinuation { continuation in
            DefaultAPI.listMailboxes(accountId: accountID(), status: .active, limit: 100, offset: offset) { result, error in
                if let error = error { continuation.resume(throwing: error) }
                else if let result = result { continuation.resume(returning: result) }
                else { continuation.resume(throwing: ExampleError.missingResponse) }
            }
        }
        for mailbox in response.data.mailboxes { print(mailbox.id, mailbox.email.address ?? mailbox.id) }
        if !response.data.pagination.hasMore { break }
        guard let next = response.data.pagination.nextOffset, next > offset else { throw ExampleError.pagination }
        offset = next
    }
}
