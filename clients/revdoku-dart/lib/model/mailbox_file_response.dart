//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class MailboxFileResponse {
  /// Returns a new [MailboxFileResponse] instance.
  MailboxFileResponse({
    required this.success,
    required this.data,
  });

  bool success;

  MailboxFileResponseData data;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MailboxFileResponse &&
    other.success == success &&
    other.data == data;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (success.hashCode) +
    (data.hashCode);

  @override
  String toString() => 'MailboxFileResponse[success=$success, data=$data]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'success'] = this.success;
      json[r'data'] = this.data;
    return json;
  }

  /// Returns a new [MailboxFileResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MailboxFileResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'success'), 'Required key "MailboxFileResponse[success]" is missing from JSON.');
        assert(json[r'success'] != null, 'Required key "MailboxFileResponse[success]" has a null value in JSON.');
        assert(json.containsKey(r'data'), 'Required key "MailboxFileResponse[data]" is missing from JSON.');
        assert(json[r'data'] != null, 'Required key "MailboxFileResponse[data]" has a null value in JSON.');
        return true;
      }());

      return MailboxFileResponse(
        success: mapValueOfType<bool>(json, r'success')!,
        data: MailboxFileResponseData.fromJson(json[r'data'])!,
      );
    }
    return null;
  }

  static List<MailboxFileResponse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MailboxFileResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MailboxFileResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MailboxFileResponse> mapFromJson(dynamic json) {
    final map = <String, MailboxFileResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MailboxFileResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MailboxFileResponse-objects as value to a dart map
  static Map<String, List<MailboxFileResponse>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MailboxFileResponse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MailboxFileResponse.listFromJson(entry.value, growable: growable,);
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

