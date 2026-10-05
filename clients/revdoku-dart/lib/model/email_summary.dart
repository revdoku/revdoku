//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class EmailSummary {
  /// Returns a new [EmailSummary] instance.
  EmailSummary({
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
    this.bodyStatus,
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
  });

  EmailSummarySchemaVersionEnum? schemaVersion;

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

  EmailSummaryBodyStatusEnum? bodyStatus;

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
  EmailForwarding? forwarding;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailSummary &&
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
    other.forwarding == forwarding;

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
    (bodyStatus == null ? 0 : bodyStatus!.hashCode) +
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
    (forwarding == null ? 0 : forwarding!.hashCode);

  @override
  String toString() => 'EmailSummary[schemaVersion=$schemaVersion, subject=$subject, from=$from, to=$to, fromAddresses=$fromAddresses, toAddresses=$toAddresses, ccAddresses=$ccAddresses, replyToAddresses=$replyToAddresses, messageId=$messageId, inReplyTo=$inReplyTo, references=$references, threadId=$threadId, deliveredTo=$deliveredTo, receivedAt=$receivedAt, bodyStatus=$bodyStatus, omittedAttachmentCount=$omittedAttachmentCount, id=$id, conversationId=$conversationId, fileId=$fileId, versionId=$versionId, attachmentCount=$attachmentCount, read=$read, readAt=$readAt, readBy=$readBy, readByApiKey=$readByApiKey, files=$files, forwarding=$forwarding]';

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
    if (this.bodyStatus != null) {
      json[r'body_status'] = this.bodyStatus;
    } else {
      json[r'body_status'] = null;
    }
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
    return json;
  }

  /// Returns a new [EmailSummary] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailSummary? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'received_at'), 'Required key "EmailSummary[received_at]" is missing from JSON.');
        assert(json[r'received_at'] != null, 'Required key "EmailSummary[received_at]" has a null value in JSON.');
        assert(json.containsKey(r'id'), 'Required key "EmailSummary[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "EmailSummary[id]" has a null value in JSON.');
        assert(json.containsKey(r'conversation_id'), 'Required key "EmailSummary[conversation_id]" is missing from JSON.');
        assert(json[r'conversation_id'] != null, 'Required key "EmailSummary[conversation_id]" has a null value in JSON.');
        assert(json.containsKey(r'attachment_count'), 'Required key "EmailSummary[attachment_count]" is missing from JSON.');
        assert(json[r'attachment_count'] != null, 'Required key "EmailSummary[attachment_count]" has a null value in JSON.');
        assert(json.containsKey(r'read'), 'Required key "EmailSummary[read]" is missing from JSON.');
        assert(json[r'read'] != null, 'Required key "EmailSummary[read]" has a null value in JSON.');
        assert(json.containsKey(r'read_at'), 'Required key "EmailSummary[read_at]" is missing from JSON.');
        assert(json.containsKey(r'read_by'), 'Required key "EmailSummary[read_by]" is missing from JSON.');
        assert(json.containsKey(r'read_by_api_key'), 'Required key "EmailSummary[read_by_api_key]" is missing from JSON.');
        return true;
      }());

      return EmailSummary(
        schemaVersion: EmailSummarySchemaVersionEnum.fromJson(json[r'schema_version']),
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
        bodyStatus: EmailSummaryBodyStatusEnum.fromJson(json[r'body_status']),
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
        forwarding: EmailForwarding.fromJson(json[r'forwarding']),
      );
    }
    return null;
  }

  static List<EmailSummary> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailSummary>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailSummary.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailSummary> mapFromJson(dynamic json) {
    final map = <String, EmailSummary>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailSummary.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailSummary-objects as value to a dart map
  static Map<String, List<EmailSummary>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailSummary>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailSummary.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'received_at',
    'id',
    'conversation_id',
    'attachment_count',
    'read',
    'read_at',
    'read_by',
    'read_by_api_key',
  };
}


enum EmailSummarySchemaVersionEnum {
  number1._(1),
  ;

  /// Instantiate a new enum with the provided value.
  const EmailSummarySchemaVersionEnum._(this._value);

  /// The underlying value of this enum member.
  final int _value;

  @override
  String toString() => _value.toString();

  /// Encodes this enum as a value suitable for JSON.
  int toJson() => _value;

  /// Returns the instance of [EmailSummarySchemaVersionEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static EmailSummarySchemaVersionEnum? fromJson(dynamic value) => EmailSummarySchemaVersionEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [EmailSummarySchemaVersionEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<EmailSummarySchemaVersionEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailSummarySchemaVersionEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailSummarySchemaVersionEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EmailSummarySchemaVersionEnum] to int,
/// and [decode] dynamic data back to [EmailSummarySchemaVersionEnum].
class EmailSummarySchemaVersionEnumTypeTransformer {
  factory EmailSummarySchemaVersionEnumTypeTransformer() => _instance ??= const EmailSummarySchemaVersionEnumTypeTransformer._();

  const EmailSummarySchemaVersionEnumTypeTransformer._();

  int encode(EmailSummarySchemaVersionEnum data) => data._value;

  /// Returns the instance of [EmailSummarySchemaVersionEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EmailSummarySchemaVersionEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is EmailSummarySchemaVersionEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case 1: return EmailSummarySchemaVersionEnum.number1;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static EmailSummarySchemaVersionEnumTypeTransformer? _instance;
}



enum EmailSummaryBodyStatusEnum {
  complete._(r'complete'),
  empty._(r'empty'),
  truncated._(r'truncated'),
  unavailable._(r'unavailable'),
  ;

  /// Instantiate a new enum with the provided value.
  const EmailSummaryBodyStatusEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [EmailSummaryBodyStatusEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static EmailSummaryBodyStatusEnum? fromJson(dynamic value) => EmailSummaryBodyStatusEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [EmailSummaryBodyStatusEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<EmailSummaryBodyStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailSummaryBodyStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailSummaryBodyStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EmailSummaryBodyStatusEnum] to String,
/// and [decode] dynamic data back to [EmailSummaryBodyStatusEnum].
class EmailSummaryBodyStatusEnumTypeTransformer {
  factory EmailSummaryBodyStatusEnumTypeTransformer() => _instance ??= const EmailSummaryBodyStatusEnumTypeTransformer._();

  const EmailSummaryBodyStatusEnumTypeTransformer._();

  String encode(EmailSummaryBodyStatusEnum data) => data._value;

  /// Returns the instance of [EmailSummaryBodyStatusEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EmailSummaryBodyStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is EmailSummaryBodyStatusEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'complete': return EmailSummaryBodyStatusEnum.complete;
        case r'empty': return EmailSummaryBodyStatusEnum.empty;
        case r'truncated': return EmailSummaryBodyStatusEnum.truncated;
        case r'unavailable': return EmailSummaryBodyStatusEnum.unavailable;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static EmailSummaryBodyStatusEnumTypeTransformer? _instance;
}


