//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class UpdateMailboxEmailAllowlistRequest {
  /// Returns a new [UpdateMailboxEmailAllowlistRequest] instance.
  UpdateMailboxEmailAllowlistRequest({
    required this.senderAllowlist,
    required this.expectedVersion,
    this.accountId,
    this.reason,
  });

  UpdateMailboxEmailAllowlistRequestSenderAllowlist senderAllowlist;

  String expectedVersion;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? accountId;

  String? reason;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateMailboxEmailAllowlistRequest &&
    other.senderAllowlist == senderAllowlist &&
    other.expectedVersion == expectedVersion &&
    other.accountId == accountId &&
    other.reason == reason;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (senderAllowlist.hashCode) +
    (expectedVersion.hashCode) +
    (accountId == null ? 0 : accountId!.hashCode) +
    (reason == null ? 0 : reason!.hashCode);

  @override
  String toString() => 'UpdateMailboxEmailAllowlistRequest[senderAllowlist=$senderAllowlist, expectedVersion=$expectedVersion, accountId=$accountId, reason=$reason]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'sender_allowlist'] = this.senderAllowlist;
      json[r'expected_version'] = this.expectedVersion;
    if (this.accountId != null) {
      json[r'account_id'] = this.accountId;
    } else {
      json[r'account_id'] = null;
    }
    if (this.reason != null) {
      json[r'reason'] = this.reason;
    } else {
      json[r'reason'] = null;
    }
    return json;
  }

  /// Returns a new [UpdateMailboxEmailAllowlistRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateMailboxEmailAllowlistRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'sender_allowlist'), 'Required key "UpdateMailboxEmailAllowlistRequest[sender_allowlist]" is missing from JSON.');
        assert(json[r'sender_allowlist'] != null, 'Required key "UpdateMailboxEmailAllowlistRequest[sender_allowlist]" has a null value in JSON.');
        assert(json.containsKey(r'expected_version'), 'Required key "UpdateMailboxEmailAllowlistRequest[expected_version]" is missing from JSON.');
        assert(json[r'expected_version'] != null, 'Required key "UpdateMailboxEmailAllowlistRequest[expected_version]" has a null value in JSON.');
        return true;
      }());

      return UpdateMailboxEmailAllowlistRequest(
        senderAllowlist: UpdateMailboxEmailAllowlistRequestSenderAllowlist.fromJson(json[r'sender_allowlist'])!,
        expectedVersion: mapValueOfType<String>(json, r'expected_version')!,
        accountId: mapValueOfType<String>(json, r'account_id'),
        reason: mapValueOfType<String>(json, r'reason'),
      );
    }
    return null;
  }

  static List<UpdateMailboxEmailAllowlistRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateMailboxEmailAllowlistRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateMailboxEmailAllowlistRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateMailboxEmailAllowlistRequest> mapFromJson(dynamic json) {
    final map = <String, UpdateMailboxEmailAllowlistRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateMailboxEmailAllowlistRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateMailboxEmailAllowlistRequest-objects as value to a dart map
  static Map<String, List<UpdateMailboxEmailAllowlistRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateMailboxEmailAllowlistRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateMailboxEmailAllowlistRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'sender_allowlist',
    'expected_version',
  };
}

