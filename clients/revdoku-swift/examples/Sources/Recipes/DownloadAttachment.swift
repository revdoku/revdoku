import Foundation
import RevdokuAPI

private final class NoDownloadRedirects: NSObject, URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse,
                    newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        completionHandler(nil)
    }
}

public func downloadAttachment() async throws {
    RevdokuAPIAPI.customHeaders["Authorization"] = "Bearer \(try requiredEnvironment("REVDOKU_API_KEY"))"
    let mailbox = try requiredEnvironment("REVDOKU_BUCKET_ID")
    let email = try requiredEnvironment("REVDOKU_EMAIL_ID")
    let attachment = try requiredEnvironment("REVDOKU_ATTACHMENT_ID")
    let output = try requiredEnvironment("REVDOKU_DOWNLOAD_PATH")
    let response: GetEmailOriginalDownloadUrl200Response = try await withCheckedThrowingContinuation { continuation in
        DefaultAPI.getEmailAttachmentDownloadUrl(mailboxId: mailbox, emailId: email, attachmentId: attachment, accountId: accountID()) { result, error in
            if let error = error { continuation.resume(throwing: error) }
            else if let result = result { continuation.resume(returning: result) }
            else { continuation.resume(throwing: ExampleError.missingResponse) }
        }
    }
    let download = response.data.download
    guard download.authentication == ._none, let url = URL(string: download.url), url.scheme == "https",
          url.host != nil, url.user == nil, url.password == nil else { throw ExampleError.invalidDownload }
    // This separate session sends no API token and follows no redirects.
    let session = URLSession(configuration: .ephemeral, delegate: NoDownloadRedirects(), delegateQueue: nil)
    defer { session.invalidateAndCancel() }
    let (data, result) = try await session.data(for: URLRequest(url: url, timeoutInterval: 60))
    guard let http = result as? HTTPURLResponse, http.statusCode == 200 else { throw ExampleError.invalidDownload }
    try data.write(to: URL(fileURLWithPath: output), options: .withoutOverwriting)
    print(output)
}
