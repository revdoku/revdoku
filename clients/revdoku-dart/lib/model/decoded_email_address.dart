//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class DecodedEmailAddress {
  /// Returns a new [DecodedEmailAddress] instance.
  DecodedEmailAddress({
    required this.address,
    required this.name,
  });

  String address;

  String? name;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DecodedEmailAddress &&
    other.address == address &&
    other.name == name;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (address.hashCode) +
    (name == null ? 0 : name!.hashCode);

  @override
  String toString() => 'DecodedEmailAddress[address=$address, name=$name]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'address'] = this.address;
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    return json;
  }

  /// Returns a new [DecodedEmailAddress] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DecodedEmailAddress? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'address'), 'Required key "DecodedEmailAddress[address]" is missing from JSON.');
        assert(json[r'address'] != null, 'Required key "DecodedEmailAddress[address]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "DecodedEmailAddress[name]" is missing from JSON.');
        return true;
      }());

      return DecodedEmailAddress(
        address: mapValueOfType<String>(json, r'address')!,
        name: mapValueOfType<String>(json, r'name'),
      );
    }
    return null;
  }

  static List<DecodedEmailAddress> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DecodedEmailAddress>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DecodedEmailAddress.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DecodedEmailAddress> mapFromJson(dynamic json) {
    final map = <String, DecodedEmailAddress>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DecodedEmailAddress.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DecodedEmailAddress-objects as value to a dart map
  static Map<String, List<DecodedEmailAddress>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DecodedEmailAddress>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DecodedEmailAddress.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'address',
    'name',
  };
}

