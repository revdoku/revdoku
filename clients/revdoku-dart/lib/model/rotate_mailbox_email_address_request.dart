//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class RotateMailboxEmailAddressRequest {
  /// Returns a new [RotateMailboxEmailAddressRequest] instance.
  RotateMailboxEmailAddressRequest({
    required this.confirm,
    required this.currentAddress,
    this.accountId,
    this.domain,
    this.reason,
    this.username,
    this.keepOldAsAlias = false,
  });

  bool confirm;

  String currentAddress;

  /// Explicitly granted account; omission uses credential default
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? accountId;

  /// Exact ready domain of this account, or platform for the deployment default.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? domain;

  /// Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts.
  String? reason;

  /// Administrator-selected name on an available platform or ready owned custom domain. Normalized to lowercase; ASCII letters/digits/dots/hyphens/underscores, alphanumeric endpoints, no consecutive dots. Complete address at most 254 characters. Omit for random rotation; blank/null is invalid.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? username;

  /// Keep the old primary as an alias for this mailbox after activation. Requires full-account administrator access and an available alias slot.
  bool keepOldAsAlias;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RotateMailboxEmailAddressRequest &&
    other.confirm == confirm &&
    other.currentAddress == currentAddress &&
    other.accountId == accountId &&
    other.domain == domain &&
    other.reason == reason &&
    other.username == username &&
    other.keepOldAsAlias == keepOldAsAlias;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (confirm.hashCode) +
    (currentAddress.hashCode) +
    (accountId == null ? 0 : accountId!.hashCode) +
    (domain == null ? 0 : domain!.hashCode) +
    (reason == null ? 0 : reason!.hashCode) +
    (username == null ? 0 : username!.hashCode) +
    (keepOldAsAlias.hashCode);

  @override
  String toString() => 'RotateMailboxEmailAddressRequest[confirm=$confirm, currentAddress=$currentAddress, accountId=$accountId, domain=$domain, reason=$reason, username=$username, keepOldAsAlias=$keepOldAsAlias]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'confirm'] = this.confirm;
      json[r'current_address'] = this.currentAddress;
    if (this.accountId != null) {
      json[r'account_id'] = this.accountId;
    }
    if (this.domain != null) {
      json[r'domain'] = this.domain;
    }
    if (this.reason != null) {
      json[r'reason'] = this.reason;
    } else {
      json[r'reason'] = null;
    }
    if (this.username != null) {
      json[r'username'] = this.username;
    }
      json[r'keep_old_as_alias'] = this.keepOldAsAlias;
    return json;
  }

  /// Returns a new [RotateMailboxEmailAddressRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RotateMailboxEmailAddressRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'confirm'), 'Required key "RotateMailboxEmailAddressRequest[confirm]" is missing from JSON.');
        assert(json[r'confirm'] != null, 'Required key "RotateMailboxEmailAddressRequest[confirm]" has a null value in JSON.');
        assert(json.containsKey(r'current_address'), 'Required key "RotateMailboxEmailAddressRequest[current_address]" is missing from JSON.');
        assert(json[r'current_address'] != null, 'Required key "RotateMailboxEmailAddressRequest[current_address]" has a null value in JSON.');
        return true;
      }());

      return RotateMailboxEmailAddressRequest(
        confirm: mapValueOfType<bool>(json, r'confirm')!,
        currentAddress: mapValueOfType<String>(json, r'current_address')!,
        accountId: mapValueOfType<String>(json, r'account_id'),
        domain: mapValueOfType<String>(json, r'domain'),
        reason: mapValueOfType<String>(json, r'reason'),
        username: mapValueOfType<String>(json, r'username'),
        keepOldAsAlias: mapValueOfType<bool>(json, r'keep_old_as_alias') ?? false,
      );
    }
    return null;
  }

  static List<RotateMailboxEmailAddressRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RotateMailboxEmailAddressRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RotateMailboxEmailAddressRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RotateMailboxEmailAddressRequest> mapFromJson(dynamic json) {
    final map = <String, RotateMailboxEmailAddressRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RotateMailboxEmailAddressRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RotateMailboxEmailAddressRequest-objects as value to a dart map
  static Map<String, List<RotateMailboxEmailAddressRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RotateMailboxEmailAddressRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RotateMailboxEmailAddressRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'confirm',
    'current_address',
  };
}

