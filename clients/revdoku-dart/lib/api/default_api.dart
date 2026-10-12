//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;


class DefaultApi {
  DefaultApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get storage targets for a batch
  ///
  /// Returns upload.url and upload.headers for each file that needs bytes. Repeating a path returns a fresh target, for example after a failed PUT. Files with identical content are skipped.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] sessionId (required):
  ///   mailbox_upload_session.id from the create response.
  ///
  /// * [AddUploadSessionFilesRequest] addUploadSessionFilesRequest (required):
  Future<Response> addUploadSessionFilesWithHttpInfo(String mailboxId, String sessionId, AddUploadSessionFilesRequest addUploadSessionFilesRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/upload_sessions/{session_id}/uploads'
      .replaceAll('{mailbox_id}', mailboxId)
      .replaceAll('{session_id}', sessionId);

    // ignore: prefer_final_locals
    Object? postBody = addUploadSessionFilesRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Get storage targets for a batch
  ///
  /// Returns upload.url and upload.headers for each file that needs bytes. Repeating a path returns a fresh target, for example after a failed PUT. Files with identical content are skipped.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] sessionId (required):
  ///   mailbox_upload_session.id from the create response.
  ///
  /// * [AddUploadSessionFilesRequest] addUploadSessionFilesRequest (required):
  Future<CreateUploadSession201Response?> addUploadSessionFiles(String mailboxId, String sessionId, AddUploadSessionFilesRequest addUploadSessionFilesRequest, { Future<void>? abortTrigger, }) async {
    final response = await addUploadSessionFilesWithHttpInfo(mailboxId, sessionId, addUploadSessionFilesRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CreateUploadSession201Response',) as CreateUploadSession201Response;
    
    }
    return null;
  }

  /// Append text to a file
  ///
  /// Appends UTF-8 text to an existing text file and creates a new version. A missing file returns MAILBOX_FILE_NOT_FOUND.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [AppendTextRequest] appendTextRequest (required):
  Future<Response> appendTextWithHttpInfo(String mailboxId, AppendTextRequest appendTextRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/files/append_text'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody = appendTextRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Append text to a file
  ///
  /// Appends UTF-8 text to an existing text file and creates a new version. A missing file returns MAILBOX_FILE_NOT_FOUND.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [AppendTextRequest] appendTextRequest (required):
  Future<AppendText200Response?> appendText(String mailboxId, AppendTextRequest appendTextRequest, { Future<void>? abortTrigger, }) async {
    final response = await appendTextWithHttpInfo(mailboxId, appendTextRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AppendText200Response',) as AppendText200Response;
    
    }
    return null;
  }

  /// Archive a mailbox
  ///
  /// Archived mailboxes keep their files and emails and become read-only.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [ActionRequest] actionRequest (required):
  Future<Response> archiveMailboxWithHttpInfo(String mailboxId, ActionRequest actionRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/archive'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody = actionRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Archive a mailbox
  ///
  /// Archived mailboxes keep their files and emails and become read-only.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [ActionRequest] actionRequest (required):
  Future<CreateMailbox201Response?> archiveMailbox(String mailboxId, ActionRequest actionRequest, { Future<void>? abortTrigger, }) async {
    final response = await archiveMailboxWithHttpInfo(mailboxId, actionRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CreateMailbox201Response',) as CreateMailbox201Response;
    
    }
    return null;
  }

  /// Change the primary address
  ///
  /// Requires a paid plan and mailbox admin permission. Send the current address as expected_address. Omit username for a generated name. A custom-domain change returns 202; read the settings until assignment.status is active or failed. The old address stops receiving unless keep_old_as_alias is true.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [ChangeMailboxAddressRequest] changeMailboxAddressRequest (required):
  Future<Response> changeMailboxAddressWithHttpInfo(String mailboxId, ChangeMailboxAddressRequest changeMailboxAddressRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/email/rotate'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody = changeMailboxAddressRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Change the primary address
  ///
  /// Requires a paid plan and mailbox admin permission. Send the current address as expected_address. Omit username for a generated name. A custom-domain change returns 202; read the settings until assignment.status is active or failed. The old address stops receiving unless keep_old_as_alias is true.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [ChangeMailboxAddressRequest] changeMailboxAddressRequest (required):
  Future<GetMailboxEmailSettings200Response?> changeMailboxAddress(String mailboxId, ChangeMailboxAddressRequest changeMailboxAddressRequest, { Future<void>? abortTrigger, }) async {
    final response = await changeMailboxAddressWithHttpInfo(mailboxId, changeMailboxAddressRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetMailboxEmailSettings200Response',) as GetMailboxEmailSettings200Response;
    
    }
    return null;
  }

  /// Check a hostname for conflicting DNS
  ///
  /// Makes no claim and changes no DNS. If the root domain already receives email, use an unused subdomain such as inbox.example.com.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [CreateEmailDomainRequest] createEmailDomainRequest (required):
  Future<Response> checkEmailDomainWithHttpInfo(CreateEmailDomainRequest createEmailDomainRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/account/email_domains/check';

    // ignore: prefer_final_locals
    Object? postBody = createEmailDomainRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Check a hostname for conflicting DNS
  ///
  /// Makes no claim and changes no DNS. If the root domain already receives email, use an unused subdomain such as inbox.example.com.
  ///
  /// Parameters:
  ///
  /// * [CreateEmailDomainRequest] createEmailDomainRequest (required):
  Future<CheckEmailDomain200Response?> checkEmailDomain(CreateEmailDomainRequest createEmailDomainRequest, { Future<void>? abortTrigger, }) async {
    final response = await checkEmailDomainWithHttpInfo(createEmailDomainRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CheckEmailDomain200Response',) as CheckEmailDomain200Response;
    
    }
    return null;
  }

  /// Copy a file
  ///
  /// Works in the same mailbox or into target_mailbox_id. Content is not uploaded again. Send target_path for an exact path or target_folder to keep the name.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] fileId (required):
  ///
  /// * [MoveFileRequest] moveFileRequest (required):
  Future<Response> copyFileWithHttpInfo(String mailboxId, String fileId, MoveFileRequest moveFileRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/files/{file_id}/copy'
      .replaceAll('{mailbox_id}', mailboxId)
      .replaceAll('{file_id}', fileId);

    // ignore: prefer_final_locals
    Object? postBody = moveFileRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Copy a file
  ///
  /// Works in the same mailbox or into target_mailbox_id. Content is not uploaded again. Send target_path for an exact path or target_folder to keep the name.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] fileId (required):
  ///
  /// * [MoveFileRequest] moveFileRequest (required):
  Future<RenameFile200Response?> copyFile(String mailboxId, String fileId, MoveFileRequest moveFileRequest, { Future<void>? abortTrigger, }) async {
    final response = await copyFileWithHttpInfo(mailboxId, fileId, moveFileRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'RenameFile200Response',) as RenameFile200Response;
    
    }
    return null;
  }

  /// Create a dashboard link for the user
  ///
  /// Returns a dashboard URL for a path such as /mailboxes. The user signs in normally; the link grants no access.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [CreateBrowserLinkRequest] createBrowserLinkRequest (required):
  Future<Response> createBrowserLinkWithHttpInfo(CreateBrowserLinkRequest createBrowserLinkRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/agent_auth/browser_login_link';

    // ignore: prefer_final_locals
    Object? postBody = createBrowserLinkRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Create a dashboard link for the user
  ///
  /// Returns a dashboard URL for a path such as /mailboxes. The user signs in normally; the link grants no access.
  ///
  /// Parameters:
  ///
  /// * [CreateBrowserLinkRequest] createBrowserLinkRequest (required):
  Future<CreateBrowserLink201Response?> createBrowserLink(CreateBrowserLinkRequest createBrowserLinkRequest, { Future<void>? abortTrigger, }) async {
    final response = await createBrowserLinkWithHttpInfo(createBrowserLinkRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CreateBrowserLink201Response',) as CreateBrowserLink201Response;
    
    }
    return null;
  }

  /// Create a client account
  ///
  /// Requires an agency owner credential with client-account access. The credential default does not change; send the new account_id on later requests.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [CreateClientAccountRequest] createClientAccountRequest (required):
  Future<Response> createClientAccountWithHttpInfo(CreateClientAccountRequest createClientAccountRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/accounts';

    // ignore: prefer_final_locals
    Object? postBody = createClientAccountRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Create a client account
  ///
  /// Requires an agency owner credential with client-account access. The credential default does not change; send the new account_id on later requests.
  ///
  /// Parameters:
  ///
  /// * [CreateClientAccountRequest] createClientAccountRequest (required):
  Future<CreateClientAccount201Response?> createClientAccount(CreateClientAccountRequest createClientAccountRequest, { Future<void>? abortTrigger, }) async {
    final response = await createClientAccountWithHttpInfo(createClientAccountRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CreateClientAccount201Response',) as CreateClientAccount201Response;
    
    }
    return null;
  }

  /// Add an alias address
  ///
  /// Requires a paid plan and a full-account owner or administrator with mailbox-admin permission. The primary address stays unchanged.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [CreateEmailAliasRequest] createEmailAliasRequest (required):
  Future<Response> createEmailAliasWithHttpInfo(String mailboxId, CreateEmailAliasRequest createEmailAliasRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/email/aliases'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody = createEmailAliasRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Add an alias address
  ///
  /// Requires a paid plan and a full-account owner or administrator with mailbox-admin permission. The primary address stays unchanged.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [CreateEmailAliasRequest] createEmailAliasRequest (required):
  Future<GetMailboxEmailSettings200Response?> createEmailAlias(String mailboxId, CreateEmailAliasRequest createEmailAliasRequest, { Future<void>? abortTrigger, }) async {
    final response = await createEmailAliasWithHttpInfo(mailboxId, createEmailAliasRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetMailboxEmailSettings200Response',) as GetMailboxEmailSettings200Response;
    
    }
    return null;
  }

  /// Connect a custom email domain
  ///
  /// Claims an exact hostname and returns the DNS records to publish. Never change DNS without the domain owner's authorization.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [CreateEmailDomainRequest] createEmailDomainRequest (required):
  Future<Response> createEmailDomainWithHttpInfo(CreateEmailDomainRequest createEmailDomainRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/account/email_domains';

    // ignore: prefer_final_locals
    Object? postBody = createEmailDomainRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Connect a custom email domain
  ///
  /// Claims an exact hostname and returns the DNS records to publish. Never change DNS without the domain owner's authorization.
  ///
  /// Parameters:
  ///
  /// * [CreateEmailDomainRequest] createEmailDomainRequest (required):
  Future<CreateEmailDomain201Response?> createEmailDomain(CreateEmailDomainRequest createEmailDomainRequest, { Future<void>? abortTrigger, }) async {
    final response = await createEmailDomainWithHttpInfo(createEmailDomainRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CreateEmailDomain201Response',) as CreateEmailDomain201Response;
    
    }
    return null;
  }

  /// Create a mailbox
  ///
  /// Waits until the address can receive email. On Free, email.username is a prefix with a permanent random suffix; an exact name requires a paid plan. If confirmation does not finish, EMAIL_NOT_READY returns the created mailbox_id in error.details: read that mailbox instead of creating another. Never retry a creation automatically.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [CreateMailboxRequest] createMailboxRequest (required):
  Future<Response> createMailboxWithHttpInfo(CreateMailboxRequest createMailboxRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes';

    // ignore: prefer_final_locals
    Object? postBody = createMailboxRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Create a mailbox
  ///
  /// Waits until the address can receive email. On Free, email.username is a prefix with a permanent random suffix; an exact name requires a paid plan. If confirmation does not finish, EMAIL_NOT_READY returns the created mailbox_id in error.details: read that mailbox instead of creating another. Never retry a creation automatically.
  ///
  /// Parameters:
  ///
  /// * [CreateMailboxRequest] createMailboxRequest (required):
  Future<CreateMailbox201Response?> createMailbox(CreateMailboxRequest createMailboxRequest, { Future<void>? abortTrigger, }) async {
    final response = await createMailboxWithHttpInfo(createMailboxRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CreateMailbox201Response',) as CreateMailbox201Response;
    
    }
    return null;
  }

  /// Start a batch upload
  ///
  /// Starts an upload session for many files and returns storage targets for the first files. The session locks the mailbox for other writers; incoming email still arrives. Send files in batches with POST .../uploads, PUT the bytes to each upload.url, save each batch with POST .../finalize_batch, then call POST .../finalize. Unsaved uploads are discarded when the session expires.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [CreateUploadSessionRequest] createUploadSessionRequest (required):
  Future<Response> createUploadSessionWithHttpInfo(String mailboxId, CreateUploadSessionRequest createUploadSessionRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/upload_sessions'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody = createUploadSessionRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Start a batch upload
  ///
  /// Starts an upload session for many files and returns storage targets for the first files. The session locks the mailbox for other writers; incoming email still arrives. Send files in batches with POST .../uploads, PUT the bytes to each upload.url, save each batch with POST .../finalize_batch, then call POST .../finalize. Unsaved uploads are discarded when the session expires.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [CreateUploadSessionRequest] createUploadSessionRequest (required):
  Future<CreateUploadSession201Response?> createUploadSession(String mailboxId, CreateUploadSessionRequest createUploadSessionRequest, { Future<void>? abortTrigger, }) async {
    final response = await createUploadSessionWithHttpInfo(mailboxId, createUploadSessionRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CreateUploadSession201Response',) as CreateUploadSession201Response;
    
    }
    return null;
  }

  /// Delete an email
  ///
  /// Requires mailbox-admin permission. Deletes the stored message and its attachments. There is no trash.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] emailId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<Response> deleteEmailWithHttpInfo(String mailboxId, String emailId, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/emails/{email_id}'
      .replaceAll('{mailbox_id}', mailboxId)
      .replaceAll('{email_id}', emailId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }
    if (reason != null) {
      queryParams.addAll(_queryParams('', 'reason', reason));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Delete an email
  ///
  /// Requires mailbox-admin permission. Deletes the stored message and its attachments. There is no trash.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] emailId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<DeleteEmailDomain200Response?> deleteEmail(String mailboxId, String emailId, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    final response = await deleteEmailWithHttpInfo(mailboxId, emailId, accountId: accountId, reason: reason, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DeleteEmailDomain200Response',) as DeleteEmailDomain200Response;
    
    }
    return null;
  }

  /// Remove an alias address
  ///
  /// Stops new and queued deliveries to the alias. Saved emails stay.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] aliasId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<Response> deleteEmailAliasWithHttpInfo(String mailboxId, String aliasId, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/email/aliases/{alias_id}'
      .replaceAll('{mailbox_id}', mailboxId)
      .replaceAll('{alias_id}', aliasId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }
    if (reason != null) {
      queryParams.addAll(_queryParams('', 'reason', reason));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Remove an alias address
  ///
  /// Stops new and queued deliveries to the alias. Saved emails stay.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] aliasId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<DeleteEmailDomain200Response?> deleteEmailAlias(String mailboxId, String aliasId, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    final response = await deleteEmailAliasWithHttpInfo(mailboxId, aliasId, accountId: accountId, reason: reason, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DeleteEmailDomain200Response',) as DeleteEmailDomain200Response;
    
    }
    return null;
  }

  /// Remove an unused custom email domain
  ///
  /// Send the domain hostname and confirm=true. A domain that mailbox addresses still use returns EMAIL_DOMAIN_IN_USE.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] domainId (required):
  ///
  /// * [DeleteEmailDomainRequest] deleteEmailDomainRequest (required):
  Future<Response> deleteEmailDomainWithHttpInfo(String domainId, DeleteEmailDomainRequest deleteEmailDomainRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/account/email_domains/{domain_id}'
      .replaceAll('{domain_id}', domainId);

    // ignore: prefer_final_locals
    Object? postBody = deleteEmailDomainRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Remove an unused custom email domain
  ///
  /// Send the domain hostname and confirm=true. A domain that mailbox addresses still use returns EMAIL_DOMAIN_IN_USE.
  ///
  /// Parameters:
  ///
  /// * [String] domainId (required):
  ///
  /// * [DeleteEmailDomainRequest] deleteEmailDomainRequest (required):
  Future<DeleteEmailDomain200Response?> deleteEmailDomain(String domainId, DeleteEmailDomainRequest deleteEmailDomainRequest, { Future<void>? abortTrigger, }) async {
    final response = await deleteEmailDomainWithHttpInfo(domainId, deleteEmailDomainRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DeleteEmailDomain200Response',) as DeleteEmailDomain200Response;
    
    }
    return null;
  }

  /// Remove the email webhook
  ///
  /// Cancels queued deliveries. A delivery already in progress can finish. Returns the mailbox ID, also when no webhook is set.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  Future<Response> deleteEmailWebhookWithHttpInfo(String mailboxId, { String? accountId, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/email/webhook'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Remove the email webhook
  ///
  /// Cancels queued deliveries. A delivery already in progress can finish. Returns the mailbox ID, also when no webhook is set.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  Future<DeleteEmailDomain200Response?> deleteEmailWebhook(String mailboxId, { String? accountId, Future<void>? abortTrigger, }) async {
    final response = await deleteEmailWebhookWithHttpInfo(mailboxId, accountId: accountId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DeleteEmailDomain200Response',) as DeleteEmailDomain200Response;
    
    }
    return null;
  }

  /// Delete a file
  ///
  /// Requires mailbox-admin permission. Files under _email/ return EMAIL_PATH_READ_ONLY; delete the email instead.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] fileId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<Response> deleteFileWithHttpInfo(String mailboxId, String fileId, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/files/{file_id}'
      .replaceAll('{mailbox_id}', mailboxId)
      .replaceAll('{file_id}', fileId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }
    if (reason != null) {
      queryParams.addAll(_queryParams('', 'reason', reason));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Delete a file
  ///
  /// Requires mailbox-admin permission. Files under _email/ return EMAIL_PATH_READ_ONLY; delete the email instead.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] fileId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<DeleteEmailDomain200Response?> deleteFile(String mailboxId, String fileId, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    final response = await deleteFileWithHttpInfo(mailboxId, fileId, accountId: accountId, reason: reason, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DeleteEmailDomain200Response',) as DeleteEmailDomain200Response;
    
    }
    return null;
  }

  /// Permanently delete an archived mailbox
  ///
  /// Archive the mailbox first. Send delete.confirmation from the mailbox read after the user confirms. Large mailboxes finish deleting in the background.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [DeleteMailboxRequest] deleteMailboxRequest (required):
  Future<Response> deleteMailboxWithHttpInfo(String mailboxId, DeleteMailboxRequest deleteMailboxRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody = deleteMailboxRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Permanently delete an archived mailbox
  ///
  /// Archive the mailbox first. Send delete.confirmation from the mailbox read after the user confirms. Large mailboxes finish deleting in the background.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [DeleteMailboxRequest] deleteMailboxRequest (required):
  Future<DeleteEmailDomain200Response?> deleteMailbox(String mailboxId, DeleteMailboxRequest deleteMailboxRequest, { Future<void>? abortTrigger, }) async {
    final response = await deleteMailboxWithHttpInfo(mailboxId, deleteMailboxRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DeleteEmailDomain200Response',) as DeleteEmailDomain200Response;
    
    }
    return null;
  }

  /// Exchange a one-time dashboard connection code for an API key
  ///
  /// The dashboard creates the one-time code when a signed-in administrator copies a connection prompt.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ExchangeConnectionGrantRequest] exchangeConnectionGrantRequest (required):
  Future<Response> exchangeConnectionGrantWithHttpInfo(ExchangeConnectionGrantRequest exchangeConnectionGrantRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/agent_auth/exchange_grant';

    // ignore: prefer_final_locals
    Object? postBody = exchangeConnectionGrantRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Exchange a one-time dashboard connection code for an API key
  ///
  /// The dashboard creates the one-time code when a signed-in administrator copies a connection prompt.
  ///
  /// Parameters:
  ///
  /// * [ExchangeConnectionGrantRequest] exchangeConnectionGrantRequest (required):
  Future<VerifySignInCode201Response?> exchangeConnectionGrant(ExchangeConnectionGrantRequest exchangeConnectionGrantRequest, { Future<void>? abortTrigger, }) async {
    final response = await exchangeConnectionGrantWithHttpInfo(exchangeConnectionGrantRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'VerifySignInCode201Response',) as VerifySignInCode201Response;
    
    }
    return null;
  }

  /// Finish or cancel a batch upload
  ///
  /// complete=true saves the remaining uploaded files, creates one mailbox version and releases the lock. A 202 response with finalize_pending=true means more files remain: call finalize again after Retry-After. complete=false cancels the session and discards its unsaved files. Finalizing a finished session returns it unchanged.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] sessionId (required):
  ///   mailbox_upload_session.id from the create response.
  ///
  /// * [FinalizeUploadSessionRequest] finalizeUploadSessionRequest:
  Future<Response> finalizeUploadSessionWithHttpInfo(String mailboxId, String sessionId, { FinalizeUploadSessionRequest? finalizeUploadSessionRequest, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/upload_sessions/{session_id}/finalize'
      .replaceAll('{mailbox_id}', mailboxId)
      .replaceAll('{session_id}', sessionId);

    // ignore: prefer_final_locals
    Object? postBody = finalizeUploadSessionRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Finish or cancel a batch upload
  ///
  /// complete=true saves the remaining uploaded files, creates one mailbox version and releases the lock. A 202 response with finalize_pending=true means more files remain: call finalize again after Retry-After. complete=false cancels the session and discards its unsaved files. Finalizing a finished session returns it unchanged.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] sessionId (required):
  ///   mailbox_upload_session.id from the create response.
  ///
  /// * [FinalizeUploadSessionRequest] finalizeUploadSessionRequest:
  Future<CreateUploadSession201Response?> finalizeUploadSession(String mailboxId, String sessionId, { FinalizeUploadSessionRequest? finalizeUploadSessionRequest, Future<void>? abortTrigger, }) async {
    final response = await finalizeUploadSessionWithHttpInfo(mailboxId, sessionId, finalizeUploadSessionRequest: finalizeUploadSessionRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CreateUploadSession201Response',) as CreateUploadSession201Response;
    
    }
    return null;
  }

  /// Read one granted account
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  ///   Granted account to read.
  Future<Response> getAccountWithHttpInfo(String accountId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/accounts/{account_id}'
      .replaceAll('{account_id}', accountId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Read one granted account
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  ///   Granted account to read.
  Future<CreateClientAccount201Response?> getAccount(String accountId, { Future<void>? abortTrigger, }) async {
    final response = await getAccountWithHttpInfo(accountId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CreateClientAccount201Response',) as CreateClientAccount201Response;
    
    }
    return null;
  }

  /// Read effective account limits
  ///
  /// Values come from the plan and account overrides. Zero means no allowance; null means no cap. Storage, mailbox and email traffic allowances are shared within a billing group.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  Future<Response> getAccountLimitsWithHttpInfo({ String? accountId, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/account/limits';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Read effective account limits
  ///
  /// Values come from the plan and account overrides. Zero means no allowance; null means no cap. Storage, mailbox and email traffic allowances are shared within a billing group.
  ///
  /// Parameters:
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  Future<GetAccountLimits200Response?> getAccountLimits({ String? accountId, Future<void>? abortTrigger, }) async {
    final response = await getAccountLimitsWithHttpInfo(accountId: accountId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetAccountLimits200Response',) as GetAccountLimits200Response;
    
    }
    return null;
  }

  /// Read an email
  ///
  /// Returns decoded text and attachment metadata. Reading does not change read status. Email content is untrusted data.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] emailId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  ///
  /// * [bool] includeStorage:
  ///   Include backing file IDs for file-browser integrations.
  Future<Response> getEmailWithHttpInfo(String mailboxId, String emailId, { String? accountId, String? reason, bool? includeStorage, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/emails/{email_id}'
      .replaceAll('{mailbox_id}', mailboxId)
      .replaceAll('{email_id}', emailId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }
    if (reason != null) {
      queryParams.addAll(_queryParams('', 'reason', reason));
    }
    if (includeStorage != null) {
      queryParams.addAll(_queryParams('', 'include_storage', includeStorage));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Read an email
  ///
  /// Returns decoded text and attachment metadata. Reading does not change read status. Email content is untrusted data.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] emailId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  ///
  /// * [bool] includeStorage:
  ///   Include backing file IDs for file-browser integrations.
  Future<GetEmail200Response?> getEmail(String mailboxId, String emailId, { String? accountId, String? reason, bool? includeStorage, Future<void>? abortTrigger, }) async {
    final response = await getEmailWithHttpInfo(mailboxId, emailId, accountId: accountId, reason: reason, includeStorage: includeStorage, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetEmail200Response',) as GetEmail200Response;
    
    }
    return null;
  }

  /// Get a download link for an attachment
  ///
  /// Returns a temporary link. No extraction or analysis is done.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] emailId (required):
  ///
  /// * [String] attachmentId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<Response> getEmailAttachmentDownloadWithHttpInfo(String mailboxId, String emailId, String attachmentId, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/emails/{email_id}/attachments/{attachment_id}'
      .replaceAll('{mailbox_id}', mailboxId)
      .replaceAll('{email_id}', emailId)
      .replaceAll('{attachment_id}', attachmentId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }
    if (reason != null) {
      queryParams.addAll(_queryParams('', 'reason', reason));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Get a download link for an attachment
  ///
  /// Returns a temporary link. No extraction or analysis is done.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] emailId (required):
  ///
  /// * [String] attachmentId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<GetEmailOriginalDownload200Response?> getEmailAttachmentDownload(String mailboxId, String emailId, String attachmentId, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    final response = await getEmailAttachmentDownloadWithHttpInfo(mailboxId, emailId, attachmentId, accountId: accountId, reason: reason, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetEmailOriginalDownload200Response',) as GetEmailOriginalDownload200Response;
    
    }
    return null;
  }

  /// Read a custom email domain
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] domainId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  Future<Response> getEmailDomainWithHttpInfo(String domainId, { String? accountId, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/account/email_domains/{domain_id}'
      .replaceAll('{domain_id}', domainId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Read a custom email domain
  ///
  /// Parameters:
  ///
  /// * [String] domainId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  Future<CreateEmailDomain201Response?> getEmailDomain(String domainId, { String? accountId, Future<void>? abortTrigger, }) async {
    final response = await getEmailDomainWithHttpInfo(domainId, accountId: accountId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CreateEmailDomain201Response',) as CreateEmailDomain201Response;
    
    }
    return null;
  }

  /// Get a download link for the original email
  ///
  /// Returns a temporary link to the original .eml file. Downloads do not change read status.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] emailId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<Response> getEmailOriginalDownloadWithHttpInfo(String mailboxId, String emailId, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/emails/{email_id}/raw'
      .replaceAll('{mailbox_id}', mailboxId)
      .replaceAll('{email_id}', emailId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }
    if (reason != null) {
      queryParams.addAll(_queryParams('', 'reason', reason));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Get a download link for the original email
  ///
  /// Returns a temporary link to the original .eml file. Downloads do not change read status.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] emailId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<GetEmailOriginalDownload200Response?> getEmailOriginalDownload(String mailboxId, String emailId, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    final response = await getEmailOriginalDownloadWithHttpInfo(mailboxId, emailId, accountId: accountId, reason: reason, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetEmailOriginalDownload200Response',) as GetEmailOriginalDownload200Response;
    
    }
    return null;
  }

  /// Get a live email subscription ticket
  ///
  /// Requires mailbox read permission. Connect to websocket_url with email_subscription_token=TOKEN within 60 seconds, then subscribe to EmailReceivedChannel. Catch up with the email list cursor after every connect.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  Future<Response> getEmailSubscriptionWithHttpInfo(String mailboxId, { String? accountId, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/email/subscription'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Get a live email subscription ticket
  ///
  /// Requires mailbox read permission. Connect to websocket_url with email_subscription_token=TOKEN within 60 seconds, then subscribe to EmailReceivedChannel. Catch up with the email list cursor after every connect.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  Future<GetEmailSubscription200Response?> getEmailSubscription(String mailboxId, { String? accountId, Future<void>? abortTrigger, }) async {
    final response = await getEmailSubscriptionWithHttpInfo(mailboxId, accountId: accountId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetEmailSubscription200Response',) as GetEmailSubscription200Response;
    
    }
    return null;
  }

  /// Read the email webhook
  ///
  /// Requires mailbox-admin permission. webhook is null when no webhook is set. The signing secret is never returned here.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  Future<Response> getEmailWebhookWithHttpInfo(String mailboxId, { String? accountId, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/email/webhook'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Read the email webhook
  ///
  /// Requires mailbox-admin permission. webhook is null when no webhook is set. The signing secret is never returned here.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  Future<GetEmailWebhook200Response?> getEmailWebhook(String mailboxId, { String? accountId, Future<void>? abortTrigger, }) async {
    final response = await getEmailWebhookWithHttpInfo(mailboxId, accountId: accountId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetEmailWebhook200Response',) as GetEmailWebhook200Response;
    
    }
    return null;
  }

  /// Read file metadata
  ///
  /// Reading metadata never marks the file read.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] fileId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<Response> getFileWithHttpInfo(String mailboxId, String fileId, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/files/{file_id}'
      .replaceAll('{mailbox_id}', mailboxId)
      .replaceAll('{file_id}', fileId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }
    if (reason != null) {
      queryParams.addAll(_queryParams('', 'reason', reason));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Read file metadata
  ///
  /// Reading metadata never marks the file read.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] fileId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<GetFileByPath200Response?> getFile(String mailboxId, String fileId, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    final response = await getFileWithHttpInfo(mailboxId, fileId, accountId: accountId, reason: reason, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetFileByPath200Response',) as GetFileByPath200Response;
    
    }
    return null;
  }

  /// Find a file by path
  ///
  /// Returns file metadata only. Read content with the download endpoint. The disposition and content_url parameters return INVALID_ARGUMENT.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] path (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<Response> getFileByPathWithHttpInfo(String mailboxId, String path, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/files/by_path'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'path', path));
    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }
    if (reason != null) {
      queryParams.addAll(_queryParams('', 'reason', reason));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Find a file by path
  ///
  /// Returns file metadata only. Read content with the download endpoint. The disposition and content_url parameters return INVALID_ARGUMENT.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] path (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<GetFileByPath200Response?> getFileByPath(String mailboxId, String path, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    final response = await getFileByPathWithHttpInfo(mailboxId, path, accountId: accountId, reason: reason, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetFileByPath200Response',) as GetFileByPath200Response;
    
    }
    return null;
  }

  /// Get a download link for a file
  ///
  /// Returns a temporary link and marks this version read. Send version_id for an older version.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] fileId (required):
  ///
  /// * [String] versionId:
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<Response> getFileDownloadWithHttpInfo(String mailboxId, String fileId, { String? versionId, String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/files/{file_id}/download'
      .replaceAll('{mailbox_id}', mailboxId)
      .replaceAll('{file_id}', fileId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (versionId != null) {
      queryParams.addAll(_queryParams('', 'version_id', versionId));
    }
    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }
    if (reason != null) {
      queryParams.addAll(_queryParams('', 'reason', reason));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Get a download link for a file
  ///
  /// Returns a temporary link and marks this version read. Send version_id for an older version.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] fileId (required):
  ///
  /// * [String] versionId:
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<GetFileDownload200Response?> getFileDownload(String mailboxId, String fileId, { String? versionId, String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    final response = await getFileDownloadWithHttpInfo(mailboxId, fileId, versionId: versionId, accountId: accountId, reason: reason, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetFileDownload200Response',) as GetFileDownload200Response;
    
    }
    return null;
  }

  /// Read a mailbox
  ///
  /// Reading never changes the mailbox. Read address settings, emails and files through their own endpoints.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<Response> getMailboxWithHttpInfo(String mailboxId, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }
    if (reason != null) {
      queryParams.addAll(_queryParams('', 'reason', reason));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Read a mailbox
  ///
  /// Reading never changes the mailbox. Read address settings, emails and files through their own endpoints.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<CreateMailbox201Response?> getMailbox(String mailboxId, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    final response = await getMailboxWithHttpInfo(mailboxId, accountId: accountId, reason: reason, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CreateMailbox201Response',) as CreateMailbox201Response;
    
    }
    return null;
  }

  /// Read address settings
  ///
  /// Requires mailbox write permission.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<Response> getMailboxEmailSettingsWithHttpInfo(String mailboxId, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/email'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }
    if (reason != null) {
      queryParams.addAll(_queryParams('', 'reason', reason));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Read address settings
  ///
  /// Requires mailbox write permission.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<GetMailboxEmailSettings200Response?> getMailboxEmailSettings(String mailboxId, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    final response = await getMailboxEmailSettingsWithHttpInfo(mailboxId, accountId: accountId, reason: reason, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetMailboxEmailSettings200Response',) as GetMailboxEmailSettings200Response;
    
    }
    return null;
  }

  /// Read the connection and selected account
  ///
  /// Works with every API key, including mailbox-scoped keys. Read quotas with GET /v1/account/limits.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<Response> getStatusWithHttpInfo({ String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/status';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }
    if (reason != null) {
      queryParams.addAll(_queryParams('', 'reason', reason));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Read the connection and selected account
  ///
  /// Works with every API key, including mailbox-scoped keys. Read quotas with GET /v1/account/limits.
  ///
  /// Parameters:
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  Future<GetStatus200Response?> getStatus({ String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    final response = await getStatusWithHttpInfo(accountId: accountId, reason: reason, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetStatus200Response',) as GetStatus200Response;
    
    }
    return null;
  }

  /// List accounts granted to this credential
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] limit:
  ///
  /// * [String] cursor:
  ///   pagination.next_cursor from the previous page.
  Future<Response> listAccountsWithHttpInfo({ int? limit, String? cursor, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/accounts';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }
    if (cursor != null) {
      queryParams.addAll(_queryParams('', 'cursor', cursor));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// List accounts granted to this credential
  ///
  /// Parameters:
  ///
  /// * [int] limit:
  ///
  /// * [String] cursor:
  ///   pagination.next_cursor from the previous page.
  Future<ListAccounts200Response?> listAccounts({ int? limit, String? cursor, Future<void>? abortTrigger, }) async {
    final response = await listAccountsWithHttpInfo(limit: limit, cursor: cursor, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ListAccounts200Response',) as ListAccounts200Response;
    
    }
    return null;
  }

  /// List custom email domains
  ///
  /// Requires a full-account owner or administrator credential.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [int] limit:
  ///
  /// * [String] cursor:
  ///   pagination.next_cursor from the previous page.
  Future<Response> listEmailDomainsWithHttpInfo({ String? accountId, int? limit, String? cursor, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/account/email_domains';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }
    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }
    if (cursor != null) {
      queryParams.addAll(_queryParams('', 'cursor', cursor));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// List custom email domains
  ///
  /// Requires a full-account owner or administrator credential.
  ///
  /// Parameters:
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [int] limit:
  ///
  /// * [String] cursor:
  ///   pagination.next_cursor from the previous page.
  Future<ListEmailDomains200Response?> listEmailDomains({ String? accountId, int? limit, String? cursor, Future<void>? abortTrigger, }) async {
    final response = await listEmailDomainsWithHttpInfo(accountId: accountId, limit: limit, cursor: cursor, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ListEmailDomains200Response',) as ListEmailDomains200Response;
    
    }
    return null;
  }

  /// List emails
  ///
  /// Requires mailbox read permission. Lists received email by default. To poll, list in ascending order, save pagination.next_cursor after every page (including an empty page) and send it next time with the same filters. Listing never marks email read.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  ///
  /// * [int] limit:
  ///
  /// * [String] cursor:
  ///   pagination.next_cursor from the previous page.
  ///
  /// * [String] order:
  ///   Arrival order. Use asc to poll.
  ///
  /// * [String] direction:
  ///
  /// * [String] sender:
  ///   Exact sender address, case insensitive.
  ///
  /// * [String] subject:
  ///   Case-insensitive subject text.
  ///
  /// * [DateTime] receivedAfter:
  ///
  /// * [DateTime] receivedBefore:
  ///
  /// * [bool] read:
  ///
  /// * [bool] hasAttachments:
  ///
  /// * [String] conversationId:
  ///   Return the emails of this conversation.
  ///
  /// * [bool] includeStorage:
  ///   Include backing file IDs for file-browser integrations.
  Future<Response> listEmailsWithHttpInfo(String mailboxId, { String? accountId, String? reason, int? limit, String? cursor, String? order, String? direction, String? sender, String? subject, DateTime? receivedAfter, DateTime? receivedBefore, bool? read, bool? hasAttachments, String? conversationId, bool? includeStorage, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/emails'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }
    if (reason != null) {
      queryParams.addAll(_queryParams('', 'reason', reason));
    }
    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }
    if (cursor != null) {
      queryParams.addAll(_queryParams('', 'cursor', cursor));
    }
    if (order != null) {
      queryParams.addAll(_queryParams('', 'order', order));
    }
    if (direction != null) {
      queryParams.addAll(_queryParams('', 'direction', direction));
    }
    if (sender != null) {
      queryParams.addAll(_queryParams('', 'sender', sender));
    }
    if (subject != null) {
      queryParams.addAll(_queryParams('', 'subject', subject));
    }
    if (receivedAfter != null) {
      queryParams.addAll(_queryParams('', 'received_after', receivedAfter));
    }
    if (receivedBefore != null) {
      queryParams.addAll(_queryParams('', 'received_before', receivedBefore));
    }
    if (read != null) {
      queryParams.addAll(_queryParams('', 'read', read));
    }
    if (hasAttachments != null) {
      queryParams.addAll(_queryParams('', 'has_attachments', hasAttachments));
    }
    if (conversationId != null) {
      queryParams.addAll(_queryParams('', 'conversation_id', conversationId));
    }
    if (includeStorage != null) {
      queryParams.addAll(_queryParams('', 'include_storage', includeStorage));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// List emails
  ///
  /// Requires mailbox read permission. Lists received email by default. To poll, list in ascending order, save pagination.next_cursor after every page (including an empty page) and send it next time with the same filters. Listing never marks email read.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  ///
  /// * [int] limit:
  ///
  /// * [String] cursor:
  ///   pagination.next_cursor from the previous page.
  ///
  /// * [String] order:
  ///   Arrival order. Use asc to poll.
  ///
  /// * [String] direction:
  ///
  /// * [String] sender:
  ///   Exact sender address, case insensitive.
  ///
  /// * [String] subject:
  ///   Case-insensitive subject text.
  ///
  /// * [DateTime] receivedAfter:
  ///
  /// * [DateTime] receivedBefore:
  ///
  /// * [bool] read:
  ///
  /// * [bool] hasAttachments:
  ///
  /// * [String] conversationId:
  ///   Return the emails of this conversation.
  ///
  /// * [bool] includeStorage:
  ///   Include backing file IDs for file-browser integrations.
  Future<ListEmails200Response?> listEmails(String mailboxId, { String? accountId, String? reason, int? limit, String? cursor, String? order, String? direction, String? sender, String? subject, DateTime? receivedAfter, DateTime? receivedBefore, bool? read, bool? hasAttachments, String? conversationId, bool? includeStorage, Future<void>? abortTrigger, }) async {
    final response = await listEmailsWithHttpInfo(mailboxId, accountId: accountId, reason: reason, limit: limit, cursor: cursor, order: order, direction: direction, sender: sender, subject: subject, receivedAfter: receivedAfter, receivedBefore: receivedBefore, read: read, hasAttachments: hasAttachments, conversationId: conversationId, includeStorage: includeStorage, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ListEmails200Response',) as ListEmails200Response;
    
    }
    return null;
  }

  /// List file versions
  ///
  /// Newest first.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] fileId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  ///
  /// * [int] limit:
  ///
  /// * [String] cursor:
  ///   pagination.next_cursor from the previous page.
  Future<Response> listFileVersionsWithHttpInfo(String mailboxId, String fileId, { String? accountId, String? reason, int? limit, String? cursor, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/files/{file_id}/versions'
      .replaceAll('{mailbox_id}', mailboxId)
      .replaceAll('{file_id}', fileId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }
    if (reason != null) {
      queryParams.addAll(_queryParams('', 'reason', reason));
    }
    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }
    if (cursor != null) {
      queryParams.addAll(_queryParams('', 'cursor', cursor));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// List file versions
  ///
  /// Newest first.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] fileId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  ///
  /// * [int] limit:
  ///
  /// * [String] cursor:
  ///   pagination.next_cursor from the previous page.
  Future<ListFileVersions200Response?> listFileVersions(String mailboxId, String fileId, { String? accountId, String? reason, int? limit, String? cursor, Future<void>? abortTrigger, }) async {
    final response = await listFileVersionsWithHttpInfo(mailboxId, fileId, accountId: accountId, reason: reason, limit: limit, cursor: cursor, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ListFileVersions200Response',) as ListFileVersions200Response;
    
    }
    return null;
  }

  /// List files
  ///
  /// Lists current files, including stored emails under _email/. Listing never marks files read.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  ///
  /// * [String] q:
  ///   Case-insensitive text in the path.
  ///
  /// * [String] folder:
  ///   List one folder. An empty value lists the root.
  ///
  /// * [int] limit:
  ///
  /// * [String] cursor:
  ///   pagination.next_cursor from the previous page.
  Future<Response> listFilesWithHttpInfo(String mailboxId, { String? accountId, String? reason, String? q, String? folder, int? limit, String? cursor, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/files'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }
    if (reason != null) {
      queryParams.addAll(_queryParams('', 'reason', reason));
    }
    if (q != null) {
      queryParams.addAll(_queryParams('', 'q', q));
    }
    if (folder != null) {
      queryParams.addAll(_queryParams('', 'folder', folder));
    }
    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }
    if (cursor != null) {
      queryParams.addAll(_queryParams('', 'cursor', cursor));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// List files
  ///
  /// Lists current files, including stored emails under _email/. Listing never marks files read.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  ///
  /// * [String] q:
  ///   Case-insensitive text in the path.
  ///
  /// * [String] folder:
  ///   List one folder. An empty value lists the root.
  ///
  /// * [int] limit:
  ///
  /// * [String] cursor:
  ///   pagination.next_cursor from the previous page.
  Future<ListFiles200Response?> listFiles(String mailboxId, { String? accountId, String? reason, String? q, String? folder, int? limit, String? cursor, Future<void>? abortTrigger, }) async {
    final response = await listFilesWithHttpInfo(mailboxId, accountId: accountId, reason: reason, q: q, folder: folder, limit: limit, cursor: cursor, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ListFiles200Response',) as ListFiles200Response;
    
    }
    return null;
  }

  /// List mailboxes
  ///
  /// Lists active mailboxes by default, newest first. Counts and pages cover only mailboxes this credential can access. Reads no email content.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  ///
  /// * [String] status:
  ///
  /// * [String] q:
  ///   Case-insensitive text in the permitted address or the mailbox ID.
  ///
  /// * [int] limit:
  ///
  /// * [String] cursor:
  ///   pagination.next_cursor from the previous page.
  Future<Response> listMailboxesWithHttpInfo({ String? accountId, String? reason, String? status, String? q, int? limit, String? cursor, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }
    if (reason != null) {
      queryParams.addAll(_queryParams('', 'reason', reason));
    }
    if (status != null) {
      queryParams.addAll(_queryParams('', 'status', status));
    }
    if (q != null) {
      queryParams.addAll(_queryParams('', 'q', q));
    }
    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }
    if (cursor != null) {
      queryParams.addAll(_queryParams('', 'cursor', cursor));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// List mailboxes
  ///
  /// Lists active mailboxes by default, newest first. Counts and pages cover only mailboxes this credential can access. Reads no email content.
  ///
  /// Parameters:
  ///
  /// * [String] accountId:
  ///   Select another granted account for this request. Omit to use the credential default. In JSON bodies, send account_id as a body field instead.
  ///
  /// * [String] reason:
  ///
  /// * [String] status:
  ///
  /// * [String] q:
  ///   Case-insensitive text in the permitted address or the mailbox ID.
  ///
  /// * [int] limit:
  ///
  /// * [String] cursor:
  ///   pagination.next_cursor from the previous page.
  Future<ListMailboxes200Response?> listMailboxes({ String? accountId, String? reason, String? status, String? q, int? limit, String? cursor, Future<void>? abortTrigger, }) async {
    final response = await listMailboxesWithHttpInfo(accountId: accountId, reason: reason, status: status, q: q, limit: limit, cursor: cursor, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ListMailboxes200Response',) as ListMailboxes200Response;
    
    }
    return null;
  }

  /// Move a file
  ///
  /// Works in the same mailbox or into target_mailbox_id. Content is not uploaded again. Send target_path for an exact path or target_folder to keep the name.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] fileId (required):
  ///
  /// * [MoveFileRequest] moveFileRequest (required):
  Future<Response> moveFileWithHttpInfo(String mailboxId, String fileId, MoveFileRequest moveFileRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/files/{file_id}/move'
      .replaceAll('{mailbox_id}', mailboxId)
      .replaceAll('{file_id}', fileId);

    // ignore: prefer_final_locals
    Object? postBody = moveFileRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Move a file
  ///
  /// Works in the same mailbox or into target_mailbox_id. Content is not uploaded again. Send target_path for an exact path or target_folder to keep the name.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] fileId (required):
  ///
  /// * [MoveFileRequest] moveFileRequest (required):
  Future<RenameFile200Response?> moveFile(String mailboxId, String fileId, MoveFileRequest moveFileRequest, { Future<void>? abortTrigger, }) async {
    final response = await moveFileWithHttpInfo(mailboxId, fileId, moveFileRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'RenameFile200Response',) as RenameFile200Response;
    
    }
    return null;
  }

  /// Prepare a file upload (step 1 of 3)
  ///
  /// Returns a storage URL. Then PUT the bytes to direct_upload.url with exactly direct_upload.headers and no API key (step 2), and save the file with POST /v1/mailboxes/{mailbox_id}/files (step 3). Identical content at the same path returns skipped=true and duplicate=true without an upload.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PrepareFileUploadRequest] prepareFileUploadRequest (required):
  Future<Response> prepareFileUploadWithHttpInfo(PrepareFileUploadRequest prepareFileUploadRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/direct_uploads';

    // ignore: prefer_final_locals
    Object? postBody = prepareFileUploadRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Prepare a file upload (step 1 of 3)
  ///
  /// Returns a storage URL. Then PUT the bytes to direct_upload.url with exactly direct_upload.headers and no API key (step 2), and save the file with POST /v1/mailboxes/{mailbox_id}/files (step 3). Identical content at the same path returns skipped=true and duplicate=true without an upload.
  ///
  /// Parameters:
  ///
  /// * [PrepareFileUploadRequest] prepareFileUploadRequest (required):
  Future<PrepareFileUpload201Response?> prepareFileUpload(PrepareFileUploadRequest prepareFileUploadRequest, { Future<void>? abortTrigger, }) async {
    final response = await prepareFileUploadWithHttpInfo(prepareFileUploadRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PrepareFileUpload201Response',) as PrepareFileUpload201Response;
    
    }
    return null;
  }

  /// Rename or move a file in the same mailbox
  ///
  /// Changes the path without uploading the content again.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] fileId (required):
  ///
  /// * [RenameFileRequest] renameFileRequest (required):
  Future<Response> renameFileWithHttpInfo(String mailboxId, String fileId, RenameFileRequest renameFileRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/files/{file_id}/rename'
      .replaceAll('{mailbox_id}', mailboxId)
      .replaceAll('{file_id}', fileId);

    // ignore: prefer_final_locals
    Object? postBody = renameFileRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Rename or move a file in the same mailbox
  ///
  /// Changes the path without uploading the content again.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] fileId (required):
  ///
  /// * [RenameFileRequest] renameFileRequest (required):
  Future<RenameFile200Response?> renameFile(String mailboxId, String fileId, RenameFileRequest renameFileRequest, { Future<void>? abortTrigger, }) async {
    final response = await renameFileWithHttpInfo(mailboxId, fileId, renameFileRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'RenameFile200Response',) as RenameFile200Response;
    
    }
    return null;
  }

  /// Email a sign-in code
  ///
  /// Sends a six-digit code to an existing account email. The response is the same for every address, so it never reveals whether an account exists. Create new accounts in the browser at https://app.revdoku.com/users/sign_up.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [RequestSignInCodeRequest] requestSignInCodeRequest (required):
  Future<Response> requestSignInCodeWithHttpInfo(RequestSignInCodeRequest requestSignInCodeRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/agent_auth/request_code';

    // ignore: prefer_final_locals
    Object? postBody = requestSignInCodeRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Email a sign-in code
  ///
  /// Sends a six-digit code to an existing account email. The response is the same for every address, so it never reveals whether an account exists. Create new accounts in the browser at https://app.revdoku.com/users/sign_up.
  ///
  /// Parameters:
  ///
  /// * [RequestSignInCodeRequest] requestSignInCodeRequest (required):
  Future<RequestSignInCode200Response?> requestSignInCode(RequestSignInCodeRequest requestSignInCodeRequest, { Future<void>? abortTrigger, }) async {
    final response = await requestSignInCodeWithHttpInfo(requestSignInCodeRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'RequestSignInCode200Response',) as RequestSignInCode200Response;
    
    }
    return null;
  }

  /// Restore a file version
  ///
  /// Creates a new current version with the content of the selected version. History is kept. Requires a plan with version restore.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] fileId (required):
  ///
  /// * [String] versionId (required):
  ///
  /// * [ActionRequest] actionRequest (required):
  Future<Response> restoreFileVersionWithHttpInfo(String mailboxId, String fileId, String versionId, ActionRequest actionRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/files/{file_id}/versions/{version_id}/restore'
      .replaceAll('{mailbox_id}', mailboxId)
      .replaceAll('{file_id}', fileId)
      .replaceAll('{version_id}', versionId);

    // ignore: prefer_final_locals
    Object? postBody = actionRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Restore a file version
  ///
  /// Creates a new current version with the content of the selected version. History is kept. Requires a plan with version restore.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] fileId (required):
  ///
  /// * [String] versionId (required):
  ///
  /// * [ActionRequest] actionRequest (required):
  Future<RestoreFileVersion201Response?> restoreFileVersion(String mailboxId, String fileId, String versionId, ActionRequest actionRequest, { Future<void>? abortTrigger, }) async {
    final response = await restoreFileVersionWithHttpInfo(mailboxId, fileId, versionId, actionRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'RestoreFileVersion201Response',) as RestoreFileVersion201Response;
    
    }
    return null;
  }

  /// Save uploaded files
  ///
  /// Saves up to limit files whose bytes were uploaded. Call it after each batch to keep each request short. DIRECT_UPLOAD_NOT_FOUND names a file whose bytes are missing in error.details.path; upload it again and retry.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] sessionId (required):
  ///   mailbox_upload_session.id from the create response.
  ///
  /// * [SaveUploadSessionBatchRequest] saveUploadSessionBatchRequest:
  Future<Response> saveUploadSessionBatchWithHttpInfo(String mailboxId, String sessionId, { SaveUploadSessionBatchRequest? saveUploadSessionBatchRequest, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/upload_sessions/{session_id}/finalize_batch'
      .replaceAll('{mailbox_id}', mailboxId)
      .replaceAll('{session_id}', sessionId);

    // ignore: prefer_final_locals
    Object? postBody = saveUploadSessionBatchRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Save uploaded files
  ///
  /// Saves up to limit files whose bytes were uploaded. Call it after each batch to keep each request short. DIRECT_UPLOAD_NOT_FOUND names a file whose bytes are missing in error.details.path; upload it again and retry.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] sessionId (required):
  ///   mailbox_upload_session.id from the create response.
  ///
  /// * [SaveUploadSessionBatchRequest] saveUploadSessionBatchRequest:
  Future<CreateUploadSession201Response?> saveUploadSessionBatch(String mailboxId, String sessionId, { SaveUploadSessionBatchRequest? saveUploadSessionBatchRequest, Future<void>? abortTrigger, }) async {
    final response = await saveUploadSessionBatchWithHttpInfo(mailboxId, sessionId, saveUploadSessionBatchRequest: saveUploadSessionBatchRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CreateUploadSession201Response',) as CreateUploadSession201Response;
    
    }
    return null;
  }

  /// Save an uploaded file (step 3 of 3)
  ///
  /// Saves the uploaded blob at path. An existing path gets a new version.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [SaveUploadedFileRequest] saveUploadedFileRequest (required):
  Future<Response> saveUploadedFileWithHttpInfo(String mailboxId, SaveUploadedFileRequest saveUploadedFileRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/files'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody = saveUploadedFileRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Save an uploaded file (step 3 of 3)
  ///
  /// Saves the uploaded blob at path. An existing path gets a new version.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [SaveUploadedFileRequest] saveUploadedFileRequest (required):
  Future<SaveUploadedFile201Response?> saveUploadedFile(String mailboxId, SaveUploadedFileRequest saveUploadedFileRequest, { Future<void>? abortTrigger, }) async {
    final response = await saveUploadedFileWithHttpInfo(mailboxId, saveUploadedFileRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SaveUploadedFile201Response',) as SaveUploadedFile201Response;
    
    }
    return null;
  }

  /// Send a reply
  ///
  /// Requires mailbox write permission. Recipients must have emailed this mailbox and passed sender authentication. Set in_reply_to to reply. Delivery is asynchronous: read delivery.status later. After an unknown result, list direction=sent before you send again.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [SendEmailRequest] sendEmailRequest (required):
  Future<Response> sendEmailWithHttpInfo(String mailboxId, SendEmailRequest sendEmailRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/emails'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody = sendEmailRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Send a reply
  ///
  /// Requires mailbox write permission. Recipients must have emailed this mailbox and passed sender authentication. Set in_reply_to to reply. Delivery is asynchronous: read delivery.status later. After an unknown result, list direction=sent before you send again.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [SendEmailRequest] sendEmailRequest (required):
  Future<SendEmail202Response?> sendEmail(String mailboxId, SendEmailRequest sendEmailRequest, { Future<void>? abortTrigger, }) async {
    final response = await sendEmailWithHttpInfo(mailboxId, sendEmailRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SendEmail202Response',) as SendEmail202Response;
    
    }
    return null;
  }

  /// Set the email webhook
  ///
  /// Requires mailbox-admin permission and a public HTTPS URL. A new URL or rotate_secret=true creates a new signing secret, returns it once and cancels pending deliveries. The same URL without rotate_secret returns the webhook without a secret.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [SetEmailWebhookRequest] setEmailWebhookRequest (required):
  Future<Response> setEmailWebhookWithHttpInfo(String mailboxId, SetEmailWebhookRequest setEmailWebhookRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/email/webhook'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody = setEmailWebhookRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Set the email webhook
  ///
  /// Requires mailbox-admin permission and a public HTTPS URL. A new URL or rotate_secret=true creates a new signing secret, returns it once and cancels pending deliveries. The same URL without rotate_secret returns the webhook without a secret.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [SetEmailWebhookRequest] setEmailWebhookRequest (required):
  Future<SetEmailWebhook200Response?> setEmailWebhook(String mailboxId, SetEmailWebhookRequest setEmailWebhookRequest, { Future<void>? abortTrigger, }) async {
    final response = await setEmailWebhookWithHttpInfo(mailboxId, setEmailWebhookRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SetEmailWebhook200Response',) as SetEmailWebhook200Response;
    
    }
    return null;
  }

  /// Unarchive a mailbox
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [ActionRequest] actionRequest (required):
  Future<Response> unarchiveMailboxWithHttpInfo(String mailboxId, ActionRequest actionRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/unarchive'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody = actionRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Unarchive a mailbox
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [ActionRequest] actionRequest (required):
  Future<CreateMailbox201Response?> unarchiveMailbox(String mailboxId, ActionRequest actionRequest, { Future<void>? abortTrigger, }) async {
    final response = await unarchiveMailboxWithHttpInfo(mailboxId, actionRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CreateMailbox201Response',) as CreateMailbox201Response;
    
    }
    return null;
  }

  /// Mark an email read or unread
  ///
  /// Only read status can change.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] emailId (required):
  ///
  /// * [UpdateEmailRequest] updateEmailRequest (required):
  ///
  /// * [bool] includeStorage:
  ///   Include backing file IDs for file-browser integrations.
  Future<Response> updateEmailWithHttpInfo(String mailboxId, String emailId, UpdateEmailRequest updateEmailRequest, { bool? includeStorage, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/emails/{email_id}'
      .replaceAll('{mailbox_id}', mailboxId)
      .replaceAll('{email_id}', emailId);

    // ignore: prefer_final_locals
    Object? postBody = updateEmailRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (includeStorage != null) {
      queryParams.addAll(_queryParams('', 'include_storage', includeStorage));
    }

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PATCH',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Mark an email read or unread
  ///
  /// Only read status can change.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] emailId (required):
  ///
  /// * [UpdateEmailRequest] updateEmailRequest (required):
  ///
  /// * [bool] includeStorage:
  ///   Include backing file IDs for file-browser integrations.
  Future<SendEmail202Response?> updateEmail(String mailboxId, String emailId, UpdateEmailRequest updateEmailRequest, { bool? includeStorage, Future<void>? abortTrigger, }) async {
    final response = await updateEmailWithHttpInfo(mailboxId, emailId, updateEmailRequest, includeStorage: includeStorage, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SendEmail202Response',) as SendEmail202Response;
    
    }
    return null;
  }

  /// Replace the allowed senders
  ///
  /// Requires an account owner or administrator with mailbox-admin permission. Send sender_allowlist.version from the settings read as expected_version.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [UpdateEmailAllowlistRequest] updateEmailAllowlistRequest (required):
  Future<Response> updateEmailAllowlistWithHttpInfo(String mailboxId, UpdateEmailAllowlistRequest updateEmailAllowlistRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/email/allowlist'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody = updateEmailAllowlistRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PATCH',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Replace the allowed senders
  ///
  /// Requires an account owner or administrator with mailbox-admin permission. Send sender_allowlist.version from the settings read as expected_version.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [UpdateEmailAllowlistRequest] updateEmailAllowlistRequest (required):
  Future<UpdateEmailAllowlist200Response?> updateEmailAllowlist(String mailboxId, UpdateEmailAllowlistRequest updateEmailAllowlistRequest, { Future<void>? abortTrigger, }) async {
    final response = await updateEmailAllowlistWithHttpInfo(mailboxId, updateEmailAllowlistRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UpdateEmailAllowlist200Response',) as UpdateEmailAllowlist200Response;
    
    }
    return null;
  }

  /// Update a mailbox description or metadata
  ///
  /// metadata must be a JSON object. It replaces the stored object; {} clears it. Send expected_metadata_version from your last read; a stale value changes nothing and returns MAILBOX_METADATA_CONFLICT.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [UpdateMailboxRequest] updateMailboxRequest (required):
  Future<Response> updateMailboxWithHttpInfo(String mailboxId, UpdateMailboxRequest updateMailboxRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}'
      .replaceAll('{mailbox_id}', mailboxId);

    // ignore: prefer_final_locals
    Object? postBody = updateMailboxRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PATCH',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Update a mailbox description or metadata
  ///
  /// metadata must be a JSON object. It replaces the stored object; {} clears it. Send expected_metadata_version from your last read; a stale value changes nothing and returns MAILBOX_METADATA_CONFLICT.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [UpdateMailboxRequest] updateMailboxRequest (required):
  Future<CreateMailbox201Response?> updateMailbox(String mailboxId, UpdateMailboxRequest updateMailboxRequest, { Future<void>? abortTrigger, }) async {
    final response = await updateMailboxWithHttpInfo(mailboxId, updateMailboxRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CreateMailbox201Response',) as CreateMailbox201Response;
    
    }
    return null;
  }

  /// Check DNS and provider setup again
  ///
  /// Queues the check and returns the current state. Read the domain again to see the result.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] domainId (required):
  ///
  /// * [VerifyEmailDomainRequest] verifyEmailDomainRequest (required):
  Future<Response> verifyEmailDomainWithHttpInfo(String domainId, VerifyEmailDomainRequest verifyEmailDomainRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/account/email_domains/{domain_id}/verify'
      .replaceAll('{domain_id}', domainId);

    // ignore: prefer_final_locals
    Object? postBody = verifyEmailDomainRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Check DNS and provider setup again
  ///
  /// Queues the check and returns the current state. Read the domain again to see the result.
  ///
  /// Parameters:
  ///
  /// * [String] domainId (required):
  ///
  /// * [VerifyEmailDomainRequest] verifyEmailDomainRequest (required):
  Future<CreateEmailDomain201Response?> verifyEmailDomain(String domainId, VerifyEmailDomainRequest verifyEmailDomainRequest, { Future<void>? abortTrigger, }) async {
    final response = await verifyEmailDomainWithHttpInfo(domainId, verifyEmailDomainRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CreateEmailDomain201Response',) as CreateEmailDomain201Response;
    
    }
    return null;
  }

  /// Exchange a sign-in code for an API key
  ///
  /// Creates an AI agent connection for an account owner or administrator. Accounts with two-factor authentication must use browser sign-in.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [VerifySignInCodeRequest] verifySignInCodeRequest (required):
  Future<Response> verifySignInCodeWithHttpInfo(VerifySignInCodeRequest verifySignInCodeRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/agent_auth/verify_code';

    // ignore: prefer_final_locals
    Object? postBody = verifySignInCodeRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Exchange a sign-in code for an API key
  ///
  /// Creates an AI agent connection for an account owner or administrator. Accounts with two-factor authentication must use browser sign-in.
  ///
  /// Parameters:
  ///
  /// * [VerifySignInCodeRequest] verifySignInCodeRequest (required):
  Future<VerifySignInCode201Response?> verifySignInCode(VerifySignInCodeRequest verifySignInCodeRequest, { Future<void>? abortTrigger, }) async {
    final response = await verifySignInCodeWithHttpInfo(verifySignInCodeRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'VerifySignInCode201Response',) as VerifySignInCode201Response;
    
    }
    return null;
  }
}
