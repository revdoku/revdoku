//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class MailboxEmailSettingsAvailableDomainsInner {
  /// Returns a new [MailboxEmailSettingsAvailableDomainsInner] instance.
  MailboxEmailSettingsAvailableDomainsInner({
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

  MailboxEmailSettingsAvailableDomainsInnerKindEnum? kind;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MailboxEmailSettingsAvailableDomainsInner &&
    other.hostname == hostname &&
    other.kind == kind;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (hostname == null ? 0 : hostname!.hashCode) +
    (kind == null ? 0 : kind!.hashCode);

  @override
  String toString() => 'MailboxEmailSettingsAvailableDomainsInner[hostname=$hostname, kind=$kind]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.hostname != null) {
      json[r'hostname'] = this.hostname;
    }
    if (this.kind != null) {
      json[r'kind'] = this.kind;
    }
    return json;
  }

  /// Returns a new [MailboxEmailSettingsAvailableDomainsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MailboxEmailSettingsAvailableDomainsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return MailboxEmailSettingsAvailableDomainsInner(
        hostname: mapValueOfType<String>(json, r'hostname'),
        kind: MailboxEmailSettingsAvailableDomainsInnerKindEnum.fromJson(json[r'kind']),
      );
    }
    return null;
  }

  static List<MailboxEmailSettingsAvailableDomainsInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MailboxEmailSettingsAvailableDomainsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MailboxEmailSettingsAvailableDomainsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MailboxEmailSettingsAvailableDomainsInner> mapFromJson(dynamic json) {
    final map = <String, MailboxEmailSettingsAvailableDomainsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MailboxEmailSettingsAvailableDomainsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MailboxEmailSettingsAvailableDomainsInner-objects as value to a dart map
  static Map<String, List<MailboxEmailSettingsAvailableDomainsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MailboxEmailSettingsAvailableDomainsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MailboxEmailSettingsAvailableDomainsInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


enum MailboxEmailSettingsAvailableDomainsInnerKindEnum {
  platform._(r'platform'),
  custom._(r'custom'),
  ;

  /// Instantiate a new enum with the provided value.
  const MailboxEmailSettingsAvailableDomainsInnerKindEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [MailboxEmailSettingsAvailableDomainsInnerKindEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static MailboxEmailSettingsAvailableDomainsInnerKindEnum? fromJson(dynamic value) => MailboxEmailSettingsAvailableDomainsInnerKindEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [MailboxEmailSettingsAvailableDomainsInnerKindEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<MailboxEmailSettingsAvailableDomainsInnerKindEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MailboxEmailSettingsAvailableDomainsInnerKindEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MailboxEmailSettingsAvailableDomainsInnerKindEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [MailboxEmailSettingsAvailableDomainsInnerKindEnum] to String,
/// and [decode] dynamic data back to [MailboxEmailSettingsAvailableDomainsInnerKindEnum].
class MailboxEmailSettingsAvailableDomainsInnerKindEnumTypeTransformer {
  factory MailboxEmailSettingsAvailableDomainsInnerKindEnumTypeTransformer() => _instance ??= const MailboxEmailSettingsAvailableDomainsInnerKindEnumTypeTransformer._();

  const MailboxEmailSettingsAvailableDomainsInnerKindEnumTypeTransformer._();

  String encode(MailboxEmailSettingsAvailableDomainsInnerKindEnum data) => data._value;

  /// Returns the instance of [MailboxEmailSettingsAvailableDomainsInnerKindEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  MailboxEmailSettingsAvailableDomainsInnerKindEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is MailboxEmailSettingsAvailableDomainsInnerKindEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'platform': return MailboxEmailSettingsAvailableDomainsInnerKindEnum.platform;
        case r'custom': return MailboxEmailSettingsAvailableDomainsInnerKindEnum.custom;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static MailboxEmailSettingsAvailableDomainsInnerKindEnumTypeTransformer? _instance;
}


