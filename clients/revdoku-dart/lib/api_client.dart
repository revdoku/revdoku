//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class ApiClient {
  ApiClient({this.basePath = 'https://api.revdoku.com', this.authentication,});

  final String basePath;
  final Authentication? authentication;

  var _client = Client();
  final _defaultHeaderMap = <String, String>{};

  /// Returns the current HTTP [Client] instance to use in this class.
  ///
  /// The return value is guaranteed to never be null.
  Client get client => _client;

  /// Requests to use a new HTTP [Client] in this class.
  set client(Client newClient) {
    _client = newClient;
  }

  Map<String, String> get defaultHeaderMap => _defaultHeaderMap;

  void addDefaultHeader(String key, String value) {
     _defaultHeaderMap[key] = value;
  }

  // We don't use a Map<String, String> for queryParams.
  // If collectionFormat is 'multi', a key might appear multiple times.
  Future<Response> invokeAPI(
    String path,
    String method,
    List<QueryParam> queryParams,
    Object? body,
    Map<String, String> headerParams,
    Map<String, String> formParams,
    String? contentType, {
    Future<void>? abortTrigger,
  }) async {
    await authentication?.applyToParams(queryParams, headerParams);

    headerParams.addAll(_defaultHeaderMap);
    if (contentType != null) {
      headerParams['Content-Type'] = contentType;
    }

    final urlEncodedQueryParams = queryParams.map((param) => '$param');
    final queryString = urlEncodedQueryParams.isNotEmpty ? '?${urlEncodedQueryParams.join('&')}' : '';
    final uri = Uri.parse('$basePath$path$queryString');

    try {
      // Special case for uploading a single file which isn't a 'multipart/form-data'.
      if (
        body is MultipartFile && (contentType == null ||
        !contentType.toLowerCase().startsWith('multipart/form-data'))
      ) {
        final request = AbortableStreamedRequest(method, uri, abortTrigger: abortTrigger);
        request.headers.addAll(headerParams);
        request.contentLength = body.length;
        body.finalize().listen(
          request.sink.add,
          onDone: request.sink.close,
          // ignore: avoid_types_on_closure_parameters
          onError: (Object error, StackTrace trace) => request.sink.close(),
          cancelOnError: true,
        );
        final response = await _client.send(request);
        return await Response.fromStream(response);
      }

      if (body is MultipartRequest) {
        final request = AbortableMultipartRequest(method, uri, abortTrigger: abortTrigger);
        request.fields.addAll(body.fields);
        request.files.addAll(body.files);
        request.headers.addAll(body.headers);
        request.headers.addAll(headerParams);
        final response = await _client.send(request);
        return await Response.fromStream(response);
      }

      final msgBody = contentType == 'application/x-www-form-urlencoded'
        ? formParams
        : await serializeAsync(body);
      final nullableHeaderParams = headerParams.isEmpty ? null : headerParams;

      final request = AbortableRequest(method, uri, abortTrigger: abortTrigger);
      if (nullableHeaderParams != null) {
        request.headers.addAll(nullableHeaderParams);
      }
      if (msgBody is String && msgBody.isNotEmpty) {
        request.body = msgBody;
      } else if (msgBody is List<int> && msgBody.isNotEmpty) {
        request.bodyBytes = msgBody;
      } else if (msgBody is Map<String, String>) {
        request.bodyFields = msgBody;
      }
      final response = await _client.send(request);
      return await Response.fromStream(response);
    } on SocketException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'Socket operation failed: $method $path',
        error,
        trace,
      );
    } on TlsException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'TLS/SSL communication failed: $method $path',
        error,
        trace,
      );
    } on IOException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'I/O operation failed: $method $path',
        error,
        trace,
      );
    } on ClientException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'HTTP connection failed: $method $path',
        error,
        trace,
      );
    } on Exception catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'Exception occurred: $method $path',
        error,
        trace,
      );
    }
  }

  Future<dynamic> deserializeAsync(String value, String targetType, {bool growable = false,}) async {
    // Remove all spaces. Necessary for regular expressions as well.
    targetType = targetType.replaceAll(' ', ''); // ignore: parameter_assignments

    // If the expected target type is String, nothing to do...
    return targetType == 'String'
      ? value
      : fromJson(json.decode(value), targetType, growable: growable);
  }

  Future<String> serializeAsync(Object? value) async => value == null ? '' : json.encode(value);

  /// Returns a native instance of an OpenAPI class matching the [specified type][targetType].
  static dynamic fromJson(dynamic value, String targetType, {bool growable = false,}) {
    try {
      switch (targetType) {
        case 'String':
          return value is String ? value : value.toString();
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'double':
          return value is double ? value : double.parse('$value');
        case 'bool':
          if (value is bool) {
            return value;
          }
          final valueString = '$value'.toLowerCase();
          return valueString == 'true' || valueString == '1';
        case 'DateTime':
          return value is DateTime ? value : DateTime.tryParse(value);
        case 'AccountIdentity':
          return AccountIdentity.fromJson(value);
        case 'AccountIdentityAgencyAccount':
          return AccountIdentityAgencyAccount.fromJson(value);
        case 'AccountIdentityPermissions':
          return AccountIdentityPermissions.fromJson(value);
        case 'AccountLimits':
          return AccountLimits.fromJson(value);
        case 'AccountList':
          return AccountList.fromJson(value);
        case 'ActionRequest':
          return ActionRequest.fromJson(value);
        case 'AddUploadSessionFilesRequest':
          return AddUploadSessionFilesRequest.fromJson(value);
        case 'AgentConnection':
          return AgentConnection.fromJson(value);
        case 'ApiError':
          return ApiError.fromJson(value);
        case 'ApiErrorError':
          return ApiErrorError.fromJson(value);
        case 'AppendText200Response':
          return AppendText200Response.fromJson(value);
        case 'AppendTextRequest':
          return AppendTextRequest.fromJson(value);
        case 'AppendTextResult':
          return AppendTextResult.fromJson(value);
        case 'BrowserLink':
          return BrowserLink.fromJson(value);
        case 'ChangeMailboxAddressRequest':
          return ChangeMailboxAddressRequest.fromJson(value);
        case 'CheckEmailDomain200Response':
          return CheckEmailDomain200Response.fromJson(value);
        case 'CodeRequested':
          return CodeRequested.fromJson(value);
        case 'Connection':
          return Connection.fromJson(value);
        case 'ConnectionPermissions':
          return ConnectionPermissions.fromJson(value);
        case 'ConnectionRenewal':
          return ConnectionRenewal.fromJson(value);
        case 'CreateBrowserLink201Response':
          return CreateBrowserLink201Response.fromJson(value);
        case 'CreateBrowserLinkRequest':
          return CreateBrowserLinkRequest.fromJson(value);
        case 'CreateClientAccount201Response':
          return CreateClientAccount201Response.fromJson(value);
        case 'CreateClientAccount201ResponseData':
          return CreateClientAccount201ResponseData.fromJson(value);
        case 'CreateClientAccountRequest':
          return CreateClientAccountRequest.fromJson(value);
        case 'CreateEmailAliasRequest':
          return CreateEmailAliasRequest.fromJson(value);
        case 'CreateEmailDomain201Response':
          return CreateEmailDomain201Response.fromJson(value);
        case 'CreateEmailDomain201ResponseData':
          return CreateEmailDomain201ResponseData.fromJson(value);
        case 'CreateEmailDomainRequest':
          return CreateEmailDomainRequest.fromJson(value);
        case 'CreateMailbox201Response':
          return CreateMailbox201Response.fromJson(value);
        case 'CreateMailbox201ResponseData':
          return CreateMailbox201ResponseData.fromJson(value);
        case 'CreateMailboxRequest':
          return CreateMailboxRequest.fromJson(value);
        case 'CreateUploadSession201Response':
          return CreateUploadSession201Response.fromJson(value);
        case 'CreateUploadSessionRequest':
          return CreateUploadSessionRequest.fromJson(value);
        case 'DecodedEmailAddress':
          return DecodedEmailAddress.fromJson(value);
        case 'DecodedIncomingMessage':
          return DecodedIncomingMessage.fromJson(value);
        case 'DecodedIncomingMessageAttachmentsInner':
          return DecodedIncomingMessageAttachmentsInner.fromJson(value);
        case 'DeleteEmailDomain200Response':
          return DeleteEmailDomain200Response.fromJson(value);
        case 'DeleteEmailDomainRequest':
          return DeleteEmailDomainRequest.fromJson(value);
        case 'DeleteMailboxRequest':
          return DeleteMailboxRequest.fromJson(value);
        case 'DeleteResult':
          return DeleteResult.fromJson(value);
        case 'DnsRecord':
          return DnsRecord.fromJson(value);
        case 'Download':
          return Download.fromJson(value);
        case 'EmailAlias':
          return EmailAlias.fromJson(value);
        case 'EmailAttachment':
          return EmailAttachment.fromJson(value);
        case 'EmailDelivery':
          return EmailDelivery.fromJson(value);
        case 'EmailDetail':
          return EmailDetail.fromJson(value);
        case 'EmailDomain':
          return EmailDomain.fromJson(value);
        case 'EmailDomainAssignedMailboxesInner':
          return EmailDomainAssignedMailboxesInner.fromJson(value);
        case 'EmailDomainAssignedMailboxesInnerEmail':
          return EmailDomainAssignedMailboxesInnerEmail.fromJson(value);
        case 'EmailDomainCheck':
          return EmailDomainCheck.fromJson(value);
        case 'EmailDomainError':
          return EmailDomainError.fromJson(value);
        case 'EmailDomainList':
          return EmailDomainList.fromJson(value);
        case 'EmailForwarding':
          return EmailForwarding.fromJson(value);
        case 'EmailForwardingContent':
          return EmailForwardingContent.fromJson(value);
        case 'EmailList':
          return EmailList.fromJson(value);
        case 'EmailReceivedEvent':
          return EmailReceivedEvent.fromJson(value);
        case 'EmailReceivedEventData':
          return EmailReceivedEventData.fromJson(value);
        case 'EmailSenderAllowlist':
          return EmailSenderAllowlist.fromJson(value);
        case 'EmailSubscription':
          return EmailSubscription.fromJson(value);
        case 'EmailSummary':
          return EmailSummary.fromJson(value);
        case 'EmailSummaryFiles':
          return EmailSummaryFiles.fromJson(value);
        case 'ErrorCode':
          return ErrorCodeTypeTransformer().decode(value);
        case 'ExchangeConnectionGrantRequest':
          return ExchangeConnectionGrantRequest.fromJson(value);
        case 'FileActor':
          return FileActor.fromJson(value);
        case 'FileDownload':
          return FileDownload.fromJson(value);
        case 'FileKey':
          return FileKey.fromJson(value);
        case 'FileList':
          return FileList.fromJson(value);
        case 'FileUploadSkip':
          return FileUploadSkip.fromJson(value);
        case 'FileVersion':
          return FileVersion.fromJson(value);
        case 'FileVersionList':
          return FileVersionList.fromJson(value);
        case 'FileVersionReason':
          return FileVersionReason.fromJson(value);
        case 'FinalizeUploadSessionRequest':
          return FinalizeUploadSessionRequest.fromJson(value);
        case 'GetAccountLimits200Response':
          return GetAccountLimits200Response.fromJson(value);
        case 'GetAccountLimits200ResponseData':
          return GetAccountLimits200ResponseData.fromJson(value);
        case 'GetAccountLimits200ResponseDataUsage':
          return GetAccountLimits200ResponseDataUsage.fromJson(value);
        case 'GetAccountLimits200ResponseDataUsageMailboxCreations':
          return GetAccountLimits200ResponseDataUsageMailboxCreations.fromJson(value);
        case 'GetEmail200Response':
          return GetEmail200Response.fromJson(value);
        case 'GetEmail200ResponseData':
          return GetEmail200ResponseData.fromJson(value);
        case 'GetEmailOriginalDownload200Response':
          return GetEmailOriginalDownload200Response.fromJson(value);
        case 'GetEmailOriginalDownload200ResponseData':
          return GetEmailOriginalDownload200ResponseData.fromJson(value);
        case 'GetEmailSubscription200Response':
          return GetEmailSubscription200Response.fromJson(value);
        case 'GetEmailSubscription200ResponseData':
          return GetEmailSubscription200ResponseData.fromJson(value);
        case 'GetEmailWebhook200Response':
          return GetEmailWebhook200Response.fromJson(value);
        case 'GetEmailWebhook200ResponseData':
          return GetEmailWebhook200ResponseData.fromJson(value);
        case 'GetFileByPath200Response':
          return GetFileByPath200Response.fromJson(value);
        case 'GetFileByPath200ResponseData':
          return GetFileByPath200ResponseData.fromJson(value);
        case 'GetFileDownload200Response':
          return GetFileDownload200Response.fromJson(value);
        case 'GetMailboxEmailSettings200Response':
          return GetMailboxEmailSettings200Response.fromJson(value);
        case 'GetStatus200Response':
          return GetStatus200Response.fromJson(value);
        case 'ListAccounts200Response':
          return ListAccounts200Response.fromJson(value);
        case 'ListEmailDomains200Response':
          return ListEmailDomains200Response.fromJson(value);
        case 'ListEmails200Response':
          return ListEmails200Response.fromJson(value);
        case 'ListFileVersions200Response':
          return ListFileVersions200Response.fromJson(value);
        case 'ListFiles200Response':
          return ListFiles200Response.fromJson(value);
        case 'ListMailboxes200Response':
          return ListMailboxes200Response.fromJson(value);
        case 'Mailbox':
          return Mailbox.fromJson(value);
        case 'MailboxAction':
          return MailboxAction.fromJson(value);
        case 'MailboxCounts':
          return MailboxCounts.fromJson(value);
        case 'MailboxCreate':
          return MailboxCreate.fromJson(value);
        case 'MailboxEmail':
          return MailboxEmail.fromJson(value);
        case 'MailboxEmailOptions':
          return MailboxEmailOptions.fromJson(value);
        case 'MailboxEmailSettings':
          return MailboxEmailSettings.fromJson(value);
        case 'MailboxEmailSettingsAssignment':
          return MailboxEmailSettingsAssignment.fromJson(value);
        case 'MailboxEmailSettingsAssignmentError':
          return MailboxEmailSettingsAssignmentError.fromJson(value);
        case 'MailboxEmailSettingsAvailableDomainsInner':
          return MailboxEmailSettingsAvailableDomainsInner.fromJson(value);
        case 'MailboxEmailSettingsCustomization':
          return MailboxEmailSettingsCustomization.fromJson(value);
        case 'MailboxFile':
          return MailboxFile.fromJson(value);
        case 'MailboxList':
          return MailboxList.fromJson(value);
        case 'MailboxLock':
          return MailboxLock.fromJson(value);
        case 'MailboxUpdate':
          return MailboxUpdate.fromJson(value);
        case 'MoveFileRequest':
          return MoveFileRequest.fromJson(value);
        case 'Pagination':
          return Pagination.fromJson(value);
        case 'PathOperationResult':
          return PathOperationResult.fromJson(value);
        case 'PrepareFileUpload201Response':
          return PrepareFileUpload201Response.fromJson(value);
        case 'PrepareFileUploadRequest':
          return PrepareFileUploadRequest.fromJson(value);
        case 'PreparedFileUpload':
          return PreparedFileUpload.fromJson(value);
        case 'RenameFile200Response':
          return RenameFile200Response.fromJson(value);
        case 'RenameFileRequest':
          return RenameFileRequest.fromJson(value);
        case 'RequestSignInCode200Response':
          return RequestSignInCode200Response.fromJson(value);
        case 'RequestSignInCodeRequest':
          return RequestSignInCodeRequest.fromJson(value);
        case 'RestoreFileVersion201Response':
          return RestoreFileVersion201Response.fromJson(value);
        case 'RestoredFileVersion':
          return RestoredFileVersion.fromJson(value);
        case 'SaveUploadSessionBatchRequest':
          return SaveUploadSessionBatchRequest.fromJson(value);
        case 'SaveUploadedFile201Response':
          return SaveUploadedFile201Response.fromJson(value);
        case 'SaveUploadedFileRequest':
          return SaveUploadedFileRequest.fromJson(value);
        case 'SavedFile':
          return SavedFile.fromJson(value);
        case 'SendEmail202Response':
          return SendEmail202Response.fromJson(value);
        case 'SendEmail202ResponseData':
          return SendEmail202ResponseData.fromJson(value);
        case 'SendEmailRequest':
          return SendEmailRequest.fromJson(value);
        case 'SetEmailWebhook200Response':
          return SetEmailWebhook200Response.fromJson(value);
        case 'SetEmailWebhook200ResponseData':
          return SetEmailWebhook200ResponseData.fromJson(value);
        case 'SetEmailWebhookRequest':
          return SetEmailWebhookRequest.fromJson(value);
        case 'Status':
          return Status.fromJson(value);
        case 'StatusFeatures':
          return StatusFeatures.fromJson(value);
        case 'StatusUser':
          return StatusUser.fromJson(value);
        case 'StorageUpload':
          return StorageUpload.fromJson(value);
        case 'UpdateEmailAllowlist200Response':
          return UpdateEmailAllowlist200Response.fromJson(value);
        case 'UpdateEmailAllowlist200ResponseData':
          return UpdateEmailAllowlist200ResponseData.fromJson(value);
        case 'UpdateEmailAllowlistRequest':
          return UpdateEmailAllowlistRequest.fromJson(value);
        case 'UpdateEmailAllowlistRequestSenderAllowlist':
          return UpdateEmailAllowlistRequestSenderAllowlist.fromJson(value);
        case 'UpdateEmailRequest':
          return UpdateEmailRequest.fromJson(value);
        case 'UpdateMailboxRequest':
          return UpdateMailboxRequest.fromJson(value);
        case 'UploadBlob':
          return UploadBlob.fromJson(value);
        case 'UploadSession':
          return UploadSession.fromJson(value);
        case 'UploadSessionFile':
          return UploadSessionFile.fromJson(value);
        case 'UploadSessionResult':
          return UploadSessionResult.fromJson(value);
        case 'UploadSessionUpload':
          return UploadSessionUpload.fromJson(value);
        case 'UploadedFile':
          return UploadedFile.fromJson(value);
        case 'VerifyEmailDomainRequest':
          return VerifyEmailDomainRequest.fromJson(value);
        case 'VerifySignInCode201Response':
          return VerifySignInCode201Response.fromJson(value);
        case 'VerifySignInCodeRequest':
          return VerifySignInCodeRequest.fromJson(value);
        case 'Webhook':
          return Webhook.fromJson(value);
        case 'WebhookWithSecret':
          return WebhookWithSecret.fromJson(value);
        default:
          dynamic match;
          if (value is List && (match = _regList.firstMatch(targetType)?.group(1)) != null) {
            return value
              .map<dynamic>((dynamic v) => fromJson(v, match, growable: growable,))
              .toList(growable: growable);
          }
          if (value is Set && (match = _regSet.firstMatch(targetType)?.group(1)) != null) {
            return value
              .map<dynamic>((dynamic v) => fromJson(v, match, growable: growable,))
              .toSet();
          }
          if (value is Map && (match = _regMap.firstMatch(targetType)?.group(1)) != null) {
            return Map<String, dynamic>.fromIterables(
              value.keys.cast<String>(),
              value.values.map<dynamic>((dynamic v) => fromJson(v, match, growable: growable,)),
            );
          }
      }
    } on Exception catch (error, trace) {
      throw ApiException.withInner(HttpStatus.internalServerError, 'Exception during deserialization.', error, trace,);
    }
    throw ApiException(HttpStatus.internalServerError, 'Could not find a suitable class for deserialization',);
  }
}

/// Primarily intended for use in an isolate.
class DeserializationMessage {
  const DeserializationMessage({
    required this.json,
    required this.targetType,
    this.growable = false,
  });

  /// The JSON value to deserialize.
  final String json;

  /// Target type to deserialize to.
  final String targetType;

  /// Whether to make deserialized lists or maps growable.
  final bool growable;
}

/// Primarily intended for use in an isolate.
Future<dynamic> decodeAsync(DeserializationMessage message) async {
  // Remove all spaces. Necessary for regular expressions as well.
  final targetType = message.targetType.replaceAll(' ', '');

  // If the expected target type is String, nothing to do...
  return targetType == 'String'
    ? message.json
    : json.decode(message.json);
}

/// Primarily intended for use in an isolate.
Future<dynamic> deserializeAsync(DeserializationMessage message) async {
  // Remove all spaces. Necessary for regular expressions as well.
  final targetType = message.targetType.replaceAll(' ', '');

  // If the expected target type is String, nothing to do...
  return targetType == 'String'
    ? message.json
    : ApiClient.fromJson(
        json.decode(message.json),
        targetType,
        growable: message.growable,
      );
}

/// Primarily intended for use in an isolate.
Future<String> serializeAsync(Object? value) async => value == null ? '' : json.encode(value);
