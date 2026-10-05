//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class EmailDetail {
  /// Returns a new [EmailDetail] instance.
  EmailDetail({
    this.schemaVersion,
    this.subject,
    this.from,
    this.to,
    this.fromAddresses = const [],
    this.toAddresses = const [],
    this.ccAddresses = const [],
    this.replyToAddresses = const [],
    this.messageId,
    this.inReplyTo = const [],
    this.references = const [],
    this.threadId,
    this.deliveredTo,
    required this.receivedAt,
    required this.bodyStatus,
    this.omittedAttachmentCount,
    required this.id,
    required this.conversationId,
    this.fileId,
    this.versionId,
    required this.attachmentCount,
    required this.read,
    required this.readAt,
    required this.readBy,
    required this.readByApiKey,
    this.files,
    this.forwarding,
    required this.bodyText,
    this.attachments = const [],
  });

  EmailDetailSchemaVersionEnum? schemaVersion;

  String? subject;

  String? from;

  String? to;

  /// Parsed From authors in header order, retaining multiple authors. Empty when absent/unparseable. Display names are not identity keys.
  List<DecodedEmailAddress> fromAddresses;

  /// Parsed To recipients in header order, with named groups flattened. Empty when absent/unparseable; not trusted delivery routing.
  List<DecodedEmailAddress> toAddresses;

  /// Parsed Cc recipients in header order, with named groups flattened. Empty when absent/unparseable.
  List<DecodedEmailAddress> ccAddresses;

  /// Parsed Reply-To addresses in header order. Empty when absent/unparseable. Does not authorize sending a reply.
  List<DecodedEmailAddress> replyToAddresses;

  /// Sender Message-ID without angle brackets, preserving case. Null when absent/unparseable/ambiguous; never the Revdoku delivery ID.
  String? messageId;

  /// Ordered parent Message-IDs without angle brackets, preserving case. Empty when absent/unparseable; multiple parents are retained.
  List<String> inReplyTo;

  /// Ordered References IDs without angle brackets, preserving case. Empty when absent/unparseable.
  List<String> references;

  /// thr_ plus SHA-256 of thread_anchor_message_id. Best-effort header-derived grouping hint, not authoritative conversation membership or an access grant. Missing ancestry or reused IDs can split/merge hints. Scope lookups to accessible mailboxes.
  String? threadId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? deliveredTo;

  DateTime receivedAt;

  EmailDetailBodyStatusEnum bodyStatus;

  /// Minimum value: 1
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? omittedAttachmentCount;

  String id;

  String conversationId;

  /// Included only with include_storage=true for file-browser integration.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? fileId;

  /// Included only with include_storage=true for file-browser integration.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? versionId;

  /// Minimum value: 0
  int attachmentCount;

  bool read;

  DateTime? readAt;

  Object? readBy;

  Object? readByApiKey;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  EmailSummaryFiles? files;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  EmailForwardingContent? forwarding;

  String? bodyText;

  List<EmailAttachment> attachments;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailDetail &&
    other.schemaVersion == schemaVersion &&
    other.subject == subject &&
    other.from == from &&
    other.to == to &&
    _deepEquality.equals(other.fromAddresses, fromAddresses) &&
    _deepEquality.equals(other.toAddresses, toAddresses) &&
    _deepEquality.equals(other.ccAddresses, ccAddresses) &&
    _deepEquality.equals(other.replyToAddresses, replyToAddresses) &&
    other.messageId == messageId &&
    _deepEquality.equals(other.inReplyTo, inReplyTo) &&
    _deepEquality.equals(other.references, references) &&
    other.threadId == threadId &&
    other.deliveredTo == deliveredTo &&
    other.receivedAt == receivedAt &&
    other.bodyStatus == bodyStatus &&
    other.omittedAttachmentCount == omittedAttachmentCount &&
    other.id == id &&
    other.conversationId == conversationId &&
    other.fileId == fileId &&
    other.versionId == versionId &&
    other.attachmentCount == attachmentCount &&
    other.read == read &&
    other.readAt == readAt &&
    other.readBy == readBy &&
    other.readByApiKey == readByApiKey &&
    other.files == files &&
    other.forwarding == forwarding &&
    other.bodyText == bodyText &&
    _deepEquality.equals(other.attachments, attachments);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (schemaVersion == null ? 0 : schemaVersion!.hashCode) +
    (subject == null ? 0 : subject!.hashCode) +
    (from == null ? 0 : from!.hashCode) +
    (to == null ? 0 : to!.hashCode) +
    (fromAddresses.hashCode) +
    (toAddresses.hashCode) +
    (ccAddresses.hashCode) +
    (replyToAddresses.hashCode) +
    (messageId == null ? 0 : messageId!.hashCode) +
    (inReplyTo.hashCode) +
    (references.hashCode) +
    (threadId == null ? 0 : threadId!.hashCode) +
    (deliveredTo == null ? 0 : deliveredTo!.hashCode) +
    (receivedAt.hashCode) +
    (bodyStatus.hashCode) +
    (omittedAttachmentCount == null ? 0 : omittedAttachmentCount!.hashCode) +
    (id.hashCode) +
    (conversationId.hashCode) +
    (fileId == null ? 0 : fileId!.hashCode) +
    (versionId == null ? 0 : versionId!.hashCode) +
    (attachmentCount.hashCode) +
    (read.hashCode) +
    (readAt == null ? 0 : readAt!.hashCode) +
    (readBy == null ? 0 : readBy!.hashCode) +
    (readByApiKey == null ? 0 : readByApiKey!.hashCode) +
    (files == null ? 0 : files!.hashCode) +
    (forwarding == null ? 0 : forwarding!.hashCode) +
    (bodyText == null ? 0 : bodyText!.hashCode) +
    (attachments.hashCode);

  @override
  String toString() => 'EmailDetail[schemaVersion=$schemaVersion, subject=$subject, from=$from, to=$to, fromAddresses=$fromAddresses, toAddresses=$toAddresses, ccAddresses=$ccAddresses, replyToAddresses=$replyToAddresses, messageId=$messageId, inReplyTo=$inReplyTo, references=$references, threadId=$threadId, deliveredTo=$deliveredTo, receivedAt=$receivedAt, bodyStatus=$bodyStatus, omittedAttachmentCount=$omittedAttachmentCount, id=$id, conversationId=$conversationId, fileId=$fileId, versionId=$versionId, attachmentCount=$attachmentCount, read=$read, readAt=$readAt, readBy=$readBy, readByApiKey=$readByApiKey, files=$files, forwarding=$forwarding, bodyText=$bodyText, attachments=$attachments]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.schemaVersion != null) {
      json[r'schema_version'] = this.schemaVersion;
    } else {
      json[r'schema_version'] = null;
    }
    if (this.subject != null) {
      json[r'subject'] = this.subject;
    } else {
      json[r'subject'] = null;
    }
    if (this.from != null) {
      json[r'from'] = this.from;
    } else {
      json[r'from'] = null;
    }
    if (this.to != null) {
      json[r'to'] = this.to;
    } else {
      json[r'to'] = null;
    }
      json[r'from_addresses'] = this.fromAddresses;
      json[r'to_addresses'] = this.toAddresses;
      json[r'cc_addresses'] = this.ccAddresses;
      json[r'reply_to_addresses'] = this.replyToAddresses;
    if (this.messageId != null) {
      json[r'message_id'] = this.messageId;
    } else {
      json[r'message_id'] = null;
    }
      json[r'in_reply_to'] = this.inReplyTo;
      json[r'references'] = this.references;
    if (this.threadId != null) {
      json[r'thread_id'] = this.threadId;
    } else {
      json[r'thread_id'] = null;
    }
    if (this.deliveredTo != null) {
      json[r'delivered_to'] = this.deliveredTo;
    } else {
      json[r'delivered_to'] = null;
    }
      json[r'received_at'] = this.receivedAt.toUtc().toIso8601String();
      json[r'body_status'] = this.bodyStatus;
    if (this.omittedAttachmentCount != null) {
      json[r'omitted_attachment_count'] = this.omittedAttachmentCount;
    } else {
      json[r'omitted_attachment_count'] = null;
    }
      json[r'id'] = this.id;
      json[r'conversation_id'] = this.conversationId;
    if (this.fileId != null) {
      json[r'file_id'] = this.fileId;
    } else {
      json[r'file_id'] = null;
    }
    if (this.versionId != null) {
      json[r'version_id'] = this.versionId;
    } else {
      json[r'version_id'] = null;
    }
      json[r'attachment_count'] = this.attachmentCount;
      json[r'read'] = this.read;
    if (this.readAt != null) {
      json[r'read_at'] = this.readAt!.toUtc().toIso8601String();
    } else {
      json[r'read_at'] = null;
    }
    if (this.readBy != null) {
      json[r'read_by'] = this.readBy;
    } else {
      json[r'read_by'] = null;
    }
    if (this.readByApiKey != null) {
      json[r'read_by_api_key'] = this.readByApiKey;
    } else {
      json[r'read_by_api_key'] = null;
    }
    if (this.files != null) {
      json[r'files'] = this.files;
    } else {
      json[r'files'] = null;
    }
    if (this.forwarding != null) {
      json[r'forwarding'] = this.forwarding;
    } else {
      json[r'forwarding'] = null;
    }
    if (this.bodyText != null) {
      json[r'body_text'] = this.bodyText;
    } else {
      json[r'body_text'] = null;
    }
      json[r'attachments'] = this.attachments;
    return json;
  }

  /// Returns a new [EmailDetail] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailDetail? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'received_at'), 'Required key "EmailDetail[received_at]" is missing from JSON.');
        assert(json[r'received_at'] != null, 'Required key "EmailDetail[received_at]" has a null value in JSON.');
        assert(json.containsKey(r'body_status'), 'Required key "EmailDetail[body_status]" is missing from JSON.');
        assert(json[r'body_status'] != null, 'Required key "EmailDetail[body_status]" has a null value in JSON.');
        assert(json.containsKey(r'id'), 'Required key "EmailDetail[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "EmailDetail[id]" has a null value in JSON.');
        assert(json.containsKey(r'conversation_id'), 'Required key "EmailDetail[conversation_id]" is missing from JSON.');
        assert(json[r'conversation_id'] != null, 'Required key "EmailDetail[conversation_id]" has a null value in JSON.');
        assert(json.containsKey(r'attachment_count'), 'Required key "EmailDetail[attachment_count]" is missing from JSON.');
        assert(json[r'attachment_count'] != null, 'Required key "EmailDetail[attachment_count]" has a null value in JSON.');
        assert(json.containsKey(r'read'), 'Required key "EmailDetail[read]" is missing from JSON.');
        assert(json[r'read'] != null, 'Required key "EmailDetail[read]" has a null value in JSON.');
        assert(json.containsKey(r'read_at'), 'Required key "EmailDetail[read_at]" is missing from JSON.');
        assert(json.containsKey(r'read_by'), 'Required key "EmailDetail[read_by]" is missing from JSON.');
        assert(json.containsKey(r'read_by_api_key'), 'Required key "EmailDetail[read_by_api_key]" is missing from JSON.');
        assert(json.containsKey(r'body_text'), 'Required key "EmailDetail[body_text]" is missing from JSON.');
        assert(json.containsKey(r'attachments'), 'Required key "EmailDetail[attachments]" is missing from JSON.');
        assert(json[r'attachments'] != null, 'Required key "EmailDetail[attachments]" has a null value in JSON.');
        return true;
      }());

      return EmailDetail(
        schemaVersion: EmailDetailSchemaVersionEnum.fromJson(json[r'schema_version']),
        subject: mapValueOfType<String>(json, r'subject'),
        from: mapValueOfType<String>(json, r'from'),
        to: mapValueOfType<String>(json, r'to'),
        fromAddresses: DecodedEmailAddress.listFromJson(json[r'from_addresses']),
        toAddresses: DecodedEmailAddress.listFromJson(json[r'to_addresses']),
        ccAddresses: DecodedEmailAddress.listFromJson(json[r'cc_addresses']),
        replyToAddresses: DecodedEmailAddress.listFromJson(json[r'reply_to_addresses']),
        messageId: mapValueOfType<String>(json, r'message_id'),
        inReplyTo: json[r'in_reply_to'] is Iterable
            ? (json[r'in_reply_to'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        references: json[r'references'] is Iterable
            ? (json[r'references'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        threadId: mapValueOfType<String>(json, r'thread_id'),
        deliveredTo: mapValueOfType<String>(json, r'delivered_to'),
        receivedAt: mapDateTime(json, r'received_at', r'')!,
        bodyStatus: EmailDetailBodyStatusEnum.fromJson(json[r'body_status'])!,
        omittedAttachmentCount: mapValueOfType<int>(json, r'omitted_attachment_count'),
        id: mapValueOfType<String>(json, r'id')!,
        conversationId: mapValueOfType<String>(json, r'conversation_id')!,
        fileId: mapValueOfType<String>(json, r'file_id'),
        versionId: mapValueOfType<String>(json, r'version_id'),
        attachmentCount: mapValueOfType<int>(json, r'attachment_count')!,
        read: mapValueOfType<bool>(json, r'read')!,
        readAt: mapDateTime(json, r'read_at', r''),
        readBy: mapValueOfType<Object>(json, r'read_by'),
        readByApiKey: mapValueOfType<Object>(json, r'read_by_api_key'),
        files: EmailSummaryFiles.fromJson(json[r'files']),
        forwarding: EmailForwardingContent.fromJson(json[r'forwarding']),
        bodyText: mapValueOfType<String>(json, r'body_text'),
        attachments: EmailAttachment.listFromJson(json[r'attachments']),
      );
    }
    return null;
  }

  static List<EmailDetail> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailDetail>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailDetail.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailDetail> mapFromJson(dynamic json) {
    final map = <String, EmailDetail>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailDetail.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailDetail-objects as value to a dart map
  static Map<String, List<EmailDetail>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailDetail>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailDetail.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'received_at',
    'body_status',
    'id',
    'conversation_id',
    'attachment_count',
    'read',
    'read_at',
    'read_by',
    'read_by_api_key',
    'body_text',
    'attachments',
  };
}


enum EmailDetailSchemaVersionEnum {
  number1._(1),
  ;

  /// Instantiate a new enum with the provided value.
  const EmailDetailSchemaVersionEnum._(this._value);

  /// The underlying value of this enum member.
  final int _value;

  @override
  String toString() => _value.toString();

  /// Encodes this enum as a value suitable for JSON.
  int toJson() => _value;

  /// Returns the instance of [EmailDetailSchemaVersionEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static EmailDetailSchemaVersionEnum? fromJson(dynamic value) => EmailDetailSchemaVersionEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [EmailDetailSchemaVersionEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<EmailDetailSchemaVersionEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailDetailSchemaVersionEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailDetailSchemaVersionEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EmailDetailSchemaVersionEnum] to int,
/// and [decode] dynamic data back to [EmailDetailSchemaVersionEnum].
class EmailDetailSchemaVersionEnumTypeTransformer {
  factory EmailDetailSchemaVersionEnumTypeTransformer() => _instance ??= const EmailDetailSchemaVersionEnumTypeTransformer._();

  const EmailDetailSchemaVersionEnumTypeTransformer._();

  int encode(EmailDetailSchemaVersionEnum data) => data._value;

  /// Returns the instance of [EmailDetailSchemaVersionEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EmailDetailSchemaVersionEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is EmailDetailSchemaVersionEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case 1: return EmailDetailSchemaVersionEnum.number1;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static EmailDetailSchemaVersionEnumTypeTransformer? _instance;
}



enum EmailDetailBodyStatusEnum {
  complete._(r'complete'),
  empty._(r'empty'),
  truncated._(r'truncated'),
  unavailable._(r'unavailable'),
  ;

  /// Instantiate a new enum with the provided value.
  const EmailDetailBodyStatusEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [EmailDetailBodyStatusEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static EmailDetailBodyStatusEnum? fromJson(dynamic value) => EmailDetailBodyStatusEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [EmailDetailBodyStatusEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<EmailDetailBodyStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailDetailBodyStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailDetailBodyStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EmailDetailBodyStatusEnum] to String,
/// and [decode] dynamic data back to [EmailDetailBodyStatusEnum].
class EmailDetailBodyStatusEnumTypeTransformer {
  factory EmailDetailBodyStatusEnumTypeTransformer() => _instance ??= const EmailDetailBodyStatusEnumTypeTransformer._();

  const EmailDetailBodyStatusEnumTypeTransformer._();

  String encode(EmailDetailBodyStatusEnum data) => data._value;

  /// Returns the instance of [EmailDetailBodyStatusEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EmailDetailBodyStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is EmailDetailBodyStatusEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'complete': return EmailDetailBodyStatusEnum.complete;
        case r'empty': return EmailDetailBodyStatusEnum.empty;
        case r'truncated': return EmailDetailBodyStatusEnum.truncated;
        case r'unavailable': return EmailDetailBodyStatusEnum.unavailable;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static EmailDetailBodyStatusEnumTypeTransformer? _instance;
}


