import Foundation
import RevdokuAPI

public func listMailboxes() async throws {
    RevdokuAPIAPI.customHeaders["Authorization"] = "Bearer \(try requiredEnvironment("REVDOKU_API_KEY"))"
    let result: ListMailboxes200Response = try await withCheckedThrowingContinuation { continuation in
        DefaultAPI.listMailboxes(accountId: accountID()) { result, error in
            if let error = error { continuation.resume(throwing: error) }
            else if let result = result { continuation.resume(returning: result) }
            else { continuation.resume(throwing: ExampleError.missingResponse) }
        }
    }
    for mailbox in result.data.mailboxes { print(mailbox.id, mailbox.title) }
}
