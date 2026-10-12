//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class DeleteEmailDomainRequest {
  /// Returns a new [DeleteEmailDomainRequest] instance.
  DeleteEmailDomainRequest({
    required this.hostname,
    required this.confirm,
    this.accountId,
    this.reason,
  });

  String hostname;

  bool confirm;

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
  bool operator ==(Object other) => identical(this, other) || other is DeleteEmailDomainRequest &&
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
  String toString() => 'DeleteEmailDomainRequest[hostname=$hostname, confirm=$confirm, accountId=$accountId, reason=$reason]';

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

  /// Returns a new [DeleteEmailDomainRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DeleteEmailDomainRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'hostname'), 'Required key "DeleteEmailDomainRequest[hostname]" is missing from JSON.');
        assert(json[r'hostname'] != null, 'Required key "DeleteEmailDomainRequest[hostname]" has a null value in JSON.');
        assert(json.containsKey(r'confirm'), 'Required key "DeleteEmailDomainRequest[confirm]" is missing from JSON.');
        assert(json[r'confirm'] != null, 'Required key "DeleteEmailDomainRequest[confirm]" has a null value in JSON.');
        return true;
      }());

      return DeleteEmailDomainRequest(
        hostname: mapValueOfType<String>(json, r'hostname')!,
        confirm: mapValueOfType<bool>(json, r'confirm')!,
        accountId: mapValueOfType<String>(json, r'account_id'),
        reason: mapValueOfType<String>(json, r'reason'),
      );
    }
    return null;
  }

  static List<DeleteEmailDomainRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DeleteEmailDomainRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DeleteEmailDomainRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DeleteEmailDomainRequest> mapFromJson(dynamic json) {
    final map = <String, DeleteEmailDomainRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DeleteEmailDomainRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DeleteEmailDomainRequest-objects as value to a dart map
  static Map<String, List<DeleteEmailDomainRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DeleteEmailDomainRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DeleteEmailDomainRequest.listFromJson(entry.value, growable: growable,);
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

