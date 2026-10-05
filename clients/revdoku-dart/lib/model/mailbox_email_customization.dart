//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class MailboxEmailCustomization {
  /// Returns a new [MailboxEmailCustomization] instance.
  MailboxEmailCustomization({
    this.allowed,
    this.blockedReason,
    this.settingsUrl,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? allowed;

  String? blockedReason;

  /// Account-domain settings link for administrators; null otherwise.
  String? settingsUrl;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MailboxEmailCustomization &&
    other.allowed == allowed &&
    other.blockedReason == blockedReason &&
    other.settingsUrl == settingsUrl;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (allowed == null ? 0 : allowed!.hashCode) +
    (blockedReason == null ? 0 : blockedReason!.hashCode) +
    (settingsUrl == null ? 0 : settingsUrl!.hashCode);

  @override
  String toString() => 'MailboxEmailCustomization[allowed=$allowed, blockedReason=$blockedReason, settingsUrl=$settingsUrl]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.allowed != null) {
      json[r'allowed'] = this.allowed;
    }
    if (this.blockedReason != null) {
      json[r'blocked_reason'] = this.blockedReason;
    } else {
      json[r'blocked_reason'] = null;
    }
    if (this.settingsUrl != null) {
      json[r'settings_url'] = this.settingsUrl;
    } else {
      json[r'settings_url'] = null;
    }
    return json;
  }

  /// Returns a new [MailboxEmailCustomization] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MailboxEmailCustomization? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return MailboxEmailCustomization(
        allowed: mapValueOfType<bool>(json, r'allowed'),
        blockedReason: mapValueOfType<String>(json, r'blocked_reason'),
        settingsUrl: mapValueOfType<String>(json, r'settings_url'),
      );
    }
    return null;
  }

  static List<MailboxEmailCustomization> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MailboxEmailCustomization>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MailboxEmailCustomization.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MailboxEmailCustomization> mapFromJson(dynamic json) {
    final map = <String, MailboxEmailCustomization>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MailboxEmailCustomization.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MailboxEmailCustomization-objects as value to a dart map
  static Map<String, List<MailboxEmailCustomization>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MailboxEmailCustomization>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MailboxEmailCustomization.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

