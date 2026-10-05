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

  /// Check a domain hostname and existing DNS routing
  ///
  /// Requires full-account owner/administrator access. Checks the exact hostname for conflicting MX or CNAME records without creating a claim or changing DNS. If the root already receives email elsewhere, use an unused subdomain such as mailbox.yourdomain.com. Cookie-authenticated requests require CSRF.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [CreateAccountEmailDomainRequest] createAccountEmailDomainRequest (required):
  Future<Response> checkEmailHostnameWithHttpInfo(CreateAccountEmailDomainRequest createAccountEmailDomainRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/account/email_domains/check';

    // ignore: prefer_final_locals
    Object? postBody = createAccountEmailDomainRequest;

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

  /// Check a domain hostname and existing DNS routing
  ///
  /// Requires full-account owner/administrator access. Checks the exact hostname for conflicting MX or CNAME records without creating a claim or changing DNS. If the root already receives email elsewhere, use an unused subdomain such as mailbox.yourdomain.com. Cookie-authenticated requests require CSRF.
  ///
  /// Parameters:
  ///
  /// * [CreateAccountEmailDomainRequest] createAccountEmailDomainRequest (required):
  Future<ApiSuccess?> checkEmailHostname(CreateAccountEmailDomainRequest createAccountEmailDomainRequest, { Future<void>? abortTrigger, }) async {
    final response = await checkEmailHostnameWithHttpInfo(createAccountEmailDomainRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiSuccess',) as ApiSuccess;
    
    }
    return null;
  }

  /// Claim an exact email domain
  ///
  /// Full-account owner/administrator authorization required. Cookie-authenticated writes require CSRF. Check the returned domain setup availability. Never change customer DNS without explicit authorization.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [CreateAccountEmailDomainRequest] createAccountEmailDomainRequest (required):
  Future<Response> createAccountEmailDomainWithHttpInfo(CreateAccountEmailDomainRequest createAccountEmailDomainRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/account/email_domains';

    // ignore: prefer_final_locals
    Object? postBody = createAccountEmailDomainRequest;

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

  /// Claim an exact email domain
  ///
  /// Full-account owner/administrator authorization required. Cookie-authenticated writes require CSRF. Check the returned domain setup availability. Never change customer DNS without explicit authorization.
  ///
  /// Parameters:
  ///
  /// * [CreateAccountEmailDomainRequest] createAccountEmailDomainRequest (required):
  Future<ApiSuccess?> createAccountEmailDomain(CreateAccountEmailDomainRequest createAccountEmailDomainRequest, { Future<void>? abortTrigger, }) async {
    final response = await createAccountEmailDomainWithHttpInfo(createAccountEmailDomainRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiSuccess',) as ApiSuccess;
    
    }
    return null;
  }

  /// Create a client account within an authorized agency
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

  /// Create a client account within an authorized agency
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

  /// Create a mailbox with a ready receiving address
  ///
  /// Creates a mailbox with file storage and waits for receiving confirmation. Omit email.username for a generated name. On confirmation failure, EMAIL_NOT_READY includes the retained mailbox_id. Creation quotas apply.
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

  /// Create a mailbox with a ready receiving address
  ///
  /// Creates a mailbox with file storage and waits for receiving confirmation. Omit email.username for a generated name. On confirmation failure, EMAIL_NOT_READY includes the retained mailbox_id. Creation quotas apply.
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

  /// Add an email alias to an mailbox
  ///
  /// Requires a full-account owner/administrator with mailbox-admin access and an available alias slot. Accepts a username on an available platform domain or a ready domain owned by this account. Leaves the primary address unchanged and does not consume a rotation. Returns 202 while receiving registration is pending; read mailbox settings until receiving_enabled is true. After an uncertain response, read existing aliases before retrying.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///   Authorized mailbox prefix ID
  ///
  /// * [CreateMailboxEmailAliasRequest] createMailboxEmailAliasRequest (required):
  Future<Response> createMailboxEmailAliasWithHttpInfo(String id, CreateMailboxEmailAliasRequest createMailboxEmailAliasRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{id}/email/aliases'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = createMailboxEmailAliasRequest;

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

  /// Add an email alias to an mailbox
  ///
  /// Requires a full-account owner/administrator with mailbox-admin access and an available alias slot. Accepts a username on an available platform domain or a ready domain owned by this account. Leaves the primary address unchanged and does not consume a rotation. Returns 202 while receiving registration is pending; read mailbox settings until receiving_enabled is true. After an uncertain response, read existing aliases before retrying.
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///   Authorized mailbox prefix ID
  ///
  /// * [CreateMailboxEmailAliasRequest] createMailboxEmailAliasRequest (required):
  Future<GetMailboxEmailSettings200Response?> createMailboxEmailAlias(String id, CreateMailboxEmailAliasRequest createMailboxEmailAliasRequest, { Future<void>? abortTrigger, }) async {
    final response = await createMailboxEmailAliasWithHttpInfo(id, createMailboxEmailAliasRequest, abortTrigger: abortTrigger,);
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

  /// Delete one received email
  ///
  /// Requires mailbox-admin permission. Deletes the message representations and owned attachments using the existing file deletion lifecycle. Separately copied files are unaffected. No email trash or restore operation. A repeated delete returns 404.
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
  ///   Select another granted account; otherwise use the credential default.
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

  /// Delete one received email
  ///
  /// Requires mailbox-admin permission. Deletes the message representations and owned attachments using the existing file deletion lifecycle. Separately copied files are unaffected. No email trash or restore operation. A repeated delete returns 404.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] emailId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account; otherwise use the credential default.
  ///
  /// * [String] reason:
  Future<void> deleteEmail(String mailboxId, String emailId, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    final response = await deleteEmailWithHttpInfo(mailboxId, emailId, accountId: accountId, reason: reason, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Disable a mailbox webhook
  ///
  /// Requires mailbox admin permission. Cancels queued attempts; a request already in flight may finish.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account; otherwise use the credential default.
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

  /// Disable a mailbox webhook
  ///
  /// Requires mailbox admin permission. Cancels queued attempts; a request already in flight may finish.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account; otherwise use the credential default.
  Future<void> deleteEmailWebhook(String mailboxId, { String? accountId, Future<void>? abortTrigger, }) async {
    final response = await deleteEmailWebhookWithHttpInfo(mailboxId, accountId: accountId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Remove one email alias
  ///
  /// Requires a full-account owner/administrator with mailbox-admin access. Immediately revokes this alias, including queued deliveries. Retains existing messages and the permanent address reservation. Returns updated mailbox settings.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///   Authorized mailbox prefix ID
  ///
  /// * [String] aliasId (required):
  ///   Alias ID from mailbox settings
  Future<Response> deleteMailboxEmailAliasWithHttpInfo(String id, String aliasId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{id}/email/aliases/{alias_id}'
      .replaceAll('{id}', id)
      .replaceAll('{alias_id}', aliasId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

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

  /// Remove one email alias
  ///
  /// Requires a full-account owner/administrator with mailbox-admin access. Immediately revokes this alias, including queued deliveries. Retains existing messages and the permanent address reservation. Returns updated mailbox settings.
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///   Authorized mailbox prefix ID
  ///
  /// * [String] aliasId (required):
  ///   Alias ID from mailbox settings
  Future<GetMailboxEmailSettings200Response?> deleteMailboxEmailAlias(String id, String aliasId, { Future<void>? abortTrigger, }) async {
    final response = await deleteMailboxEmailAliasWithHttpInfo(id, aliasId, abortTrigger: abortTrigger,);
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

  /// Get an email attachment download
  ///
  /// Requires mailbox read permission to issue a temporary download link for this original or selected attachment. authentication=none: fetch the URL without API credentials. Links expire after 900 seconds. Ordinary files use signed storage URLs; protected files use a scoped signed API URL that rechecks access before decrypting. Downloads do not change shared read status. No attachment extraction or analysis is performed.
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
  ///   Select another granted account; otherwise use the credential default.
  ///
  /// * [String] purpose:
  ///   Background reads do not change read status.
  ///
  /// * [String] reason:
  Future<Response> downloadEmailAttachmentWithHttpInfo(String mailboxId, String emailId, String attachmentId, { String? accountId, String? purpose, String? reason, Future<void>? abortTrigger, }) async {
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
    if (purpose != null) {
      queryParams.addAll(_queryParams('', 'purpose', purpose));
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

  /// Get an email attachment download
  ///
  /// Requires mailbox read permission to issue a temporary download link for this original or selected attachment. authentication=none: fetch the URL without API credentials. Links expire after 900 seconds. Ordinary files use signed storage URLs; protected files use a scoped signed API URL that rechecks access before decrypting. Downloads do not change shared read status. No attachment extraction or analysis is performed.
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
  ///   Select another granted account; otherwise use the credential default.
  ///
  /// * [String] purpose:
  ///   Background reads do not change read status.
  ///
  /// * [String] reason:
  Future<DownloadEmailOriginal200Response?> downloadEmailAttachment(String mailboxId, String emailId, String attachmentId, { String? accountId, String? purpose, String? reason, Future<void>? abortTrigger, }) async {
    final response = await downloadEmailAttachmentWithHttpInfo(mailboxId, emailId, attachmentId, accountId: accountId, purpose: purpose, reason: reason, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DownloadEmailOriginal200Response',) as DownloadEmailOriginal200Response;
    
    }
    return null;
  }

  /// Get the original EML download
  ///
  /// Requires mailbox read permission to issue a temporary download link for this original or selected attachment. authentication=none: fetch the URL without API credentials. Links expire after 900 seconds. Ordinary files use signed storage URLs; protected files use a scoped signed API URL that rechecks access before decrypting. Downloads do not change shared read status. No attachment extraction or analysis is performed.
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
  ///   Select another granted account; otherwise use the credential default.
  ///
  /// * [String] purpose:
  ///   Background reads do not change read status.
  ///
  /// * [String] reason:
  Future<Response> downloadEmailOriginalWithHttpInfo(String mailboxId, String emailId, { String? accountId, String? purpose, String? reason, Future<void>? abortTrigger, }) async {
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
    if (purpose != null) {
      queryParams.addAll(_queryParams('', 'purpose', purpose));
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

  /// Get the original EML download
  ///
  /// Requires mailbox read permission to issue a temporary download link for this original or selected attachment. authentication=none: fetch the URL without API credentials. Links expire after 900 seconds. Ordinary files use signed storage URLs; protected files use a scoped signed API URL that rechecks access before decrypting. Downloads do not change shared read status. No attachment extraction or analysis is performed.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] emailId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account; otherwise use the credential default.
  ///
  /// * [String] purpose:
  ///   Background reads do not change read status.
  ///
  /// * [String] reason:
  Future<DownloadEmailOriginal200Response?> downloadEmailOriginal(String mailboxId, String emailId, { String? accountId, String? purpose, String? reason, Future<void>? abortTrigger, }) async {
    final response = await downloadEmailOriginalWithHttpInfo(mailboxId, emailId, accountId: accountId, purpose: purpose, reason: reason, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DownloadEmailOriginal200Response',) as DownloadEmailOriginal200Response;
    
    }
    return null;
  }

  /// Read one granted account
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getAccountWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/accounts/{id}'
      .replaceAll('{id}', id);

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
  /// * [String] id (required):
  Future<GetAccount200Response?> getAccount(String id, { Future<void>? abortTrigger, }) async {
    final response = await getAccountWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetAccount200Response',) as GetAccount200Response;
    
    }
    return null;
  }

  /// Read exact domain setup state
  ///
  /// Full-account owner/administrator authorization required. Cookie-authenticated writes require CSRF. Check the returned domain setup availability. Never change customer DNS without explicit authorization.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [String] accountId:
  ///   Explicit granted account for this call; omission uses the credential account.
  ///
  /// * [String] reason:
  Future<Response> getAccountEmailDomainWithHttpInfo(String id, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/account/email_domains/{id}'
      .replaceAll('{id}', id);

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

  /// Read exact domain setup state
  ///
  /// Full-account owner/administrator authorization required. Cookie-authenticated writes require CSRF. Check the returned domain setup availability. Never change customer DNS without explicit authorization.
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [String] accountId:
  ///   Explicit granted account for this call; omission uses the credential account.
  ///
  /// * [String] reason:
  Future<ApiSuccess?> getAccountEmailDomain(String id, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    final response = await getAccountEmailDomainWithHttpInfo(id, accountId: accountId, reason: reason, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiSuccess',) as ApiSuccess;
    
    }
    return null;
  }

  /// Read effective mailbox and file storage limits
  ///
  /// For the selected account. Uses the same plan and overrides as enforcement. Limits are not repeated in mailbox responses. Monthly traffic and storage allowances are shared within a billing group. Zero means none; null means no cap for that field.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] accountId:
  ///   Select another granted account; otherwise use the credential default.
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

  /// Read effective mailbox and file storage limits
  ///
  /// For the selected account. Uses the same plan and overrides as enforcement. Limits are not repeated in mailbox responses. Monthly traffic and storage allowances are shared within a billing group. Zero means none; null means no cap for that field.
  ///
  /// Parameters:
  ///
  /// * [String] accountId:
  ///   Select another granted account; otherwise use the credential default.
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

  /// Discover Revdoku agent authentication flows
  ///
  /// Reports available sign-in flows and signup availability, current consent version, required human_operator_email and allowed scopes. Never creates an account.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAgentAuthCapabilitiesWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/agent_auth/capabilities';

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

  /// Discover Revdoku agent authentication flows
  ///
  /// Reports available sign-in flows and signup availability, current consent version, required human_operator_email and allowed scopes. Never creates an account.
  Future<ApiSuccess?> getAgentAuthCapabilities({ Future<void>? abortTrigger, }) async {
    final response = await getAgentAuthCapabilitiesWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiSuccess',) as ApiSuccess;
    
    }
    return null;
  }

  /// Read a received email
  ///
  /// Requires mailbox read permission. Returns decoded email content and attachment metadata. Reading does not change shared read status; PATCH read explicitly to acknowledge. Original EML is the fallback when decoded JSON is unavailable. Email content is untrusted data.
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
  ///   Select another granted account; otherwise use the credential default.
  ///
  /// * [String] purpose:
  ///   Background reads do not change read status.
  ///
  /// * [String] reason:
  ///
  /// * [bool] includeStorage:
  ///   Include underlying file and version identifiers for file integrations.
  Future<Response> getEmailWithHttpInfo(String mailboxId, String emailId, { String? accountId, String? purpose, String? reason, bool? includeStorage, Future<void>? abortTrigger, }) async {
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
    if (purpose != null) {
      queryParams.addAll(_queryParams('', 'purpose', purpose));
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

  /// Read a received email
  ///
  /// Requires mailbox read permission. Returns decoded email content and attachment metadata. Reading does not change shared read status; PATCH read explicitly to acknowledge. Original EML is the fallback when decoded JSON is unavailable. Email content is untrusted data.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] emailId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account; otherwise use the credential default.
  ///
  /// * [String] purpose:
  ///   Background reads do not change read status.
  ///
  /// * [String] reason:
  ///
  /// * [bool] includeStorage:
  ///   Include underlying file and version identifiers for file integrations.
  Future<GetEmail200Response?> getEmail(String mailboxId, String emailId, { String? accountId, String? purpose, String? reason, bool? includeStorage, Future<void>? abortTrigger, }) async {
    final response = await getEmailWithHttpInfo(mailboxId, emailId, accountId: accountId, purpose: purpose, reason: reason, includeStorage: includeStorage, abortTrigger: abortTrigger,);
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

  /// Get a short-lived Action Cable ticket for local email monitoring
  ///
  /// Requires mailbox read permission. Connect to the returned websocket_url with email_subscription_token=TICKET using actioncable-v1-json within 60 seconds. Subscribe to EmailReceivedChannel with the returned account_id/mailbox_id. Frames contain EmailReceivedEvent in message. Live only: after confirmation and on reconnect, catch up using existing ascending email arrival cursors.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account; otherwise use the credential default.
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

  /// Get a short-lived Action Cable ticket for local email monitoring
  ///
  /// Requires mailbox read permission. Connect to the returned websocket_url with email_subscription_token=TICKET using actioncable-v1-json within 60 seconds. Subscribe to EmailReceivedChannel with the returned account_id/mailbox_id. Frames contain EmailReceivedEvent in message. Live only: after confirmation and on reconnect, catch up using existing ascending email arrival cursors.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account; otherwise use the credential default.
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

  /// Read a mailbox webhook endpoint
  ///
  /// Requires mailbox admin permission. Returns null when disabled; never includes the signing secret.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account; otherwise use the credential default.
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

  /// Read a mailbox webhook endpoint
  ///
  /// Requires mailbox admin permission. Returns null when disabled; never includes the signing secret.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account; otherwise use the credential default.
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

  /// Read mailbox activity and optionally its incoming address
  ///
  /// Read mailbox details. List files, emails, versions and account limits through their separate endpoints.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [bool] includeEmail:
  ///   Requires upload/write access. Omission exposes activity only.
  ///
  /// * [String] accountId:
  ///
  /// * [String] reason:
  Future<Response> getMailboxWithHttpInfo(String id, { bool? includeEmail, String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (includeEmail != null) {
      queryParams.addAll(_queryParams('', 'include_email', includeEmail));
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

  /// Read mailbox activity and optionally its incoming address
  ///
  /// Read mailbox details. List files, emails, versions and account limits through their separate endpoints.
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [bool] includeEmail:
  ///   Requires upload/write access. Omission exposes activity only.
  ///
  /// * [String] accountId:
  ///
  /// * [String] reason:
  Future<CreateMailbox201Response?> getMailbox(String id, { bool? includeEmail, String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    final response = await getMailboxWithHttpInfo(id, includeEmail: includeEmail, accountId: accountId, reason: reason, abortTrigger: abortTrigger,);
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

  /// Read a mailbox email address and limits
  ///
  /// Requires upload/write access. Anyone knowing the address can send; reading files requires mailbox authorization. Original message.eml, decoded message.json, and attachments are stored together.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///   Authorized mailbox prefix ID
  ///
  /// * [String] accountId:
  ///   Explicitly granted account; omission uses credential default
  ///
  /// * [String] reason:
  Future<Response> getMailboxEmailSettingsWithHttpInfo(String id, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{id}/email'
      .replaceAll('{id}', id);

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

  /// Read a mailbox email address and limits
  ///
  /// Requires upload/write access. Anyone knowing the address can send; reading files requires mailbox authorization. Original message.eml, decoded message.json, and attachments are stored together.
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///   Authorized mailbox prefix ID
  ///
  /// * [String] accountId:
  ///   Explicitly granted account; omission uses credential default
  ///
  /// * [String] reason:
  Future<GetMailboxEmailSettings200Response?> getMailboxEmailSettings(String id, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    final response = await getMailboxEmailSettingsWithHttpInfo(id, accountId: accountId, reason: reason, abortTrigger: abortTrigger,);
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

  /// Read current account identity and granted accounts
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] accountId:
  ///   Select a granted account for this request only; omit for the credential's default account.
  ///
  /// * [String] reason:
  Future<Response> getRevdokuStatusWithHttpInfo({ String? accountId, String? reason, Future<void>? abortTrigger, }) async {
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

  /// Read current account identity and granted accounts
  ///
  /// Parameters:
  ///
  /// * [String] accountId:
  ///   Select a granted account for this request only; omit for the credential's default account.
  ///
  /// * [String] reason:
  Future<GetRevdokuStatus200Response?> getRevdokuStatus({ String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    final response = await getRevdokuStatusWithHttpInfo(accountId: accountId, reason: reason, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetRevdokuStatus200Response',) as GetRevdokuStatus200Response;
    
    }
    return null;
  }

  /// List account email domains, DNS records, receiving state and usage
  ///
  /// Full-account owner/administrator authorization required. Cookie-authenticated writes require CSRF. Check the returned domain setup availability. Never change customer DNS without explicit authorization.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] accountId:
  ///   Explicit granted account for this call; omission uses the credential account.
  ///
  /// * [String] reason:
  Future<Response> listAccountEmailDomainsWithHttpInfo({ String? accountId, String? reason, Future<void>? abortTrigger, }) async {
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

  /// List account email domains, DNS records, receiving state and usage
  ///
  /// Full-account owner/administrator authorization required. Cookie-authenticated writes require CSRF. Check the returned domain setup availability. Never change customer DNS without explicit authorization.
  ///
  /// Parameters:
  ///
  /// * [String] accountId:
  ///   Explicit granted account for this call; omission uses the credential account.
  ///
  /// * [String] reason:
  Future<ApiSuccess?> listAccountEmailDomains({ String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    final response = await listAccountEmailDomainsWithHttpInfo(accountId: accountId, reason: reason, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiSuccess',) as ApiSuccess;
    
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
  /// * [int] offset:
  Future<Response> listAccountsWithHttpInfo({ int? limit, int? offset, Future<void>? abortTrigger, }) async {
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
    if (offset != null) {
      queryParams.addAll(_queryParams('', 'offset', offset));
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
  /// * [int] offset:
  Future<ListAccounts200Response?> listAccounts({ int? limit, int? offset, Future<void>? abortTrigger, }) async {
    final response = await listAccountsWithHttpInfo(limit: limit, offset: offset, abortTrigger: abortTrigger,);
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

  /// List received emails
  ///
  /// Requires mailbox read permission. Ascending arrival order supports incremental polling: retain next_cursor even after an empty page. Reuse account, mailbox and filters. Late receipt timestamps are included. Descending order browses history. Edits/read changes/restorations do not replay earlier arrivals. Listing does not mark read.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account; otherwise use the credential default.
  ///
  /// * [int] limit:
  ///   Maximum messages on this page.
  ///
  /// * [String] cursor:
  ///   Opaque next_cursor from a previous page.
  ///
  /// * [String] order:
  ///   Arrival order.
  ///
  /// * [String] sender:
  ///   Exact sender address, case insensitive.
  ///
  /// * [String] subject:
  ///   Case insensitive subject substring.
  ///
  /// * [DateTime] receivedAfter:
  ///   Exclusive receipt-time lower bound.
  ///
  /// * [DateTime] receivedBefore:
  ///   Exclusive receipt-time upper bound.
  ///
  /// * [bool] read:
  ///   Current shared read status.
  ///
  /// * [bool] hasAttachments:
  ///   Saved attachment presence.
  ///
  /// * [String] conversationId:
  ///   An email ID in the selected conversation.
  ///
  /// * [bool] includeStorage:
  ///   Include backing file identifiers for file-browser integration.
  Future<Response> listEmailsWithHttpInfo(String mailboxId, { String? accountId, int? limit, String? cursor, String? order, String? sender, String? subject, DateTime? receivedAfter, DateTime? receivedBefore, bool? read, bool? hasAttachments, String? conversationId, bool? includeStorage, Future<void>? abortTrigger, }) async {
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
    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }
    if (cursor != null) {
      queryParams.addAll(_queryParams('', 'cursor', cursor));
    }
    if (order != null) {
      queryParams.addAll(_queryParams('', 'order', order));
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

  /// List received emails
  ///
  /// Requires mailbox read permission. Ascending arrival order supports incremental polling: retain next_cursor even after an empty page. Reuse account, mailbox and filters. Late receipt timestamps are included. Descending order browses history. Edits/read changes/restorations do not replay earlier arrivals. Listing does not mark read.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account; otherwise use the credential default.
  ///
  /// * [int] limit:
  ///   Maximum messages on this page.
  ///
  /// * [String] cursor:
  ///   Opaque next_cursor from a previous page.
  ///
  /// * [String] order:
  ///   Arrival order.
  ///
  /// * [String] sender:
  ///   Exact sender address, case insensitive.
  ///
  /// * [String] subject:
  ///   Case insensitive subject substring.
  ///
  /// * [DateTime] receivedAfter:
  ///   Exclusive receipt-time lower bound.
  ///
  /// * [DateTime] receivedBefore:
  ///   Exclusive receipt-time upper bound.
  ///
  /// * [bool] read:
  ///   Current shared read status.
  ///
  /// * [bool] hasAttachments:
  ///   Saved attachment presence.
  ///
  /// * [String] conversationId:
  ///   An email ID in the selected conversation.
  ///
  /// * [bool] includeStorage:
  ///   Include backing file identifiers for file-browser integration.
  Future<ListEmails200Response?> listEmails(String mailboxId, { String? accountId, int? limit, String? cursor, String? order, String? sender, String? subject, DateTime? receivedAfter, DateTime? receivedBefore, bool? read, bool? hasAttachments, String? conversationId, bool? includeStorage, Future<void>? abortTrigger, }) async {
    final response = await listEmailsWithHttpInfo(mailboxId, accountId: accountId, limit: limit, cursor: cursor, order: order, sender: sender, subject: subject, receivedAfter: receivedAfter, receivedBefore: receivedBefore, read: read, hasAttachments: hasAttachments, conversationId: conversationId, includeStorage: includeStorage, abortTrigger: abortTrigger,);
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

  /// List files or related email without marking read
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [int] limit:
  ///   Default and maximum 100.
  ///
  /// * [int] offset:
  ///
  /// * [String] reason:
  ///
  /// * [String] q:
  ///
  /// * [String] folder:
  ///
  /// * [String] accountId:
  ///   Select another granted account; otherwise use the credential default.
  Future<Response> listMailboxFilesWithHttpInfo(String id, { int? limit, int? offset, String? reason, String? q, String? folder, String? accountId, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{id}/files'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }
    if (offset != null) {
      queryParams.addAll(_queryParams('', 'offset', offset));
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

  /// List files or related email without marking read
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [int] limit:
  ///   Default and maximum 100.
  ///
  /// * [int] offset:
  ///
  /// * [String] reason:
  ///
  /// * [String] q:
  ///
  /// * [String] folder:
  ///
  /// * [String] accountId:
  ///   Select another granted account; otherwise use the credential default.
  Future<ListMailboxFiles200Response?> listMailboxFiles(String id, { int? limit, int? offset, String? reason, String? q, String? folder, String? accountId, Future<void>? abortTrigger, }) async {
    final response = await listMailboxFilesWithHttpInfo(id, limit: limit, offset: offset, reason: reason, q: q, folder: folder, accountId: accountId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ListMailboxFiles200Response',) as ListMailboxFiles200Response;
    
    }
    return null;
  }

  /// List accessible mailboxes
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] accountId:
  ///   Select another granted account; otherwise use the credential default.
  ///
  /// * [bool] archived:
  ///
  /// * [String] q:
  Future<Response> listMailboxesWithHttpInfo({ String? accountId, bool? archived, String? q, Future<void>? abortTrigger, }) async {
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
    if (archived != null) {
      queryParams.addAll(_queryParams('', 'archived', archived));
    }
    if (q != null) {
      queryParams.addAll(_queryParams('', 'q', q));
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

  /// List accessible mailboxes
  ///
  /// Parameters:
  ///
  /// * [String] accountId:
  ///   Select another granted account; otherwise use the credential default.
  ///
  /// * [bool] archived:
  ///
  /// * [String] q:
  Future<ListMailboxes200Response?> listMailboxes({ String? accountId, bool? archived, String? q, Future<void>? abortTrigger, }) async {
    final response = await listMailboxesWithHttpInfo(accountId: accountId, archived: archived, q: q, abortTrigger: abortTrigger,);
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

  /// Remove unused receiving domain after confirmation
  ///
  /// Full-account owner/administrator authorization required. Cookie-authenticated writes require CSRF. Check the returned domain setup availability. Never change customer DNS without explicit authorization.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [RemoveAccountEmailDomainRequest] removeAccountEmailDomainRequest (required):
  Future<Response> removeAccountEmailDomainWithHttpInfo(String id, RemoveAccountEmailDomainRequest removeAccountEmailDomainRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/account/email_domains/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = removeAccountEmailDomainRequest;

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

  /// Remove unused receiving domain after confirmation
  ///
  /// Full-account owner/administrator authorization required. Cookie-authenticated writes require CSRF. Check the returned domain setup availability. Never change customer DNS without explicit authorization.
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [RemoveAccountEmailDomainRequest] removeAccountEmailDomainRequest (required):
  Future<ApiSuccess?> removeAccountEmailDomain(String id, RemoveAccountEmailDomainRequest removeAccountEmailDomainRequest, { Future<void>? abortTrigger, }) async {
    final response = await removeAccountEmailDomainWithHttpInfo(id, removeAccountEmailDomainRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiSuccess',) as ApiSuccess;
    
    }
    return null;
  }

  /// Resend the human operator’s verification code
  ///
  /// Requires signup_token. Replaces the old code without resetting attempts or the ten-minute expiry. Enforces the 60-second canonical-email cooldown, three API-signup sends per 30 minutes, shared three sends per five minutes, and global hourly send cap. Return 429 with Retry-After when limited; never automatically restart the flow to bypass a limit.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ResendAgentSignupCodeRequest] resendAgentSignupCodeRequest (required):
  Future<Response> resendAgentSignupCodeWithHttpInfo(ResendAgentSignupCodeRequest resendAgentSignupCodeRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/agent/signups/resend';

    // ignore: prefer_final_locals
    Object? postBody = resendAgentSignupCodeRequest;

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

  /// Resend the human operator’s verification code
  ///
  /// Requires signup_token. Replaces the old code without resetting attempts or the ten-minute expiry. Enforces the 60-second canonical-email cooldown, three API-signup sends per 30 minutes, shared three sends per five minutes, and global hourly send cap. Return 429 with Retry-After when limited; never automatically restart the flow to bypass a limit.
  ///
  /// Parameters:
  ///
  /// * [ResendAgentSignupCodeRequest] resendAgentSignupCodeRequest (required):
  Future<StartAgentSignup202Response?> resendAgentSignupCode(ResendAgentSignupCodeRequest resendAgentSignupCodeRequest, { Future<void>? abortTrigger, }) async {
    final response = await resendAgentSignupCodeWithHttpInfo(resendAgentSignupCodeRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'StartAgentSignup202Response',) as StartAgentSignup202Response;
    
    }
    return null;
  }

  /// Replace a mailbox email address after confirmation
  ///
  /// Requires write access and confirmation. Rotations stay on the current domain unless domain is supplied. A ready custom domain requires account eligibility and exact tenant ownership; platform recovers to the default platform domain. Custom activation returns 202; poll the existing email endpoint until assignment.status is active or failed. The old address remains current until successful commit, which charges once. Read /v1/account/limits for the rotation allowance; do not hard-code plan allowances. Never use or synthesize a pending address. Optional username chooses a custom name and additionally requires a full-account owner/administrator, an available platform domain or a ready customer-owned domain (with deployment support for custom domains). Blank/null names are invalid. Unchanged saves cost no rotation. Named addresses may be reused only in their original account once no primary, alias or pending assignment holds them; archived mailboxes retain addresses. Retired addresses do not forward. Assignment history survives mailbox deletion. Optional keep_old_as_alias retains the old primary for the same mailbox, requiring full-account administrator access and an available alias slot. Free has no aliases; query account limits for the effective cap. Retention commits atomically with activation.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///   Authorized mailbox prefix ID
  ///
  /// * [RotateMailboxEmailAddressRequest] rotateMailboxEmailAddressRequest (required):
  Future<Response> rotateMailboxEmailAddressWithHttpInfo(String id, RotateMailboxEmailAddressRequest rotateMailboxEmailAddressRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{id}/email/rotate'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = rotateMailboxEmailAddressRequest;

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

  /// Replace a mailbox email address after confirmation
  ///
  /// Requires write access and confirmation. Rotations stay on the current domain unless domain is supplied. A ready custom domain requires account eligibility and exact tenant ownership; platform recovers to the default platform domain. Custom activation returns 202; poll the existing email endpoint until assignment.status is active or failed. The old address remains current until successful commit, which charges once. Read /v1/account/limits for the rotation allowance; do not hard-code plan allowances. Never use or synthesize a pending address. Optional username chooses a custom name and additionally requires a full-account owner/administrator, an available platform domain or a ready customer-owned domain (with deployment support for custom domains). Blank/null names are invalid. Unchanged saves cost no rotation. Named addresses may be reused only in their original account once no primary, alias or pending assignment holds them; archived mailboxes retain addresses. Retired addresses do not forward. Assignment history survives mailbox deletion. Optional keep_old_as_alias retains the old primary for the same mailbox, requiring full-account administrator access and an available alias slot. Free has no aliases; query account limits for the effective cap. Retention commits atomically with activation.
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///   Authorized mailbox prefix ID
  ///
  /// * [RotateMailboxEmailAddressRequest] rotateMailboxEmailAddressRequest (required):
  Future<GetMailboxEmailSettings200Response?> rotateMailboxEmailAddress(String id, RotateMailboxEmailAddressRequest rotateMailboxEmailAddressRequest, { Future<void>? abortTrigger, }) async {
    final response = await rotateMailboxEmailAddressWithHttpInfo(id, rotateMailboxEmailAddressRequest, abortTrigger: abortTrigger,);
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

  /// Configure one received-email webhook per mailbox
  ///
  /// Requires mailbox admin permission. Public HTTPS, including explicit ports such as 8443. Generates an encrypted signing secret, returned here. Same-URL updates retain it; replacing the URL rotates it and cancels pending old-version deliveries. Events are signed and retried up to eight attempts on transient failure; duplicates are possible. Worker-crash recovery is bounded to 24 hours from event creation. Exhausted and permanent failures require operator review.
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

  /// Configure one received-email webhook per mailbox
  ///
  /// Requires mailbox admin permission. Public HTTPS, including explicit ports such as 8443. Generates an encrypted signing secret, returned here. Same-URL updates retain it; replacing the URL rotates it and cancels pending old-version deliveries. Events are signed and retried up to eight attempts on transient failure; duplicates are possible. Worker-crash recovery is bounded to 24 hours from event creation. Exhausted and permanent failures require operator review.
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

  /// Start signup with the human operator’s email
  ///
  /// Available only when data.signup.available is true in discovery. Requests use uncompressed JSON at most 8 KiB. IP/global request limits run before challenge lookup; canonical-email send limits are shared with browser and legacy sign-in. Returns a private signup_token and emails an OTP. Creates no user, account, mailbox, API key or address reservation before proof. MCP exposes the same signup flow through revdoku_signup, revdoku_signup_verify and revdoku_signup_resend. CLI sign-in and hosted MCP account tools use browser OAuth.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [StartAgentSignupRequest] startAgentSignupRequest (required):
  Future<Response> startAgentSignupWithHttpInfo(StartAgentSignupRequest startAgentSignupRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/agent/signups';

    // ignore: prefer_final_locals
    Object? postBody = startAgentSignupRequest;

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

  /// Start signup with the human operator’s email
  ///
  /// Available only when data.signup.available is true in discovery. Requests use uncompressed JSON at most 8 KiB. IP/global request limits run before challenge lookup; canonical-email send limits are shared with browser and legacy sign-in. Returns a private signup_token and emails an OTP. Creates no user, account, mailbox, API key or address reservation before proof. MCP exposes the same signup flow through revdoku_signup, revdoku_signup_verify and revdoku_signup_resend. CLI sign-in and hosted MCP account tools use browser OAuth.
  ///
  /// Parameters:
  ///
  /// * [StartAgentSignupRequest] startAgentSignupRequest (required):
  Future<StartAgentSignup202Response?> startAgentSignup(StartAgentSignupRequest startAgentSignupRequest, { Future<void>? abortTrigger, }) async {
    final response = await startAgentSignupWithHttpInfo(startAgentSignupRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'StartAgentSignup202Response',) as StartAgentSignup202Response;
    
    }
    return null;
  }

  /// Mark a received email read or unread
  ///
  /// Requires mailbox read permission, including for locked/read-only content. Only read status can change. Receipt and audit event commit atomically. Repeated state changes are idempotent.
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
  /// * [String] accountId:
  ///   Select another granted account; otherwise use the credential default.
  Future<Response> updateEmailWithHttpInfo(String mailboxId, String emailId, UpdateEmailRequest updateEmailRequest, { String? accountId, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{mailbox_id}/emails/{email_id}'
      .replaceAll('{mailbox_id}', mailboxId)
      .replaceAll('{email_id}', emailId);

    // ignore: prefer_final_locals
    Object? postBody = updateEmailRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
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

  /// Mark a received email read or unread
  ///
  /// Requires mailbox read permission, including for locked/read-only content. Only read status can change. Receipt and audit event commit atomically. Repeated state changes are idempotent.
  ///
  /// Parameters:
  ///
  /// * [String] mailboxId (required):
  ///
  /// * [String] emailId (required):
  ///
  /// * [UpdateEmailRequest] updateEmailRequest (required):
  ///
  /// * [String] accountId:
  ///   Select another granted account; otherwise use the credential default.
  Future<UpdateEmail200Response?> updateEmail(String mailboxId, String emailId, UpdateEmailRequest updateEmailRequest, { String? accountId, Future<void>? abortTrigger, }) async {
    final response = await updateEmailWithHttpInfo(mailboxId, emailId, updateEmailRequest, accountId: accountId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UpdateEmail200Response',) as UpdateEmail200Response;
    
    }
    return null;
  }

  /// Replace the allowed senders for a mailbox
  ///
  /// Requires account owner/administrator and mailbox-admin permission. Read sender_allowlist.version from GET /mailboxes/{id}/email first. Entries match exact authenticated From addresses or domains, with no wildcards or implicit subdomains. A stale or missing version returns EMAIL_ALLOWLIST_CHANGED; invalid entries return EMAIL_ALLOWLIST_INVALID. Disabled policies retain the supplied entries. Locks and read-only account state apply.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///   Authorized mailbox prefix ID
  ///
  /// * [UpdateMailboxEmailAllowlistRequest] updateMailboxEmailAllowlistRequest (required):
  ///
  /// * [String] accountId:
  ///   Explicitly granted account; omission uses credential default
  ///
  /// * [String] reason:
  Future<Response> updateMailboxEmailAllowlistWithHttpInfo(String id, UpdateMailboxEmailAllowlistRequest updateMailboxEmailAllowlistRequest, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/mailboxes/{id}/email/allowlist'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = updateMailboxEmailAllowlistRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (accountId != null) {
      queryParams.addAll(_queryParams('', 'account_id', accountId));
    }
    if (reason != null) {
      queryParams.addAll(_queryParams('', 'reason', reason));
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

  /// Replace the allowed senders for a mailbox
  ///
  /// Requires account owner/administrator and mailbox-admin permission. Read sender_allowlist.version from GET /mailboxes/{id}/email first. Entries match exact authenticated From addresses or domains, with no wildcards or implicit subdomains. A stale or missing version returns EMAIL_ALLOWLIST_CHANGED; invalid entries return EMAIL_ALLOWLIST_INVALID. Disabled policies retain the supplied entries. Locks and read-only account state apply.
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///   Authorized mailbox prefix ID
  ///
  /// * [UpdateMailboxEmailAllowlistRequest] updateMailboxEmailAllowlistRequest (required):
  ///
  /// * [String] accountId:
  ///   Explicitly granted account; omission uses credential default
  ///
  /// * [String] reason:
  Future<UpdateMailboxEmailAllowlist200Response?> updateMailboxEmailAllowlist(String id, UpdateMailboxEmailAllowlistRequest updateMailboxEmailAllowlistRequest, { String? accountId, String? reason, Future<void>? abortTrigger, }) async {
    final response = await updateMailboxEmailAllowlistWithHttpInfo(id, updateMailboxEmailAllowlistRequest, accountId: accountId, reason: reason, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UpdateMailboxEmailAllowlist200Response',) as UpdateMailboxEmailAllowlist200Response;
    
    }
    return null;
  }

  /// Queue exact ownership, SES and MX verification
  ///
  /// Full-account owner/administrator authorization required. Cookie-authenticated writes require CSRF. Check the returned domain setup availability. Never change customer DNS without explicit authorization.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [VerifyAccountEmailDomainRequest] verifyAccountEmailDomainRequest:
  Future<Response> verifyAccountEmailDomainWithHttpInfo(String id, { VerifyAccountEmailDomainRequest? verifyAccountEmailDomainRequest, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/account/email_domains/{id}/verify'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = verifyAccountEmailDomainRequest;

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

  /// Queue exact ownership, SES and MX verification
  ///
  /// Full-account owner/administrator authorization required. Cookie-authenticated writes require CSRF. Check the returned domain setup availability. Never change customer DNS without explicit authorization.
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [VerifyAccountEmailDomainRequest] verifyAccountEmailDomainRequest:
  Future<ApiSuccess?> verifyAccountEmailDomain(String id, { VerifyAccountEmailDomainRequest? verifyAccountEmailDomainRequest, Future<void>? abortTrigger, }) async {
    final response = await verifyAccountEmailDomainWithHttpInfo(id, verifyAccountEmailDomainRequest: verifyAccountEmailDomainRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiSuccess',) as ApiSuccess;
    
    }
    return null;
  }

  /// Verify the human’s code and create the first mailbox
  ///
  /// Requires the signup_token and privately entered OTP. Five attempts per challenge, ten per IP/canonical email per 15 minutes; challenge expires after ten minutes. Existing identities must use normal sign-in after proof, preserving 2FA and suspension. A name conflict can be corrected using username in the same verified session without another OTP. No-store. A successful replay returns completed IDs without the key; recover through normal sign-in and connection management.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [VerifyAgentSignupRequest] verifyAgentSignupRequest (required):
  Future<Response> verifyAgentSignupWithHttpInfo(VerifyAgentSignupRequest verifyAgentSignupRequest, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/agent/signups/verify';

    // ignore: prefer_final_locals
    Object? postBody = verifyAgentSignupRequest;

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

  /// Verify the human’s code and create the first mailbox
  ///
  /// Requires the signup_token and privately entered OTP. Five attempts per challenge, ten per IP/canonical email per 15 minutes; challenge expires after ten minutes. Existing identities must use normal sign-in after proof, preserving 2FA and suspension. A name conflict can be corrected using username in the same verified session without another OTP. No-store. A successful replay returns completed IDs without the key; recover through normal sign-in and connection management.
  ///
  /// Parameters:
  ///
  /// * [VerifyAgentSignupRequest] verifyAgentSignupRequest (required):
  Future<VerifyAgentSignup200Response?> verifyAgentSignup(VerifyAgentSignupRequest verifyAgentSignupRequest, { Future<void>? abortTrigger, }) async {
    final response = await verifyAgentSignupWithHttpInfo(verifyAgentSignupRequest, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'VerifyAgentSignup200Response',) as VerifyAgentSignup200Response;
    
    }
    return null;
  }
}
