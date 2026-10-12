//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class Download {
  /// Returns a new [Download] instance.
  Download({
    required this.url,
    required this.filename,
    required this.contentType,
    required this.expiresIn,
    required this.sizeBytes,
  });

  String url;

  String filename;

  String? contentType;

  /// Seconds until the link expires.
  DownloadExpiresInEnum expiresIn;

  /// Minimum value: 0
  int sizeBytes;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Download &&
    other.url == url &&
    other.filename == filename &&
    other.contentType == contentType &&
    other.expiresIn == expiresIn &&
    other.sizeBytes == sizeBytes;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (url.hashCode) +
    (filename.hashCode) +
    (contentType == null ? 0 : contentType!.hashCode) +
    (expiresIn.hashCode) +
    (sizeBytes.hashCode);

  @override
  String toString() => 'Download[url=$url, filename=$filename, contentType=$contentType, expiresIn=$expiresIn, sizeBytes=$sizeBytes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'url'] = this.url;
      json[r'filename'] = this.filename;
    if (this.contentType != null) {
      json[r'content_type'] = this.contentType;
    } else {
      json[r'content_type'] = null;
    }
      json[r'expires_in'] = this.expiresIn;
      json[r'size_bytes'] = this.sizeBytes;
    return json;
  }

  /// Returns a new [Download] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Download? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'url'), 'Required key "Download[url]" is missing from JSON.');
        assert(json[r'url'] != null, 'Required key "Download[url]" has a null value in JSON.');
        assert(json.containsKey(r'filename'), 'Required key "Download[filename]" is missing from JSON.');
        assert(json[r'filename'] != null, 'Required key "Download[filename]" has a null value in JSON.');
        assert(json.containsKey(r'content_type'), 'Required key "Download[content_type]" is missing from JSON.');
        assert(json.containsKey(r'expires_in'), 'Required key "Download[expires_in]" is missing from JSON.');
        assert(json[r'expires_in'] != null, 'Required key "Download[expires_in]" has a null value in JSON.');
        assert(json.containsKey(r'size_bytes'), 'Required key "Download[size_bytes]" is missing from JSON.');
        assert(json[r'size_bytes'] != null, 'Required key "Download[size_bytes]" has a null value in JSON.');
        return true;
      }());

      return Download(
        url: mapValueOfType<String>(json, r'url')!,
        filename: mapValueOfType<String>(json, r'filename')!,
        contentType: mapValueOfType<String>(json, r'content_type'),
        expiresIn: DownloadExpiresInEnum.fromJson(json[r'expires_in'])!,
        sizeBytes: mapValueOfType<int>(json, r'size_bytes')!,
      );
    }
    return null;
  }

  static List<Download> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Download>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Download.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Download> mapFromJson(dynamic json) {
    final map = <String, Download>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Download.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Download-objects as value to a dart map
  static Map<String, List<Download>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Download>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Download.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'url',
    'filename',
    'content_type',
    'expires_in',
    'size_bytes',
  };
}

/// Seconds until the link expires.
enum DownloadExpiresInEnum {
  number900._(900),
  ;

  /// Instantiate a new enum with the provided value.
  const DownloadExpiresInEnum._(this._value);

  /// The underlying value of this enum member.
  final int _value;

  @override
  String toString() => _value.toString();

  /// Encodes this enum as a value suitable for JSON.
  int toJson() => _value;

  /// Returns the instance of [DownloadExpiresInEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static DownloadExpiresInEnum? fromJson(dynamic value) => DownloadExpiresInEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [DownloadExpiresInEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<DownloadExpiresInEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DownloadExpiresInEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DownloadExpiresInEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DownloadExpiresInEnum] to int,
/// and [decode] dynamic data back to [DownloadExpiresInEnum].
class DownloadExpiresInEnumTypeTransformer {
  factory DownloadExpiresInEnumTypeTransformer() => _instance ??= const DownloadExpiresInEnumTypeTransformer._();

  const DownloadExpiresInEnumTypeTransformer._();

  int encode(DownloadExpiresInEnum data) => data._value;

  /// Returns the instance of [DownloadExpiresInEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DownloadExpiresInEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is DownloadExpiresInEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case 900: return DownloadExpiresInEnum.number900;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static DownloadExpiresInEnumTypeTransformer? _instance;
}


