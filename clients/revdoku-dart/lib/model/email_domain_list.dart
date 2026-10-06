//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class EmailDomainList {
  /// Returns a new [EmailDomainList] instance.
  EmailDomainList({
    this.domains = const [],
    this.enabled,
    this.configured,
    this.limit,
    this.usage,
    this.guidance,
  });

  List<EmailDomain> domains;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? enabled;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? configured;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? limit;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  EmailUsage? usage;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? guidance;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailDomainList &&
    _deepEquality.equals(other.domains, domains) &&
    other.enabled == enabled &&
    other.configured == configured &&
    other.limit == limit &&
    other.usage == usage &&
    other.guidance == guidance;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (domains.hashCode) +
    (enabled == null ? 0 : enabled!.hashCode) +
    (configured == null ? 0 : configured!.hashCode) +
    (limit == null ? 0 : limit!.hashCode) +
    (usage == null ? 0 : usage!.hashCode) +
    (guidance == null ? 0 : guidance!.hashCode);

  @override
  String toString() => 'EmailDomainList[domains=$domains, enabled=$enabled, configured=$configured, limit=$limit, usage=$usage, guidance=$guidance]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'domains'] = this.domains;
    if (this.enabled != null) {
      json[r'enabled'] = this.enabled;
    }
    if (this.configured != null) {
      json[r'configured'] = this.configured;
    }
    if (this.limit != null) {
      json[r'limit'] = this.limit;
    }
    if (this.usage != null) {
      json[r'usage'] = this.usage;
    }
    if (this.guidance != null) {
      json[r'guidance'] = this.guidance;
    }
    return json;
  }

  /// Returns a new [EmailDomainList] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailDomainList? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'domains'), 'Required key "EmailDomainList[domains]" is missing from JSON.');
        assert(json[r'domains'] != null, 'Required key "EmailDomainList[domains]" has a null value in JSON.');
        return true;
      }());

      return EmailDomainList(
        domains: EmailDomain.listFromJson(json[r'domains']),
        enabled: mapValueOfType<bool>(json, r'enabled'),
        configured: mapValueOfType<bool>(json, r'configured'),
        limit: mapValueOfType<int>(json, r'limit'),
        usage: EmailUsage.fromJson(json[r'usage']),
        guidance: mapValueOfType<String>(json, r'guidance'),
      );
    }
    return null;
  }

  static List<EmailDomainList> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailDomainList>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailDomainList.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailDomainList> mapFromJson(dynamic json) {
    final map = <String, EmailDomainList>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailDomainList.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailDomainList-objects as value to a dart map
  static Map<String, List<EmailDomainList>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailDomainList>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailDomainList.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'domains',
  };
}

