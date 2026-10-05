import Foundation
import RevdokuAPI

public func createMailbox() async throws {
    RevdokuAPIAPI.customHeaders["Authorization"] = "Bearer \(try requiredEnvironment("REVDOKU_API_KEY"))"
    do {
        let result: CreateMailbox201Response = try await withCheckedThrowingContinuation { continuation in
            DefaultAPI.createMailbox(createMailboxRequest: CreateMailboxRequest(
                accountId: accountID(), mailbox: CreateMailboxRequestMailbox(title: "Example mailbox")
            )) { result, error in
                if let error = error { continuation.resume(throwing: error) }
                else if let result = result { continuation.resume(returning: result) }
                else { continuation.resume(throwing: ExampleError.missingResponse) }
            }
        }
        guard let mailbox = result.data.mailbox, let id = mailbox.id, let email = mailbox.email else {
            throw ExampleError.missingResponse
        }
        guard let address = email.address else { throw ExampleError.missingResponse }
        print(id, address)
    } catch {
        if case let ErrorResponse.error(status, data, response, _) = error {
            let body = data.map { String(decoding: $0, as: UTF8.self) } ?? ""
            FileHandle.standardError.write(Data("HTTP \(status): \(body)\n".utf8))
            if let delay = (response as? HTTPURLResponse)?.value(forHTTPHeaderField: "Retry-After") {
                FileHandle.standardError.write(Data("Retry-After: \(delay)\n".utf8))
            }
        }
        FileHandle.standardError.write(Data("Creation was not confirmed. Check existing mailboxes before another creation attempt.\n".utf8))
        throw error
    }
}
