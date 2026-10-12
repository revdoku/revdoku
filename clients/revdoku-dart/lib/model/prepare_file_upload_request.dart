//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class PrepareFileUploadRequest {
  /// Returns a new [PrepareFileUploadRequest] instance.
  PrepareFileUploadRequest({
    required this.mailboxId,
    required this.path,
    this.existingFilePolicy = const PrepareFileUploadRequestExistingFilePolicyEnum._('replace'),
    required this.blob,
    this.accountId,
    this.reason,
  });

  String mailboxId;

  /// Destination path in the mailbox. Paths under _email/ return EMAIL_PATH_READ_ONLY.
  String path;

  /// skip returns the existing file without an upload when the path exists.
  PrepareFileUploadRequestExistingFilePolicyEnum existingFilePolicy;

  UploadBlob blob;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? accountId;

  /// Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts.
  String? reason;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PrepareFileUploadRequest &&
    other.mailboxId == mailboxId &&
    other.path == path &&
    other.existingFilePolicy == existingFilePolicy &&
    other.blob == blob &&
    other.accountId == accountId &&
    other.reason == reason;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (mailboxId.hashCode) +
    (path.hashCode) +
    (existingFilePolicy.hashCode) +
    (blob.hashCode) +
    (accountId == null ? 0 : accountId!.hashCode) +
    (reason == null ? 0 : reason!.hashCode);

  @override
  String toString() => 'PrepareFileUploadRequest[mailboxId=$mailboxId, path=$path, existingFilePolicy=$existingFilePolicy, blob=$blob, accountId=$accountId, reason=$reason]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'mailbox_id'] = this.mailboxId;
      json[r'path'] = this.path;
      json[r'existing_file_policy'] = this.existingFilePolicy;
      json[r'blob'] = this.blob;
    if (this.accountId != null) {
      json[r'account_id'] = this.accountId;
    }
    if (this.reason != null) {
      json[r'reason'] = this.reason;
    } else {
      json[r'reason'] = null;
    }
    return json;
  }

  /// Returns a new [PrepareFileUploadRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PrepareFileUploadRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'mailbox_id'), 'Required key "PrepareFileUploadRequest[mailbox_id]" is missing from JSON.');
        assert(json[r'mailbox_id'] != null, 'Required key "PrepareFileUploadRequest[mailbox_id]" has a null value in JSON.');
        assert(json.containsKey(r'path'), 'Required key "PrepareFileUploadRequest[path]" is missing from JSON.');
        assert(json[r'path'] != null, 'Required key "PrepareFileUploadRequest[path]" has a null value in JSON.');
        assert(json.containsKey(r'blob'), 'Required key "PrepareFileUploadRequest[blob]" is missing from JSON.');
        assert(json[r'blob'] != null, 'Required key "PrepareFileUploadRequest[blob]" has a null value in JSON.');
        return true;
      }());

      return PrepareFileUploadRequest(
        mailboxId: mapValueOfType<String>(json, r'mailbox_id')!,
        path: mapValueOfType<String>(json, r'path')!,
        existingFilePolicy: PrepareFileUploadRequestExistingFilePolicyEnum.fromJson(json[r'existing_file_policy']) ?? const PrepareFileUploadRequestExistingFilePolicyEnum._('replace'),
        blob: UploadBlob.fromJson(json[r'blob'])!,
        accountId: mapValueOfType<String>(json, r'account_id'),
        reason: mapValueOfType<String>(json, r'reason'),
      );
    }
    return null;
  }

  static List<PrepareFileUploadRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PrepareFileUploadRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PrepareFileUploadRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PrepareFileUploadRequest> mapFromJson(dynamic json) {
    final map = <String, PrepareFileUploadRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PrepareFileUploadRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PrepareFileUploadRequest-objects as value to a dart map
  static Map<String, List<PrepareFileUploadRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PrepareFileUploadRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PrepareFileUploadRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'mailbox_id',
    'path',
    'blob',
  };
}

/// skip returns the existing file without an upload when the path exists.
enum PrepareFileUploadRequestExistingFilePolicyEnum {
  replace._(r'replace'),
  skip._(r'skip'),
  ;

  /// Instantiate a new enum with the provided value.
  const PrepareFileUploadRequestExistingFilePolicyEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [PrepareFileUploadRequestExistingFilePolicyEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static PrepareFileUploadRequestExistingFilePolicyEnum? fromJson(dynamic value) => PrepareFileUploadRequestExistingFilePolicyEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [PrepareFileUploadRequestExistingFilePolicyEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<PrepareFileUploadRequestExistingFilePolicyEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PrepareFileUploadRequestExistingFilePolicyEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PrepareFileUploadRequestExistingFilePolicyEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [PrepareFileUploadRequestExistingFilePolicyEnum] to String,
/// and [decode] dynamic data back to [PrepareFileUploadRequestExistingFilePolicyEnum].
class PrepareFileUploadRequestExistingFilePolicyEnumTypeTransformer {
  factory PrepareFileUploadRequestExistingFilePolicyEnumTypeTransformer() => _instance ??= const PrepareFileUploadRequestExistingFilePolicyEnumTypeTransformer._();

  const PrepareFileUploadRequestExistingFilePolicyEnumTypeTransformer._();

  String encode(PrepareFileUploadRequestExistingFilePolicyEnum data) => data._value;

  /// Returns the instance of [PrepareFileUploadRequestExistingFilePolicyEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  PrepareFileUploadRequestExistingFilePolicyEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is PrepareFileUploadRequestExistingFilePolicyEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'replace': return PrepareFileUploadRequestExistingFilePolicyEnum.replace;
        case r'skip': return PrepareFileUploadRequestExistingFilePolicyEnum.skip;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static PrepareFileUploadRequestExistingFilePolicyEnumTypeTransformer? _instance;
}


