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
    this.accountId,
    required this.path,
    required this.blob,
  });

  String mailboxId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? accountId;

  String path;

  UploadBlob blob;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PrepareFileUploadRequest &&
    other.mailboxId == mailboxId &&
    other.accountId == accountId &&
    other.path == path &&
    other.blob == blob;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (mailboxId.hashCode) +
    (accountId == null ? 0 : accountId!.hashCode) +
    (path.hashCode) +
    (blob.hashCode);

  @override
  String toString() => 'PrepareFileUploadRequest[mailboxId=$mailboxId, accountId=$accountId, path=$path, blob=$blob]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'mailbox_id'] = this.mailboxId;
    if (this.accountId != null) {
      json[r'account_id'] = this.accountId;
    }
      json[r'path'] = this.path;
      json[r'blob'] = this.blob;
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
        accountId: mapValueOfType<String>(json, r'account_id'),
        path: mapValueOfType<String>(json, r'path')!,
        blob: UploadBlob.fromJson(json[r'blob'])!,
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

