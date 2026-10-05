//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class EmailAttachment {
  /// Returns a new [EmailAttachment] instance.
  EmailAttachment({
    required this.id,
    required this.filename,
    required this.contentType,
    required this.sizeBytes,
    this.versionId,
    this.origin,
  });

  String id;

  String filename;

  String? contentType;

  /// Minimum value: 0
  int sizeBytes;

  /// Present only with include_storage=true.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? versionId;

  /// For normalized forwards: inner attachment, member addition, attached source EML, or unknown inline-forward origin.
  EmailAttachmentOriginEnum? origin;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailAttachment &&
    other.id == id &&
    other.filename == filename &&
    other.contentType == contentType &&
    other.sizeBytes == sizeBytes &&
    other.versionId == versionId &&
    other.origin == origin;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (filename.hashCode) +
    (contentType == null ? 0 : contentType!.hashCode) +
    (sizeBytes.hashCode) +
    (versionId == null ? 0 : versionId!.hashCode) +
    (origin == null ? 0 : origin!.hashCode);

  @override
  String toString() => 'EmailAttachment[id=$id, filename=$filename, contentType=$contentType, sizeBytes=$sizeBytes, versionId=$versionId, origin=$origin]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'filename'] = this.filename;
    if (this.contentType != null) {
      json[r'content_type'] = this.contentType;
    } else {
      json[r'content_type'] = null;
    }
      json[r'size_bytes'] = this.sizeBytes;
    if (this.versionId != null) {
      json[r'version_id'] = this.versionId;
    }
    if (this.origin != null) {
      json[r'origin'] = this.origin;
    }
    return json;
  }

  /// Returns a new [EmailAttachment] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailAttachment? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "EmailAttachment[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "EmailAttachment[id]" has a null value in JSON.');
        assert(json.containsKey(r'filename'), 'Required key "EmailAttachment[filename]" is missing from JSON.');
        assert(json[r'filename'] != null, 'Required key "EmailAttachment[filename]" has a null value in JSON.');
        assert(json.containsKey(r'content_type'), 'Required key "EmailAttachment[content_type]" is missing from JSON.');
        assert(json.containsKey(r'size_bytes'), 'Required key "EmailAttachment[size_bytes]" is missing from JSON.');
        assert(json[r'size_bytes'] != null, 'Required key "EmailAttachment[size_bytes]" has a null value in JSON.');
        return true;
      }());

      return EmailAttachment(
        id: mapValueOfType<String>(json, r'id')!,
        filename: mapValueOfType<String>(json, r'filename')!,
        contentType: mapValueOfType<String>(json, r'content_type'),
        sizeBytes: mapValueOfType<int>(json, r'size_bytes')!,
        versionId: mapValueOfType<String>(json, r'version_id'),
        origin: EmailAttachmentOriginEnum.fromJson(json[r'origin']),
      );
    }
    return null;
  }

  static List<EmailAttachment> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailAttachment>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailAttachment.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailAttachment> mapFromJson(dynamic json) {
    final map = <String, EmailAttachment>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailAttachment.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailAttachment-objects as value to a dart map
  static Map<String, List<EmailAttachment>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailAttachment>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailAttachment.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'filename',
    'content_type',
    'size_bytes',
  };
}

/// For normalized forwards: inner attachment, member addition, attached source EML, or unknown inline-forward origin.
enum EmailAttachmentOriginEnum {
  original._(r'original'),
  forwarder._(r'forwarder'),
  forwardedMessage._(r'forwarded_message'),
  unspecified._(r'unspecified'),
  ;

  /// Instantiate a new enum with the provided value.
  const EmailAttachmentOriginEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [EmailAttachmentOriginEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static EmailAttachmentOriginEnum? fromJson(dynamic value) => EmailAttachmentOriginEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [EmailAttachmentOriginEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<EmailAttachmentOriginEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailAttachmentOriginEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailAttachmentOriginEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EmailAttachmentOriginEnum] to String,
/// and [decode] dynamic data back to [EmailAttachmentOriginEnum].
class EmailAttachmentOriginEnumTypeTransformer {
  factory EmailAttachmentOriginEnumTypeTransformer() => _instance ??= const EmailAttachmentOriginEnumTypeTransformer._();

  const EmailAttachmentOriginEnumTypeTransformer._();

  String encode(EmailAttachmentOriginEnum data) => data._value;

  /// Returns the instance of [EmailAttachmentOriginEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EmailAttachmentOriginEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is EmailAttachmentOriginEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'original': return EmailAttachmentOriginEnum.original;
        case r'forwarder': return EmailAttachmentOriginEnum.forwarder;
        case r'forwarded_message': return EmailAttachmentOriginEnum.forwardedMessage;
        case r'unspecified': return EmailAttachmentOriginEnum.unspecified;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static EmailAttachmentOriginEnumTypeTransformer? _instance;
}


