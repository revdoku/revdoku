//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class CreateMailboxRequestMailboxEmail {
  /// Returns a new [CreateMailboxRequestMailboxEmail] instance.
  CreateMailboxRequestMailboxEmail({
    this.username,
    this.domain,
  });

  /// Name before @. Normalized to lowercase. Omit to generate; blank/null is invalid. Reserved platform names return EMAIL_NAME_RESERVED; occupied or retired names return EMAIL_ALREADY_EXISTS.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? username;

  /// Built-in domain such as revdokumail.com on any plan, or a ready custom email domain owned by the selected account on an eligible plan. Omit for the default platform domain.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? domain;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CreateMailboxRequestMailboxEmail &&
    other.username == username &&
    other.domain == domain;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (username == null ? 0 : username!.hashCode) +
    (domain == null ? 0 : domain!.hashCode);

  @override
  String toString() => 'CreateMailboxRequestMailboxEmail[username=$username, domain=$domain]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.username != null) {
      json[r'username'] = this.username;
    } else {
      json[r'username'] = null;
    }
    if (this.domain != null) {
      json[r'domain'] = this.domain;
    } else {
      json[r'domain'] = null;
    }
    return json;
  }

  /// Returns a new [CreateMailboxRequestMailboxEmail] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CreateMailboxRequestMailboxEmail? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return CreateMailboxRequestMailboxEmail(
        username: mapValueOfType<String>(json, r'username'),
        domain: mapValueOfType<String>(json, r'domain'),
      );
    }
    return null;
  }

  static List<CreateMailboxRequestMailboxEmail> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateMailboxRequestMailboxEmail>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateMailboxRequestMailboxEmail.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CreateMailboxRequestMailboxEmail> mapFromJson(dynamic json) {
    final map = <String, CreateMailboxRequestMailboxEmail>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateMailboxRequestMailboxEmail.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CreateMailboxRequestMailboxEmail-objects as value to a dart map
  static Map<String, List<CreateMailboxRequestMailboxEmail>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CreateMailboxRequestMailboxEmail>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CreateMailboxRequestMailboxEmail.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

