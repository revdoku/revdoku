//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class ChangeMailboxAddressRequest {
  /// Returns a new [ChangeMailboxAddressRequest] instance.
  ChangeMailboxAddressRequest({
    required this.confirm,
    required this.expectedAddress,
    this.username,
    this.domain,
    this.keepOldAsAlias = false,
    this.accountId,
    this.reason,
  });

  bool confirm;

  /// Current address from your last settings read. A different current address returns EMAIL_ADDRESS_CHANGED.
  String expectedAddress;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? username;

  /// Available platform domain, a ready domain of this account, or platform.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? domain;

  bool keepOldAsAlias;

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
  bool operator ==(Object other) => identical(this, other) || other is ChangeMailboxAddressRequest &&
    other.confirm == confirm &&
    other.expectedAddress == expectedAddress &&
    other.username == username &&
    other.domain == domain &&
    other.keepOldAsAlias == keepOldAsAlias &&
    other.accountId == accountId &&
    other.reason == reason;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (confirm.hashCode) +
    (expectedAddress.hashCode) +
    (username == null ? 0 : username!.hashCode) +
    (domain == null ? 0 : domain!.hashCode) +
    (keepOldAsAlias.hashCode) +
    (accountId == null ? 0 : accountId!.hashCode) +
    (reason == null ? 0 : reason!.hashCode);

  @override
  String toString() => 'ChangeMailboxAddressRequest[confirm=$confirm, expectedAddress=$expectedAddress, username=$username, domain=$domain, keepOldAsAlias=$keepOldAsAlias, accountId=$accountId, reason=$reason]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'confirm'] = this.confirm;
      json[r'expected_address'] = this.expectedAddress;
    if (this.username != null) {
      json[r'username'] = this.username;
    }
    if (this.domain != null) {
      json[r'domain'] = this.domain;
    }
      json[r'keep_old_as_alias'] = this.keepOldAsAlias;
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

  /// Returns a new [ChangeMailboxAddressRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChangeMailboxAddressRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'confirm'), 'Required key "ChangeMailboxAddressRequest[confirm]" is missing from JSON.');
        assert(json[r'confirm'] != null, 'Required key "ChangeMailboxAddressRequest[confirm]" has a null value in JSON.');
        assert(json.containsKey(r'expected_address'), 'Required key "ChangeMailboxAddressRequest[expected_address]" is missing from JSON.');
        assert(json[r'expected_address'] != null, 'Required key "ChangeMailboxAddressRequest[expected_address]" has a null value in JSON.');
        return true;
      }());

      return ChangeMailboxAddressRequest(
        confirm: mapValueOfType<bool>(json, r'confirm')!,
        expectedAddress: mapValueOfType<String>(json, r'expected_address')!,
        username: mapValueOfType<String>(json, r'username'),
        domain: mapValueOfType<String>(json, r'domain'),
        keepOldAsAlias: mapValueOfType<bool>(json, r'keep_old_as_alias') ?? false,
        accountId: mapValueOfType<String>(json, r'account_id'),
        reason: mapValueOfType<String>(json, r'reason'),
      );
    }
    return null;
  }

  static List<ChangeMailboxAddressRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChangeMailboxAddressRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChangeMailboxAddressRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChangeMailboxAddressRequest> mapFromJson(dynamic json) {
    final map = <String, ChangeMailboxAddressRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChangeMailboxAddressRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChangeMailboxAddressRequest-objects as value to a dart map
  static Map<String, List<ChangeMailboxAddressRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChangeMailboxAddressRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChangeMailboxAddressRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'confirm',
    'expected_address',
  };
}

