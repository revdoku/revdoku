//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class AppendTextRequest {
  /// Returns a new [AppendTextRequest] instance.
  AppendTextRequest({
    required this.path,
    required this.content,
    this.newlineBefore = true,
    this.expectedMailboxVersion,
    this.accountId,
    this.reason,
  });

  String path;

  String content;

  bool newlineBefore;

  /// Mailbox version_id from your last read.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? expectedMailboxVersion;

  /// Select another granted account for this request.
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
  bool operator ==(Object other) => identical(this, other) || other is AppendTextRequest &&
    other.path == path &&
    other.content == content &&
    other.newlineBefore == newlineBefore &&
    other.expectedMailboxVersion == expectedMailboxVersion &&
    other.accountId == accountId &&
    other.reason == reason;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (path.hashCode) +
    (content.hashCode) +
    (newlineBefore.hashCode) +
    (expectedMailboxVersion == null ? 0 : expectedMailboxVersion!.hashCode) +
    (accountId == null ? 0 : accountId!.hashCode) +
    (reason == null ? 0 : reason!.hashCode);

  @override
  String toString() => 'AppendTextRequest[path=$path, content=$content, newlineBefore=$newlineBefore, expectedMailboxVersion=$expectedMailboxVersion, accountId=$accountId, reason=$reason]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'path'] = this.path;
      json[r'content'] = this.content;
      json[r'newline_before'] = this.newlineBefore;
    if (this.expectedMailboxVersion != null) {
      json[r'expected_mailbox_version'] = this.expectedMailboxVersion;
    }
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

  /// Returns a new [AppendTextRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AppendTextRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'path'), 'Required key "AppendTextRequest[path]" is missing from JSON.');
        assert(json[r'path'] != null, 'Required key "AppendTextRequest[path]" has a null value in JSON.');
        assert(json.containsKey(r'content'), 'Required key "AppendTextRequest[content]" is missing from JSON.');
        assert(json[r'content'] != null, 'Required key "AppendTextRequest[content]" has a null value in JSON.');
        return true;
      }());

      return AppendTextRequest(
        path: mapValueOfType<String>(json, r'path')!,
        content: mapValueOfType<String>(json, r'content')!,
        newlineBefore: mapValueOfType<bool>(json, r'newline_before') ?? true,
        expectedMailboxVersion: mapValueOfType<String>(json, r'expected_mailbox_version'),
        accountId: mapValueOfType<String>(json, r'account_id'),
        reason: mapValueOfType<String>(json, r'reason'),
      );
    }
    return null;
  }

  static List<AppendTextRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AppendTextRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AppendTextRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AppendTextRequest> mapFromJson(dynamic json) {
    final map = <String, AppendTextRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AppendTextRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AppendTextRequest-objects as value to a dart map
  static Map<String, List<AppendTextRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AppendTextRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AppendTextRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'path',
    'content',
  };
}

