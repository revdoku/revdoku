//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class MailboxEmailAvailableDomainsInner {
  /// Returns a new [MailboxEmailAvailableDomainsInner] instance.
  MailboxEmailAvailableDomainsInner({
    this.hostname,
    this.kind,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? hostname;

  MailboxEmailAvailableDomainsInnerKindEnum? kind;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MailboxEmailAvailableDomainsInner &&
    other.hostname == hostname &&
    other.kind == kind;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (hostname == null ? 0 : hostname!.hashCode) +
    (kind == null ? 0 : kind!.hashCode);

  @override
  String toString() => 'MailboxEmailAvailableDomainsInner[hostname=$hostname, kind=$kind]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.hostname != null) {
      json[r'hostname'] = this.hostname;
    } else {
      json[r'hostname'] = null;
    }
    if (this.kind != null) {
      json[r'kind'] = this.kind;
    } else {
      json[r'kind'] = null;
    }
    return json;
  }

  /// Returns a new [MailboxEmailAvailableDomainsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MailboxEmailAvailableDomainsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return MailboxEmailAvailableDomainsInner(
        hostname: mapValueOfType<String>(json, r'hostname'),
        kind: MailboxEmailAvailableDomainsInnerKindEnum.fromJson(json[r'kind']),
      );
    }
    return null;
  }

  static List<MailboxEmailAvailableDomainsInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MailboxEmailAvailableDomainsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MailboxEmailAvailableDomainsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MailboxEmailAvailableDomainsInner> mapFromJson(dynamic json) {
    final map = <String, MailboxEmailAvailableDomainsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MailboxEmailAvailableDomainsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MailboxEmailAvailableDomainsInner-objects as value to a dart map
  static Map<String, List<MailboxEmailAvailableDomainsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MailboxEmailAvailableDomainsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MailboxEmailAvailableDomainsInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


enum MailboxEmailAvailableDomainsInnerKindEnum {
  platform._(r'platform'),
  custom._(r'custom'),
  ;

  /// Instantiate a new enum with the provided value.
  const MailboxEmailAvailableDomainsInnerKindEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [MailboxEmailAvailableDomainsInnerKindEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static MailboxEmailAvailableDomainsInnerKindEnum? fromJson(dynamic value) => MailboxEmailAvailableDomainsInnerKindEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [MailboxEmailAvailableDomainsInnerKindEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<MailboxEmailAvailableDomainsInnerKindEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MailboxEmailAvailableDomainsInnerKindEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MailboxEmailAvailableDomainsInnerKindEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [MailboxEmailAvailableDomainsInnerKindEnum] to String,
/// and [decode] dynamic data back to [MailboxEmailAvailableDomainsInnerKindEnum].
class MailboxEmailAvailableDomainsInnerKindEnumTypeTransformer {
  factory MailboxEmailAvailableDomainsInnerKindEnumTypeTransformer() => _instance ??= const MailboxEmailAvailableDomainsInnerKindEnumTypeTransformer._();

  const MailboxEmailAvailableDomainsInnerKindEnumTypeTransformer._();

  String encode(MailboxEmailAvailableDomainsInnerKindEnum data) => data._value;

  /// Returns the instance of [MailboxEmailAvailableDomainsInnerKindEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  MailboxEmailAvailableDomainsInnerKindEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is MailboxEmailAvailableDomainsInnerKindEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'platform': return MailboxEmailAvailableDomainsInnerKindEnum.platform;
        case r'custom': return MailboxEmailAvailableDomainsInnerKindEnum.custom;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static MailboxEmailAvailableDomainsInnerKindEnumTypeTransformer? _instance;
}


