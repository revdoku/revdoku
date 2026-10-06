//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class StorageUpload {
  /// Returns a new [StorageUpload] instance.
  StorageUpload({
    required this.url,
    this.headers = const {},
  });

  String url;

  Map<String, String> headers;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StorageUpload &&
    other.url == url &&
    _deepEquality.equals(other.headers, headers);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (url.hashCode) +
    (headers.hashCode);

  @override
  String toString() => 'StorageUpload[url=$url, headers=$headers]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'url'] = this.url;
      json[r'headers'] = this.headers;
    return json;
  }

  /// Returns a new [StorageUpload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StorageUpload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'url'), 'Required key "StorageUpload[url]" is missing from JSON.');
        assert(json[r'url'] != null, 'Required key "StorageUpload[url]" has a null value in JSON.');
        assert(json.containsKey(r'headers'), 'Required key "StorageUpload[headers]" is missing from JSON.');
        assert(json[r'headers'] != null, 'Required key "StorageUpload[headers]" has a null value in JSON.');
        return true;
      }());

      return StorageUpload(
        url: mapValueOfType<String>(json, r'url')!,
        headers: mapCastOfType<String, String>(json, r'headers')!,
      );
    }
    return null;
  }

  static List<StorageUpload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StorageUpload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StorageUpload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StorageUpload> mapFromJson(dynamic json) {
    final map = <String, StorageUpload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StorageUpload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StorageUpload-objects as value to a dart map
  static Map<String, List<StorageUpload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StorageUpload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StorageUpload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'url',
    'headers',
  };
}

