//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class EmailAlias {
  /// Returns a new [EmailAlias] instance.
  EmailAlias({
    required this.id,
    required this.address,
    required this.active,
  });

  String id;

  String address;

  /// Within the current alias allowance. Mailbox receiving holds still apply.
  bool active;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailAlias &&
    other.id == id &&
    other.address == address &&
    other.active == active;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (address.hashCode) +
    (active.hashCode);

  @override
  String toString() => 'EmailAlias[id=$id, address=$address, active=$active]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'address'] = this.address;
      json[r'active'] = this.active;
    return json;
  }

  /// Returns a new [EmailAlias] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailAlias? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "EmailAlias[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "EmailAlias[id]" has a null value in JSON.');
        assert(json.containsKey(r'address'), 'Required key "EmailAlias[address]" is missing from JSON.');
        assert(json[r'address'] != null, 'Required key "EmailAlias[address]" has a null value in JSON.');
        assert(json.containsKey(r'active'), 'Required key "EmailAlias[active]" is missing from JSON.');
        assert(json[r'active'] != null, 'Required key "EmailAlias[active]" has a null value in JSON.');
        return true;
      }());

      return EmailAlias(
        id: mapValueOfType<String>(json, r'id')!,
        address: mapValueOfType<String>(json, r'address')!,
        active: mapValueOfType<bool>(json, r'active')!,
      );
    }
    return null;
  }

  static List<EmailAlias> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailAlias>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailAlias.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailAlias> mapFromJson(dynamic json) {
    final map = <String, EmailAlias>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailAlias.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailAlias-objects as value to a dart map
  static Map<String, List<EmailAlias>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailAlias>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailAlias.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'address',
    'active',
  };
}

