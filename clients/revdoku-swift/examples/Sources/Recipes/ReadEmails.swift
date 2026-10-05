import Foundation
import RevdokuAPI

public func readEmails() async throws {
    RevdokuAPIAPI.customHeaders["Authorization"] = "Bearer \(try requiredEnvironment("REVDOKU_API_KEY"))"
    let mailbox = try requiredEnvironment("REVDOKU_BUCKET_ID")
    let account = accountID()
    var cursor: String?
    var seen = Set<String>()
    while true {
        let response: ListEmails200Response = try await withCheckedThrowingContinuation { continuation in
            DefaultAPI.listEmails(mailboxId: mailbox, accountId: account, limit: 100, cursor: cursor, order: .asc, read: false) { result, error in
                if let error = error { continuation.resume(throwing: error) }
                else if let result = result { continuation.resume(returning: result) }
                else { continuation.resume(throwing: ExampleError.missingResponse) }
            }
        }
        for summary in response.data.emails {
            let detail: GetEmail200Response = try await withCheckedThrowingContinuation { continuation in
                DefaultAPI.getEmail(mailboxId: mailbox, emailId: summary.id, accountId: account) { result, error in
                    if let error = error { continuation.resume(throwing: error) }
                    else if let result = result { continuation.resume(returning: result) }
                    else { continuation.resume(throwing: ExampleError.missingResponse) }
                }
            }
            print(String(decoding: try JSONEncoder().encode(detail.data.email), as: UTF8.self))
        }
        if !response.data.pagination.hasMore { break }
        let next = response.data.pagination.nextCursor
        guard !next.isEmpty, seen.insert(next).inserted else { throw ExampleError.pagination }
        cursor = next
    }
    // Reading does not change shared read/unread status.
}
