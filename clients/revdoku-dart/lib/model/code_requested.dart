//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class CodeRequested {
  /// Returns a new [CodeRequested] instance.
  CodeRequested({
    this.message,
    this.email,
    this.expiresInSeconds,
    this.fallbackUrl,
    this.hint,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? message;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? email;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? expiresInSeconds;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? fallbackUrl;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? hint;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CodeRequested &&
    other.message == message &&
    other.email == email &&
    other.expiresInSeconds == expiresInSeconds &&
    other.fallbackUrl == fallbackUrl &&
    other.hint == hint;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (message == null ? 0 : message!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (expiresInSeconds == null ? 0 : expiresInSeconds!.hashCode) +
    (fallbackUrl == null ? 0 : fallbackUrl!.hashCode) +
    (hint == null ? 0 : hint!.hashCode);

  @override
  String toString() => 'CodeRequested[message=$message, email=$email, expiresInSeconds=$expiresInSeconds, fallbackUrl=$fallbackUrl, hint=$hint]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.message != null) {
      json[r'message'] = this.message;
    }
    if (this.email != null) {
      json[r'email'] = this.email;
    }
    if (this.expiresInSeconds != null) {
      json[r'expires_in_seconds'] = this.expiresInSeconds;
    }
    if (this.fallbackUrl != null) {
      json[r'fallback_url'] = this.fallbackUrl;
    }
    if (this.hint != null) {
      json[r'hint'] = this.hint;
    }
    return json;
  }

  /// Returns a new [CodeRequested] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CodeRequested? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return CodeRequested(
        message: mapValueOfType<String>(json, r'message'),
        email: mapValueOfType<String>(json, r'email'),
        expiresInSeconds: mapValueOfType<int>(json, r'expires_in_seconds'),
        fallbackUrl: mapValueOfType<String>(json, r'fallback_url'),
        hint: mapValueOfType<String>(json, r'hint'),
      );
    }
    return null;
  }

  static List<CodeRequested> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CodeRequested>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CodeRequested.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CodeRequested> mapFromJson(dynamic json) {
    final map = <String, CodeRequested>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CodeRequested.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CodeRequested-objects as value to a dart map
  static Map<String, List<CodeRequested>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CodeRequested>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CodeRequested.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

