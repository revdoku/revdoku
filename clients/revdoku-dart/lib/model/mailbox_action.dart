//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class MailboxAction {
  /// Returns a new [MailboxAction] instance.
  MailboxAction({
    required this.allowed,
    this.blockedReason,
    this.requiredAction,
    this.confirmation,
  });

  bool allowed;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? blockedReason;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? requiredAction;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? confirmation;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MailboxAction &&
    other.allowed == allowed &&
    other.blockedReason == blockedReason &&
    other.requiredAction == requiredAction &&
    other.confirmation == confirmation;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (allowed.hashCode) +
    (blockedReason == null ? 0 : blockedReason!.hashCode) +
    (requiredAction == null ? 0 : requiredAction!.hashCode) +
    (confirmation == null ? 0 : confirmation!.hashCode);

  @override
  String toString() => 'MailboxAction[allowed=$allowed, blockedReason=$blockedReason, requiredAction=$requiredAction, confirmation=$confirmation]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'allowed'] = this.allowed;
    if (this.blockedReason != null) {
      json[r'blocked_reason'] = this.blockedReason;
    }
    if (this.requiredAction != null) {
      json[r'required_action'] = this.requiredAction;
    }
    if (this.confirmation != null) {
      json[r'confirmation'] = this.confirmation;
    }
    return json;
  }

  /// Returns a new [MailboxAction] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MailboxAction? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'allowed'), 'Required key "MailboxAction[allowed]" is missing from JSON.');
        assert(json[r'allowed'] != null, 'Required key "MailboxAction[allowed]" has a null value in JSON.');
        return true;
      }());

      return MailboxAction(
        allowed: mapValueOfType<bool>(json, r'allowed')!,
        blockedReason: mapValueOfType<String>(json, r'blocked_reason'),
        requiredAction: mapValueOfType<String>(json, r'required_action'),
        confirmation: mapValueOfType<String>(json, r'confirmation'),
      );
    }
    return null;
  }

  static List<MailboxAction> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MailboxAction>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MailboxAction.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MailboxAction> mapFromJson(dynamic json) {
    final map = <String, MailboxAction>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MailboxAction.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MailboxAction-objects as value to a dart map
  static Map<String, List<MailboxAction>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MailboxAction>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MailboxAction.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'allowed',
  };
}

