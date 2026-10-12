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
    required this.enabled,
    this.guidance,
    required this.pagination,
  });

  List<EmailDomain> domains;

  /// Whether this account can use custom email domains.
  bool enabled;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? guidance;

  Pagination pagination;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailDomainList &&
    _deepEquality.equals(other.domains, domains) &&
    other.enabled == enabled &&
    other.guidance == guidance &&
    other.pagination == pagination;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (domains.hashCode) +
    (enabled.hashCode) +
    (guidance == null ? 0 : guidance!.hashCode) +
    (pagination.hashCode);

  @override
  String toString() => 'EmailDomainList[domains=$domains, enabled=$enabled, guidance=$guidance, pagination=$pagination]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'domains'] = this.domains;
      json[r'enabled'] = this.enabled;
    if (this.guidance != null) {
      json[r'guidance'] = this.guidance;
    }
      json[r'pagination'] = this.pagination;
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
        assert(json.containsKey(r'enabled'), 'Required key "EmailDomainList[enabled]" is missing from JSON.');
        assert(json[r'enabled'] != null, 'Required key "EmailDomainList[enabled]" has a null value in JSON.');
        assert(json.containsKey(r'pagination'), 'Required key "EmailDomainList[pagination]" is missing from JSON.');
        assert(json[r'pagination'] != null, 'Required key "EmailDomainList[pagination]" has a null value in JSON.');
        return true;
      }());

      return EmailDomainList(
        domains: EmailDomain.listFromJson(json[r'domains']),
        enabled: mapValueOfType<bool>(json, r'enabled')!,
        guidance: mapValueOfType<String>(json, r'guidance'),
        pagination: Pagination.fromJson(json[r'pagination'])!,
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
    'enabled',
    'pagination',
  };
}

