//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class MailboxEmailOptions {
  /// Returns a new [MailboxEmailOptions] instance.
  MailboxEmailOptions({
    this.username,
    this.domain,
  });

  /// Free: a prefix normalized to dots, shortened to 51 characters, with a permanent 12-character random lowercase letter/digit suffix added. Paid: the exact name before @, normalized to lowercase. Omit to generate; blank/null is invalid. Reserved shared-domain words return EMAIL_NAME_RESERVED with the reserved word and custom-domain guidance; occupied or retired exact names return EMAIL_ALREADY_EXISTS.
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
  bool operator ==(Object other) => identical(this, other) || other is MailboxEmailOptions &&
    other.username == username &&
    other.domain == domain;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (username == null ? 0 : username!.hashCode) +
    (domain == null ? 0 : domain!.hashCode);

  @override
  String toString() => 'MailboxEmailOptions[username=$username, domain=$domain]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.username != null) {
      json[r'username'] = this.username;
    }
    if (this.domain != null) {
      json[r'domain'] = this.domain;
    }
    return json;
  }

  /// Returns a new [MailboxEmailOptions] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MailboxEmailOptions? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return MailboxEmailOptions(
        username: mapValueOfType<String>(json, r'username'),
        domain: mapValueOfType<String>(json, r'domain'),
      );
    }
    return null;
  }

  static List<MailboxEmailOptions> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MailboxEmailOptions>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MailboxEmailOptions.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MailboxEmailOptions> mapFromJson(dynamic json) {
    final map = <String, MailboxEmailOptions>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MailboxEmailOptions.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MailboxEmailOptions-objects as value to a dart map
  static Map<String, List<MailboxEmailOptions>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MailboxEmailOptions>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MailboxEmailOptions.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

