import Recipes

@main
struct Examples {
    static func main() async throws {
        switch CommandLine.arguments.dropFirst().first {
        case "list-mailboxes": try await listMailboxes()
        case "create-mailbox": try await createMailbox()
        case "read-emails": try await readEmails()
        case "download-attachment": try await downloadAttachment()
        case "list-files": try await listFiles()
        default: print("Usage: swift run RevdokuExamples list-mailboxes|create-mailbox|read-emails|download-attachment|list-files")
        }
    }
}
