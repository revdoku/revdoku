//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class MailboxLockLockedByApiKey {
  /// Returns a new [MailboxLockLockedByApiKey] instance.
  MailboxLockLockedByApiKey({
    this.id,
    this.label,
    this.tokenType,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? label;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? tokenType;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MailboxLockLockedByApiKey &&
    other.id == id &&
    other.label == label &&
    other.tokenType == tokenType;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (label == null ? 0 : label!.hashCode) +
    (tokenType == null ? 0 : tokenType!.hashCode);

  @override
  String toString() => 'MailboxLockLockedByApiKey[id=$id, label=$label, tokenType=$tokenType]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    }
    if (this.label != null) {
      json[r'label'] = this.label;
    }
    if (this.tokenType != null) {
      json[r'token_type'] = this.tokenType;
    }
    return json;
  }

  /// Returns a new [MailboxLockLockedByApiKey] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MailboxLockLockedByApiKey? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return MailboxLockLockedByApiKey(
        id: mapValueOfType<String>(json, r'id'),
        label: mapValueOfType<String>(json, r'label'),
        tokenType: mapValueOfType<String>(json, r'token_type'),
      );
    }
    return null;
  }

  static List<MailboxLockLockedByApiKey> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MailboxLockLockedByApiKey>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MailboxLockLockedByApiKey.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MailboxLockLockedByApiKey> mapFromJson(dynamic json) {
    final map = <String, MailboxLockLockedByApiKey>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MailboxLockLockedByApiKey.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MailboxLockLockedByApiKey-objects as value to a dart map
  static Map<String, List<MailboxLockLockedByApiKey>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MailboxLockLockedByApiKey>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MailboxLockLockedByApiKey.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

