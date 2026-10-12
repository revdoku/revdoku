//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class GetEmailOriginalDownload200ResponseData {
  /// Returns a new [GetEmailOriginalDownload200ResponseData] instance.
  GetEmailOriginalDownload200ResponseData({
    required this.download,
  });

  Download download;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetEmailOriginalDownload200ResponseData &&
    other.download == download;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (download.hashCode);

  @override
  String toString() => 'GetEmailOriginalDownload200ResponseData[download=$download]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'download'] = this.download;
    return json;
  }

  /// Returns a new [GetEmailOriginalDownload200ResponseData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetEmailOriginalDownload200ResponseData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'download'), 'Required key "GetEmailOriginalDownload200ResponseData[download]" is missing from JSON.');
        assert(json[r'download'] != null, 'Required key "GetEmailOriginalDownload200ResponseData[download]" has a null value in JSON.');
        return true;
      }());

      return GetEmailOriginalDownload200ResponseData(
        download: Download.fromJson(json[r'download'])!,
      );
    }
    return null;
  }

  static List<GetEmailOriginalDownload200ResponseData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetEmailOriginalDownload200ResponseData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetEmailOriginalDownload200ResponseData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetEmailOriginalDownload200ResponseData> mapFromJson(dynamic json) {
    final map = <String, GetEmailOriginalDownload200ResponseData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetEmailOriginalDownload200ResponseData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetEmailOriginalDownload200ResponseData-objects as value to a dart map
  static Map<String, List<GetEmailOriginalDownload200ResponseData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetEmailOriginalDownload200ResponseData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetEmailOriginalDownload200ResponseData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'download',
  };
}

