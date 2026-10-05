//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class CreateClientAccountRequest {
  /// Returns a new [CreateClientAccountRequest] instance.
  CreateClientAccountRequest({
    required this.name,
    this.accountId,
    this.clientName,
    this.reason,
  });

  /// Account name.
  String name;

  /// Optional granted Agency account id. Does not change the credential default.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? accountId;

  /// Optional client person or business, separate from the account name. Omit when unknown.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? clientName;

  /// Optional purpose for this action. AI agents should explain intentional reads and changes when known; omit when unknown. Do not include secrets, file contents, or transcripts.
  String? reason;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CreateClientAccountRequest &&
    other.name == name &&
    other.accountId == accountId &&
    other.clientName == clientName &&
    other.reason == reason;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (accountId == null ? 0 : accountId!.hashCode) +
    (clientName == null ? 0 : clientName!.hashCode) +
    (reason == null ? 0 : reason!.hashCode);

  @override
  String toString() => 'CreateClientAccountRequest[name=$name, accountId=$accountId, clientName=$clientName, reason=$reason]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
    if (this.accountId != null) {
      json[r'account_id'] = this.accountId;
    }
    if (this.clientName != null) {
      json[r'client_name'] = this.clientName;
    }
    if (this.reason != null) {
      json[r'reason'] = this.reason;
    } else {
      json[r'reason'] = null;
    }
    return json;
  }

  /// Returns a new [CreateClientAccountRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CreateClientAccountRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'name'), 'Required key "CreateClientAccountRequest[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "CreateClientAccountRequest[name]" has a null value in JSON.');
        return true;
      }());

      return CreateClientAccountRequest(
        name: mapValueOfType<String>(json, r'name')!,
        accountId: mapValueOfType<String>(json, r'account_id'),
        clientName: mapValueOfType<String>(json, r'client_name'),
        reason: mapValueOfType<String>(json, r'reason'),
      );
    }
    return null;
  }

  static List<CreateClientAccountRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateClientAccountRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateClientAccountRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CreateClientAccountRequest> mapFromJson(dynamic json) {
    final map = <String, CreateClientAccountRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateClientAccountRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CreateClientAccountRequest-objects as value to a dart map
  static Map<String, List<CreateClientAccountRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CreateClientAccountRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CreateClientAccountRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
  };
}

