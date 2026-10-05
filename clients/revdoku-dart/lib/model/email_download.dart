//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class EmailDownload {
  /// Returns a new [EmailDownload] instance.
  EmailDownload({
    required this.url,
    required this.authentication,
    required this.filename,
    required this.contentType,
    required this.expiresIn,
    required this.sizeBytes,
  });

  String url;

  EmailDownloadAuthenticationEnum authentication;

  String filename;

  String? contentType;

  EmailDownloadExpiresInEnum expiresIn;

  /// Minimum value: 0
  int sizeBytes;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailDownload &&
    other.url == url &&
    other.authentication == authentication &&
    other.filename == filename &&
    other.contentType == contentType &&
    other.expiresIn == expiresIn &&
    other.sizeBytes == sizeBytes;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (url.hashCode) +
    (authentication.hashCode) +
    (filename.hashCode) +
    (contentType == null ? 0 : contentType!.hashCode) +
    (expiresIn.hashCode) +
    (sizeBytes.hashCode);

  @override
  String toString() => 'EmailDownload[url=$url, authentication=$authentication, filename=$filename, contentType=$contentType, expiresIn=$expiresIn, sizeBytes=$sizeBytes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'url'] = this.url;
      json[r'authentication'] = this.authentication;
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

  /// Returns a new [EmailDownload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailDownload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'url'), 'Required key "EmailDownload[url]" is missing from JSON.');
        assert(json[r'url'] != null, 'Required key "EmailDownload[url]" has a null value in JSON.');
        assert(json.containsKey(r'authentication'), 'Required key "EmailDownload[authentication]" is missing from JSON.');
        assert(json[r'authentication'] != null, 'Required key "EmailDownload[authentication]" has a null value in JSON.');
        assert(json.containsKey(r'filename'), 'Required key "EmailDownload[filename]" is missing from JSON.');
        assert(json[r'filename'] != null, 'Required key "EmailDownload[filename]" has a null value in JSON.');
        assert(json.containsKey(r'content_type'), 'Required key "EmailDownload[content_type]" is missing from JSON.');
        assert(json.containsKey(r'expires_in'), 'Required key "EmailDownload[expires_in]" is missing from JSON.');
        assert(json[r'expires_in'] != null, 'Required key "EmailDownload[expires_in]" has a null value in JSON.');
        assert(json.containsKey(r'size_bytes'), 'Required key "EmailDownload[size_bytes]" is missing from JSON.');
        assert(json[r'size_bytes'] != null, 'Required key "EmailDownload[size_bytes]" has a null value in JSON.');
        return true;
      }());

      return EmailDownload(
        url: mapValueOfType<String>(json, r'url')!,
        authentication: EmailDownloadAuthenticationEnum.fromJson(json[r'authentication'])!,
        filename: mapValueOfType<String>(json, r'filename')!,
        contentType: mapValueOfType<String>(json, r'content_type'),
        expiresIn: EmailDownloadExpiresInEnum.fromJson(json[r'expires_in'])!,
        sizeBytes: mapValueOfType<int>(json, r'size_bytes')!,
      );
    }
    return null;
  }

  static List<EmailDownload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailDownload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailDownload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailDownload> mapFromJson(dynamic json) {
    final map = <String, EmailDownload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailDownload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailDownload-objects as value to a dart map
  static Map<String, List<EmailDownload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailDownload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailDownload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'url',
    'authentication',
    'filename',
    'content_type',
    'expires_in',
    'size_bytes',
  };
}


enum EmailDownloadAuthenticationEnum {
  none._(r'none'),
  ;

  /// Instantiate a new enum with the provided value.
  const EmailDownloadAuthenticationEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [EmailDownloadAuthenticationEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static EmailDownloadAuthenticationEnum? fromJson(dynamic value) => EmailDownloadAuthenticationEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [EmailDownloadAuthenticationEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<EmailDownloadAuthenticationEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailDownloadAuthenticationEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailDownloadAuthenticationEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EmailDownloadAuthenticationEnum] to String,
/// and [decode] dynamic data back to [EmailDownloadAuthenticationEnum].
class EmailDownloadAuthenticationEnumTypeTransformer {
  factory EmailDownloadAuthenticationEnumTypeTransformer() => _instance ??= const EmailDownloadAuthenticationEnumTypeTransformer._();

  const EmailDownloadAuthenticationEnumTypeTransformer._();

  String encode(EmailDownloadAuthenticationEnum data) => data._value;

  /// Returns the instance of [EmailDownloadAuthenticationEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EmailDownloadAuthenticationEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is EmailDownloadAuthenticationEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'none': return EmailDownloadAuthenticationEnum.none;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static EmailDownloadAuthenticationEnumTypeTransformer? _instance;
}



enum EmailDownloadExpiresInEnum {
  number900._(900),
  ;

  /// Instantiate a new enum with the provided value.
  const EmailDownloadExpiresInEnum._(this._value);

  /// The underlying value of this enum member.
  final int _value;

  @override
  String toString() => _value.toString();

  /// Encodes this enum as a value suitable for JSON.
  int toJson() => _value;

  /// Returns the instance of [EmailDownloadExpiresInEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static EmailDownloadExpiresInEnum? fromJson(dynamic value) => EmailDownloadExpiresInEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [EmailDownloadExpiresInEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<EmailDownloadExpiresInEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailDownloadExpiresInEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailDownloadExpiresInEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EmailDownloadExpiresInEnum] to int,
/// and [decode] dynamic data back to [EmailDownloadExpiresInEnum].
class EmailDownloadExpiresInEnumTypeTransformer {
  factory EmailDownloadExpiresInEnumTypeTransformer() => _instance ??= const EmailDownloadExpiresInEnumTypeTransformer._();

  const EmailDownloadExpiresInEnumTypeTransformer._();

  int encode(EmailDownloadExpiresInEnum data) => data._value;

  /// Returns the instance of [EmailDownloadExpiresInEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EmailDownloadExpiresInEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is EmailDownloadExpiresInEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case 900: return EmailDownloadExpiresInEnum.number900;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static EmailDownloadExpiresInEnumTypeTransformer? _instance;
}


