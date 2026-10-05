//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class RemoveAccountEmailDomainRequest {
  /// Returns a new [RemoveAccountEmailDomainRequest] instance.
  RemoveAccountEmailDomainRequest({
    required this.hostname,
    required this.confirm,
    this.accountId,
    this.reason,
  });

  String hostname;

  bool confirm;

  /// Explicit granted account for this call.
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
  bool operator ==(Object other) => identical(this, other) || other is RemoveAccountEmailDomainRequest &&
    other.hostname == hostname &&
    other.confirm == confirm &&
    other.accountId == accountId &&
    other.reason == reason;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (hostname.hashCode) +
    (confirm.hashCode) +
    (accountId == null ? 0 : accountId!.hashCode) +
    (reason == null ? 0 : reason!.hashCode);

  @override
  String toString() => 'RemoveAccountEmailDomainRequest[hostname=$hostname, confirm=$confirm, accountId=$accountId, reason=$reason]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hostname'] = this.hostname;
      json[r'confirm'] = this.confirm;
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

  /// Returns a new [RemoveAccountEmailDomainRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RemoveAccountEmailDomainRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'hostname'), 'Required key "RemoveAccountEmailDomainRequest[hostname]" is missing from JSON.');
        assert(json[r'hostname'] != null, 'Required key "RemoveAccountEmailDomainRequest[hostname]" has a null value in JSON.');
        assert(json.containsKey(r'confirm'), 'Required key "RemoveAccountEmailDomainRequest[confirm]" is missing from JSON.');
        assert(json[r'confirm'] != null, 'Required key "RemoveAccountEmailDomainRequest[confirm]" has a null value in JSON.');
        return true;
      }());

      return RemoveAccountEmailDomainRequest(
        hostname: mapValueOfType<String>(json, r'hostname')!,
        confirm: mapValueOfType<bool>(json, r'confirm')!,
        accountId: mapValueOfType<String>(json, r'account_id'),
        reason: mapValueOfType<String>(json, r'reason'),
      );
    }
    return null;
  }

  static List<RemoveAccountEmailDomainRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RemoveAccountEmailDomainRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RemoveAccountEmailDomainRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RemoveAccountEmailDomainRequest> mapFromJson(dynamic json) {
    final map = <String, RemoveAccountEmailDomainRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RemoveAccountEmailDomainRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RemoveAccountEmailDomainRequest-objects as value to a dart map
  static Map<String, List<RemoveAccountEmailDomainRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RemoveAccountEmailDomainRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RemoveAccountEmailDomainRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'hostname',
    'confirm',
  };
}

