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

  Future<dynamic> deserializeAsync(String value, String targetType, {bool growable = false,}) async =>
    // ignore: deprecated_member_use_from_same_package
    deserialize(value, targetType, growable: growable);

  @Deprecated('Scheduled for removal in OpenAPI Generator 6.x. Use deserializeAsync() instead.')
  dynamic deserialize(String value, String targetType, {bool growable = false,}) {
    // Remove all spaces. Necessary for regular expressions as well.
    targetType = targetType.replaceAll(' ', ''); // ignore: parameter_assignments

    // If the expected target type is String, nothing to do...
    return targetType == 'String'
      ? value
      : fromJson(json.decode(value), targetType, growable: growable);
  }

  // ignore: deprecated_member_use_from_same_package
  Future<String> serializeAsync(Object? value) async => serialize(value);

  @Deprecated('Scheduled for removal in OpenAPI Generator 6.x. Use serializeAsync() instead.')
  String serialize(Object? value) => value == null ? '' : json.encode(value);

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
        case 'AccountPagination':
          return AccountPagination.fromJson(value);
        case 'ApiError':
          return ApiError.fromJson(value);
        case 'ApiErrorError':
          return ApiErrorError.fromJson(value);
        case 'CreateAccountEmailDomainRequest':
          return CreateAccountEmailDomainRequest.fromJson(value);
        case 'CreateClientAccount201Response':
          return CreateClientAccount201Response.fromJson(value);
        case 'CreateClientAccount201ResponseData':
          return CreateClientAccount201ResponseData.fromJson(value);
        case 'CreateClientAccountRequest':
          return CreateClientAccountRequest.fromJson(value);
        case 'CreateMailbox201Response':
          return CreateMailbox201Response.fromJson(value);
        case 'CreateMailbox201ResponseData':
          return CreateMailbox201ResponseData.fromJson(value);
        case 'CreateMailboxEmailAliasRequest':
          return CreateMailboxEmailAliasRequest.fromJson(value);
        case 'CreateMailboxRequest':
          return CreateMailboxRequest.fromJson(value);
        case 'DecodedEmailAddress':
          return DecodedEmailAddress.fromJson(value);
        case 'DecodedIncomingMessage':
          return DecodedIncomingMessage.fromJson(value);
        case 'DecodedIncomingMessageAttachmentsInner':
          return DecodedIncomingMessageAttachmentsInner.fromJson(value);
        case 'DnsRecord':
          return DnsRecord.fromJson(value);
        case 'EmailAttachment':
          return EmailAttachment.fromJson(value);
        case 'EmailDetail':
          return EmailDetail.fromJson(value);
        case 'EmailDomain':
          return EmailDomain.fromJson(value);
        case 'EmailDomainAssignedMailboxesInner':
          return EmailDomainAssignedMailboxesInner.fromJson(value);
        case 'EmailDomainCheck':
          return EmailDomainCheck.fromJson(value);
        case 'EmailDomainCheckResponse':
          return EmailDomainCheckResponse.fromJson(value);
        case 'EmailDomainError':
          return EmailDomainError.fromJson(value);
        case 'EmailDomainList':
          return EmailDomainList.fromJson(value);
        case 'EmailDomainListResponse':
          return EmailDomainListResponse.fromJson(value);
        case 'EmailDomainResponse':
          return EmailDomainResponse.fromJson(value);
        case 'EmailDownload':
          return EmailDownload.fromJson(value);
        case 'EmailForwarding':
          return EmailForwarding.fromJson(value);
        case 'EmailForwardingContent':
          return EmailForwardingContent.fromJson(value);
        case 'EmailPagination':
          return EmailPagination.fromJson(value);
        case 'EmailReceivedEvent':
          return EmailReceivedEvent.fromJson(value);
        case 'EmailReceivedEventData':
          return EmailReceivedEventData.fromJson(value);
        case 'EmailSenderAllowlist':
          return EmailSenderAllowlist.fromJson(value);
        case 'EmailSummary':
          return EmailSummary.fromJson(value);
        case 'EmailSummaryFiles':
          return EmailSummaryFiles.fromJson(value);
        case 'EmailUsage':
          return EmailUsage.fromJson(value);
        case 'FileActor':
          return FileActor.fromJson(value);
        case 'FileKey':
          return FileKey.fromJson(value);
        case 'FilePagination':
          return FilePagination.fromJson(value);
        case 'FileUploadSkip':
          return FileUploadSkip.fromJson(value);
        case 'FileVersion':
          return FileVersion.fromJson(value);
        case 'FileVersionReason':
          return FileVersionReason.fromJson(value);
        case 'GetAccount200Response':
          return GetAccount200Response.fromJson(value);
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
        case 'GetEmailOriginalDownloadUrl200Response':
          return GetEmailOriginalDownloadUrl200Response.fromJson(value);
        case 'GetEmailOriginalDownloadUrl200ResponseData':
          return GetEmailOriginalDownloadUrl200ResponseData.fromJson(value);
        case 'GetEmailSubscription200Response':
          return GetEmailSubscription200Response.fromJson(value);
        case 'GetEmailSubscription200ResponseData':
          return GetEmailSubscription200ResponseData.fromJson(value);
        case 'GetEmailSubscription200ResponseDataSubscription':
          return GetEmailSubscription200ResponseDataSubscription.fromJson(value);
        case 'GetEmailWebhook200Response':
          return GetEmailWebhook200Response.fromJson(value);
        case 'GetEmailWebhook200ResponseData':
          return GetEmailWebhook200ResponseData.fromJson(value);
        case 'GetEmailWebhook200ResponseDataWebhook':
          return GetEmailWebhook200ResponseDataWebhook.fromJson(value);
        case 'GetMailboxEmailSettings200Response':
          return GetMailboxEmailSettings200Response.fromJson(value);
        case 'GetRevdokuStatus200Response':
          return GetRevdokuStatus200Response.fromJson(value);
        case 'GetRevdokuStatus200ResponseData':
          return GetRevdokuStatus200ResponseData.fromJson(value);
        case 'GetRevdokuStatus200ResponseDataConnection':
          return GetRevdokuStatus200ResponseDataConnection.fromJson(value);
        case 'GetRevdokuStatus200ResponseDataConnectionRenewal':
          return GetRevdokuStatus200ResponseDataConnectionRenewal.fromJson(value);
        case 'GetRevdokuStatus200ResponseDataFeatures':
          return GetRevdokuStatus200ResponseDataFeatures.fromJson(value);
        case 'ListAccounts200Response':
          return ListAccounts200Response.fromJson(value);
        case 'ListAccounts200ResponseData':
          return ListAccounts200ResponseData.fromJson(value);
        case 'ListEmails200Response':
          return ListEmails200Response.fromJson(value);
        case 'ListEmails200ResponseData':
          return ListEmails200ResponseData.fromJson(value);
        case 'ListMailboxFiles200Response':
          return ListMailboxFiles200Response.fromJson(value);
        case 'ListMailboxFiles200ResponseData':
          return ListMailboxFiles200ResponseData.fromJson(value);
        case 'ListMailboxes200Response':
          return ListMailboxes200Response.fromJson(value);
        case 'ListMailboxes200ResponseData':
          return ListMailboxes200ResponseData.fromJson(value);
        case 'Mailbox':
          return Mailbox.fromJson(value);
        case 'MailboxAction':
          return MailboxAction.fromJson(value);
        case 'MailboxCreateOptions':
          return MailboxCreateOptions.fromJson(value);
        case 'MailboxEmail':
          return MailboxEmail.fromJson(value);
        case 'MailboxEmailActivity':
          return MailboxEmailActivity.fromJson(value);
        case 'MailboxEmailAliasesInner':
          return MailboxEmailAliasesInner.fromJson(value);
        case 'MailboxEmailAssignment':
          return MailboxEmailAssignment.fromJson(value);
        case 'MailboxEmailAssignmentError':
          return MailboxEmailAssignmentError.fromJson(value);
        case 'MailboxEmailAvailableDomainsInner':
          return MailboxEmailAvailableDomainsInner.fromJson(value);
        case 'MailboxEmailCustomization':
          return MailboxEmailCustomization.fromJson(value);
        case 'MailboxEmailOptions':
          return MailboxEmailOptions.fromJson(value);
        case 'MailboxFile':
          return MailboxFile.fromJson(value);
        case 'MailboxFileResponse':
          return MailboxFileResponse.fromJson(value);
        case 'MailboxFileResponseData':
          return MailboxFileResponseData.fromJson(value);
        case 'MailboxLock':
          return MailboxLock.fromJson(value);
        case 'MailboxLockLockedBy':
          return MailboxLockLockedBy.fromJson(value);
        case 'MailboxLockLockedByApiKey':
          return MailboxLockLockedByApiKey.fromJson(value);
        case 'PrepareFileUploadRequest':
          return PrepareFileUploadRequest.fromJson(value);
        case 'PreparedFileUpload':
          return PreparedFileUpload.fromJson(value);
        case 'PreparedFileUploadResponse':
          return PreparedFileUploadResponse.fromJson(value);
        case 'RemoveAccountEmailDomainRequest':
          return RemoveAccountEmailDomainRequest.fromJson(value);
        case 'ResendAgentSignupCodeRequest':
          return ResendAgentSignupCodeRequest.fromJson(value);
        case 'RotateMailboxEmailAddressRequest':
          return RotateMailboxEmailAddressRequest.fromJson(value);
        case 'SaveUploadedFileRequest':
          return SaveUploadedFileRequest.fromJson(value);
        case 'SavedFile':
          return SavedFile.fromJson(value);
        case 'SavedFileResponse':
          return SavedFileResponse.fromJson(value);
        case 'SetEmailWebhook200Response':
          return SetEmailWebhook200Response.fromJson(value);
        case 'SetEmailWebhook200ResponseData':
          return SetEmailWebhook200ResponseData.fromJson(value);
        case 'SetEmailWebhook200ResponseDataWebhook':
          return SetEmailWebhook200ResponseDataWebhook.fromJson(value);
        case 'SetEmailWebhookRequest':
          return SetEmailWebhookRequest.fromJson(value);
        case 'SignupAccount':
          return SignupAccount.fromJson(value);
        case 'SignupChallenge':
          return SignupChallenge.fromJson(value);
        case 'SignupMailbox':
          return SignupMailbox.fromJson(value);
        case 'SignupResponse':
          return SignupResponse.fromJson(value);
        case 'SignupResult':
          return SignupResult.fromJson(value);
        case 'SignupStatus':
          return SignupStatus.fromJson(value);
        case 'StartAgentSignup202Response':
          return StartAgentSignup202Response.fromJson(value);
        case 'StartAgentSignup202ResponseData':
          return StartAgentSignup202ResponseData.fromJson(value);
        case 'StartAgentSignupRequest':
          return StartAgentSignupRequest.fromJson(value);
        case 'StorageUpload':
          return StorageUpload.fromJson(value);
        case 'UpdateEmail200Response':
          return UpdateEmail200Response.fromJson(value);
        case 'UpdateEmail200ResponseData':
          return UpdateEmail200ResponseData.fromJson(value);
        case 'UpdateEmailRequest':
          return UpdateEmailRequest.fromJson(value);
        case 'UpdateMailboxEmailAllowlist200Response':
          return UpdateMailboxEmailAllowlist200Response.fromJson(value);
        case 'UpdateMailboxEmailAllowlist200ResponseData':
          return UpdateMailboxEmailAllowlist200ResponseData.fromJson(value);
        case 'UpdateMailboxEmailAllowlistRequest':
          return UpdateMailboxEmailAllowlistRequest.fromJson(value);
        case 'UpdateMailboxEmailAllowlistRequestSenderAllowlist':
          return UpdateMailboxEmailAllowlistRequestSenderAllowlist.fromJson(value);
        case 'UploadBlob':
          return UploadBlob.fromJson(value);
        case 'VerifyAccountEmailDomainRequest':
          return VerifyAccountEmailDomainRequest.fromJson(value);
        case 'VerifyAgentSignupRequest':
          return VerifyAgentSignupRequest.fromJson(value);
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
