//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class DecodedIncomingMessage {
  /// Returns a new [DecodedIncomingMessage] instance.
  DecodedIncomingMessage({
    required this.schemaVersion,
    required this.subject,
    required this.from,
    required this.to,
    this.fromAddresses = const [],
    this.toAddresses = const [],
    this.ccAddresses = const [],
    this.replyToAddresses = const [],
    this.messageId,
    this.inReplyTo = const [],
    this.references = const [],
    this.deliveryId,
    this.threadId,
    this.threadIdSource,
    this.threadAnchorMessageId,
    required this.deliveredTo,
    required this.receivedAt,
    required this.bodyText,
    required this.bodyStatus,
    this.omittedAttachmentCount,
    this.attachments = const [],
    this.forwarding,
    this.cc,
    this.replyTo,
  });

  DecodedIncomingMessageSchemaVersionEnum schemaVersion;

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

  /// Revdoku delivery identity, matching email_delivery_id metadata and the original folder suffix. Stable on retries, independent of Message-ID. Copies retain the source identity; not a unique file/copy ID.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? deliveryId;

  /// thr_ plus SHA-256 of thread_anchor_message_id. Best-effort header-derived grouping hint, not authoritative conversation membership or an access grant. Missing ancestry or reused IDs can split/merge hints. Scope lookups to accessible mailboxes.
  String? threadId;

  DecodedIncomingMessageThreadIdSourceEnum? threadIdSource;

  /// First References ID, otherwise the sole In-Reply-To ID, otherwise this message's ID if no parent is available. Null without an anchor or when multiple parents lack References.
  String? threadAnchorMessageId;

  String deliveredTo;

  DateTime receivedAt;

  String? bodyText;

  DecodedIncomingMessageBodyStatusEnum bodyStatus;

  /// Minimum value: 1
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? omittedAttachmentCount;

  List<DecodedIncomingMessageAttachmentsInner> attachments;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  EmailForwardingContent? forwarding;

  /// Decoded Cc header; use the corresponding parsed address array for individual addresses.
  String? cc;

  /// Decoded Reply-To header; use the corresponding parsed address array for individual addresses.
  String? replyTo;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DecodedIncomingMessage &&
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
    other.deliveryId == deliveryId &&
    other.threadId == threadId &&
    other.threadIdSource == threadIdSource &&
    other.threadAnchorMessageId == threadAnchorMessageId &&
    other.deliveredTo == deliveredTo &&
    other.receivedAt == receivedAt &&
    other.bodyText == bodyText &&
    other.bodyStatus == bodyStatus &&
    other.omittedAttachmentCount == omittedAttachmentCount &&
    _deepEquality.equals(other.attachments, attachments) &&
    other.forwarding == forwarding &&
    other.cc == cc &&
    other.replyTo == replyTo;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (schemaVersion.hashCode) +
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
    (deliveryId == null ? 0 : deliveryId!.hashCode) +
    (threadId == null ? 0 : threadId!.hashCode) +
    (threadIdSource == null ? 0 : threadIdSource!.hashCode) +
    (threadAnchorMessageId == null ? 0 : threadAnchorMessageId!.hashCode) +
    (deliveredTo.hashCode) +
    (receivedAt.hashCode) +
    (bodyText == null ? 0 : bodyText!.hashCode) +
    (bodyStatus.hashCode) +
    (omittedAttachmentCount == null ? 0 : omittedAttachmentCount!.hashCode) +
    (attachments.hashCode) +
    (forwarding == null ? 0 : forwarding!.hashCode) +
    (cc == null ? 0 : cc!.hashCode) +
    (replyTo == null ? 0 : replyTo!.hashCode);

  @override
  String toString() => 'DecodedIncomingMessage[schemaVersion=$schemaVersion, subject=$subject, from=$from, to=$to, fromAddresses=$fromAddresses, toAddresses=$toAddresses, ccAddresses=$ccAddresses, replyToAddresses=$replyToAddresses, messageId=$messageId, inReplyTo=$inReplyTo, references=$references, deliveryId=$deliveryId, threadId=$threadId, threadIdSource=$threadIdSource, threadAnchorMessageId=$threadAnchorMessageId, deliveredTo=$deliveredTo, receivedAt=$receivedAt, bodyText=$bodyText, bodyStatus=$bodyStatus, omittedAttachmentCount=$omittedAttachmentCount, attachments=$attachments, forwarding=$forwarding, cc=$cc, replyTo=$replyTo]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'schema_version'] = this.schemaVersion;
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
    if (this.deliveryId != null) {
      json[r'delivery_id'] = this.deliveryId;
    }
    if (this.threadId != null) {
      json[r'thread_id'] = this.threadId;
    } else {
      json[r'thread_id'] = null;
    }
    if (this.threadIdSource != null) {
      json[r'thread_id_source'] = this.threadIdSource;
    } else {
      json[r'thread_id_source'] = null;
    }
    if (this.threadAnchorMessageId != null) {
      json[r'thread_anchor_message_id'] = this.threadAnchorMessageId;
    } else {
      json[r'thread_anchor_message_id'] = null;
    }
      json[r'delivered_to'] = this.deliveredTo;
      json[r'received_at'] = this.receivedAt.toUtc().toIso8601String();
    if (this.bodyText != null) {
      json[r'body_text'] = this.bodyText;
    } else {
      json[r'body_text'] = null;
    }
      json[r'body_status'] = this.bodyStatus;
    if (this.omittedAttachmentCount != null) {
      json[r'omitted_attachment_count'] = this.omittedAttachmentCount;
    }
      json[r'attachments'] = this.attachments;
    if (this.forwarding != null) {
      json[r'forwarding'] = this.forwarding;
    }
    if (this.cc != null) {
      json[r'cc'] = this.cc;
    } else {
      json[r'cc'] = null;
    }
    if (this.replyTo != null) {
      json[r'reply_to'] = this.replyTo;
    } else {
      json[r'reply_to'] = null;
    }
    return json;
  }

  /// Returns a new [DecodedIncomingMessage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DecodedIncomingMessage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'schema_version'), 'Required key "DecodedIncomingMessage[schema_version]" is missing from JSON.');
        assert(json[r'schema_version'] != null, 'Required key "DecodedIncomingMessage[schema_version]" has a null value in JSON.');
        assert(json.containsKey(r'subject'), 'Required key "DecodedIncomingMessage[subject]" is missing from JSON.');
        assert(json.containsKey(r'from'), 'Required key "DecodedIncomingMessage[from]" is missing from JSON.');
        assert(json.containsKey(r'to'), 'Required key "DecodedIncomingMessage[to]" is missing from JSON.');
        assert(json.containsKey(r'delivered_to'), 'Required key "DecodedIncomingMessage[delivered_to]" is missing from JSON.');
        assert(json[r'delivered_to'] != null, 'Required key "DecodedIncomingMessage[delivered_to]" has a null value in JSON.');
        assert(json.containsKey(r'received_at'), 'Required key "DecodedIncomingMessage[received_at]" is missing from JSON.');
        assert(json[r'received_at'] != null, 'Required key "DecodedIncomingMessage[received_at]" has a null value in JSON.');
        assert(json.containsKey(r'body_text'), 'Required key "DecodedIncomingMessage[body_text]" is missing from JSON.');
        assert(json.containsKey(r'body_status'), 'Required key "DecodedIncomingMessage[body_status]" is missing from JSON.');
        assert(json[r'body_status'] != null, 'Required key "DecodedIncomingMessage[body_status]" has a null value in JSON.');
        assert(json.containsKey(r'attachments'), 'Required key "DecodedIncomingMessage[attachments]" is missing from JSON.');
        assert(json[r'attachments'] != null, 'Required key "DecodedIncomingMessage[attachments]" has a null value in JSON.');
        return true;
      }());

      return DecodedIncomingMessage(
        schemaVersion: DecodedIncomingMessageSchemaVersionEnum.fromJson(json[r'schema_version'])!,
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
        deliveryId: mapValueOfType<String>(json, r'delivery_id'),
        threadId: mapValueOfType<String>(json, r'thread_id'),
        threadIdSource: DecodedIncomingMessageThreadIdSourceEnum.fromJson(json[r'thread_id_source']),
        threadAnchorMessageId: mapValueOfType<String>(json, r'thread_anchor_message_id'),
        deliveredTo: mapValueOfType<String>(json, r'delivered_to')!,
        receivedAt: mapDateTime(json, r'received_at', r'')!,
        bodyText: mapValueOfType<String>(json, r'body_text'),
        bodyStatus: DecodedIncomingMessageBodyStatusEnum.fromJson(json[r'body_status'])!,
        omittedAttachmentCount: mapValueOfType<int>(json, r'omitted_attachment_count'),
        attachments: DecodedIncomingMessageAttachmentsInner.listFromJson(json[r'attachments']),
        forwarding: EmailForwardingContent.fromJson(json[r'forwarding']),
        cc: mapValueOfType<String>(json, r'cc'),
        replyTo: mapValueOfType<String>(json, r'reply_to'),
      );
    }
    return null;
  }

  static List<DecodedIncomingMessage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DecodedIncomingMessage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DecodedIncomingMessage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DecodedIncomingMessage> mapFromJson(dynamic json) {
    final map = <String, DecodedIncomingMessage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DecodedIncomingMessage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DecodedIncomingMessage-objects as value to a dart map
  static Map<String, List<DecodedIncomingMessage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DecodedIncomingMessage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DecodedIncomingMessage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'schema_version',
    'subject',
    'from',
    'to',
    'delivered_to',
    'received_at',
    'body_text',
    'body_status',
    'attachments',
  };
}


enum DecodedIncomingMessageSchemaVersionEnum {
  number1._(1),
  ;

  /// Instantiate a new enum with the provided value.
  const DecodedIncomingMessageSchemaVersionEnum._(this._value);

  /// The underlying value of this enum member.
  final int _value;

  @override
  String toString() => _value.toString();

  /// Encodes this enum as a value suitable for JSON.
  int toJson() => _value;

  /// Returns the instance of [DecodedIncomingMessageSchemaVersionEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static DecodedIncomingMessageSchemaVersionEnum? fromJson(dynamic value) => DecodedIncomingMessageSchemaVersionEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [DecodedIncomingMessageSchemaVersionEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<DecodedIncomingMessageSchemaVersionEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DecodedIncomingMessageSchemaVersionEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DecodedIncomingMessageSchemaVersionEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DecodedIncomingMessageSchemaVersionEnum] to int,
/// and [decode] dynamic data back to [DecodedIncomingMessageSchemaVersionEnum].
class DecodedIncomingMessageSchemaVersionEnumTypeTransformer {
  factory DecodedIncomingMessageSchemaVersionEnumTypeTransformer() => _instance ??= const DecodedIncomingMessageSchemaVersionEnumTypeTransformer._();

  const DecodedIncomingMessageSchemaVersionEnumTypeTransformer._();

  int encode(DecodedIncomingMessageSchemaVersionEnum data) => data._value;

  /// Returns the instance of [DecodedIncomingMessageSchemaVersionEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DecodedIncomingMessageSchemaVersionEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is DecodedIncomingMessageSchemaVersionEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case 1: return DecodedIncomingMessageSchemaVersionEnum.number1;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static DecodedIncomingMessageSchemaVersionEnumTypeTransformer? _instance;
}



enum DecodedIncomingMessageThreadIdSourceEnum {
  references._(r'references'),
  inReplyTo._(r'in_reply_to'),
  messageId._(r'message_id'),
  ;

  /// Instantiate a new enum with the provided value.
  const DecodedIncomingMessageThreadIdSourceEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [DecodedIncomingMessageThreadIdSourceEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static DecodedIncomingMessageThreadIdSourceEnum? fromJson(dynamic value) => DecodedIncomingMessageThreadIdSourceEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [DecodedIncomingMessageThreadIdSourceEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<DecodedIncomingMessageThreadIdSourceEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DecodedIncomingMessageThreadIdSourceEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DecodedIncomingMessageThreadIdSourceEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DecodedIncomingMessageThreadIdSourceEnum] to String,
/// and [decode] dynamic data back to [DecodedIncomingMessageThreadIdSourceEnum].
class DecodedIncomingMessageThreadIdSourceEnumTypeTransformer {
  factory DecodedIncomingMessageThreadIdSourceEnumTypeTransformer() => _instance ??= const DecodedIncomingMessageThreadIdSourceEnumTypeTransformer._();

  const DecodedIncomingMessageThreadIdSourceEnumTypeTransformer._();

  String encode(DecodedIncomingMessageThreadIdSourceEnum data) => data._value;

  /// Returns the instance of [DecodedIncomingMessageThreadIdSourceEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DecodedIncomingMessageThreadIdSourceEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is DecodedIncomingMessageThreadIdSourceEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'references': return DecodedIncomingMessageThreadIdSourceEnum.references;
        case r'in_reply_to': return DecodedIncomingMessageThreadIdSourceEnum.inReplyTo;
        case r'message_id': return DecodedIncomingMessageThreadIdSourceEnum.messageId;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static DecodedIncomingMessageThreadIdSourceEnumTypeTransformer? _instance;
}



enum DecodedIncomingMessageBodyStatusEnum {
  complete._(r'complete'),
  empty._(r'empty'),
  truncated._(r'truncated'),
  unavailable._(r'unavailable'),
  ;

  /// Instantiate a new enum with the provided value.
  const DecodedIncomingMessageBodyStatusEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [DecodedIncomingMessageBodyStatusEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static DecodedIncomingMessageBodyStatusEnum? fromJson(dynamic value) => DecodedIncomingMessageBodyStatusEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [DecodedIncomingMessageBodyStatusEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<DecodedIncomingMessageBodyStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DecodedIncomingMessageBodyStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DecodedIncomingMessageBodyStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DecodedIncomingMessageBodyStatusEnum] to String,
/// and [decode] dynamic data back to [DecodedIncomingMessageBodyStatusEnum].
class DecodedIncomingMessageBodyStatusEnumTypeTransformer {
  factory DecodedIncomingMessageBodyStatusEnumTypeTransformer() => _instance ??= const DecodedIncomingMessageBodyStatusEnumTypeTransformer._();

  const DecodedIncomingMessageBodyStatusEnumTypeTransformer._();

  String encode(DecodedIncomingMessageBodyStatusEnum data) => data._value;

  /// Returns the instance of [DecodedIncomingMessageBodyStatusEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DecodedIncomingMessageBodyStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is DecodedIncomingMessageBodyStatusEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'complete': return DecodedIncomingMessageBodyStatusEnum.complete;
        case r'empty': return DecodedIncomingMessageBodyStatusEnum.empty;
        case r'truncated': return DecodedIncomingMessageBodyStatusEnum.truncated;
        case r'unavailable': return DecodedIncomingMessageBodyStatusEnum.unavailable;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static DecodedIncomingMessageBodyStatusEnumTypeTransformer? _instance;
}


