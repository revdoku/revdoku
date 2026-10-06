//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class EmailDomainCheck {
  /// Returns a new [EmailDomainCheck] instance.
  EmailDomainCheck({
    required this.hostname,
    required this.rootDomain,
    this.suggestedSubdomain,
    this.rootGuidance,
  });

  String hostname;

  bool rootDomain;

  String? suggestedSubdomain;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? rootGuidance;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailDomainCheck &&
    other.hostname == hostname &&
    other.rootDomain == rootDomain &&
    other.suggestedSubdomain == suggestedSubdomain &&
    other.rootGuidance == rootGuidance;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (hostname.hashCode) +
    (rootDomain.hashCode) +
    (suggestedSubdomain == null ? 0 : suggestedSubdomain!.hashCode) +
    (rootGuidance == null ? 0 : rootGuidance!.hashCode);

  @override
  String toString() => 'EmailDomainCheck[hostname=$hostname, rootDomain=$rootDomain, suggestedSubdomain=$suggestedSubdomain, rootGuidance=$rootGuidance]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'hostname'] = this.hostname;
      json[r'root_domain'] = this.rootDomain;
    if (this.suggestedSubdomain != null) {
      json[r'suggested_subdomain'] = this.suggestedSubdomain;
    } else {
      json[r'suggested_subdomain'] = null;
    }
    if (this.rootGuidance != null) {
      json[r'root_guidance'] = this.rootGuidance;
    }
    return json;
  }

  /// Returns a new [EmailDomainCheck] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailDomainCheck? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'hostname'), 'Required key "EmailDomainCheck[hostname]" is missing from JSON.');
        assert(json[r'hostname'] != null, 'Required key "EmailDomainCheck[hostname]" has a null value in JSON.');
        assert(json.containsKey(r'root_domain'), 'Required key "EmailDomainCheck[root_domain]" is missing from JSON.');
        assert(json[r'root_domain'] != null, 'Required key "EmailDomainCheck[root_domain]" has a null value in JSON.');
        return true;
      }());

      return EmailDomainCheck(
        hostname: mapValueOfType<String>(json, r'hostname')!,
        rootDomain: mapValueOfType<bool>(json, r'root_domain')!,
        suggestedSubdomain: mapValueOfType<String>(json, r'suggested_subdomain'),
        rootGuidance: mapValueOfType<String>(json, r'root_guidance'),
      );
    }
    return null;
  }

  static List<EmailDomainCheck> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailDomainCheck>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailDomainCheck.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailDomainCheck> mapFromJson(dynamic json) {
    final map = <String, EmailDomainCheck>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailDomainCheck.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailDomainCheck-objects as value to a dart map
  static Map<String, List<EmailDomainCheck>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailDomainCheck>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailDomainCheck.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'hostname',
    'root_domain',
  };
}

