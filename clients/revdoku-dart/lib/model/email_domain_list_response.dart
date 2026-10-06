//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class EmailDomainListResponse {
  /// Returns a new [EmailDomainListResponse] instance.
  EmailDomainListResponse({
    required this.success,
    required this.data,
  });

  bool success;

  EmailDomainList data;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailDomainListResponse &&
    other.success == success &&
    other.data == data;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (success.hashCode) +
    (data.hashCode);

  @override
  String toString() => 'EmailDomainListResponse[success=$success, data=$data]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'success'] = this.success;
      json[r'data'] = this.data;
    return json;
  }

  /// Returns a new [EmailDomainListResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailDomainListResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'success'), 'Required key "EmailDomainListResponse[success]" is missing from JSON.');
        assert(json[r'success'] != null, 'Required key "EmailDomainListResponse[success]" has a null value in JSON.');
        assert(json.containsKey(r'data'), 'Required key "EmailDomainListResponse[data]" is missing from JSON.');
        assert(json[r'data'] != null, 'Required key "EmailDomainListResponse[data]" has a null value in JSON.');
        return true;
      }());

      return EmailDomainListResponse(
        success: mapValueOfType<bool>(json, r'success')!,
        data: EmailDomainList.fromJson(json[r'data'])!,
      );
    }
    return null;
  }

  static List<EmailDomainListResponse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailDomainListResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailDomainListResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailDomainListResponse> mapFromJson(dynamic json) {
    final map = <String, EmailDomainListResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailDomainListResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailDomainListResponse-objects as value to a dart map
  static Map<String, List<EmailDomainListResponse>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailDomainListResponse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailDomainListResponse.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'success',
    'data',
  };
}

