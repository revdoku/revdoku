//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class UploadBlob {
  /// Returns a new [UploadBlob] instance.
  UploadBlob({
    required this.filename,
    required this.byteSize,
    required this.checksum,
    required this.contentType,
    required this.sha256,
    required this.purpose,
  });

  String filename;

  /// Minimum value: 0
  int byteSize;

  String checksum;

  String contentType;

  String sha256;

  UploadBlobPurposeEnum purpose;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UploadBlob &&
    other.filename == filename &&
    other.byteSize == byteSize &&
    other.checksum == checksum &&
    other.contentType == contentType &&
    other.sha256 == sha256 &&
    other.purpose == purpose;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (filename.hashCode) +
    (byteSize.hashCode) +
    (checksum.hashCode) +
    (contentType.hashCode) +
    (sha256.hashCode) +
    (purpose.hashCode);

  @override
  String toString() => 'UploadBlob[filename=$filename, byteSize=$byteSize, checksum=$checksum, contentType=$contentType, sha256=$sha256, purpose=$purpose]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'filename'] = this.filename;
      json[r'byte_size'] = this.byteSize;
      json[r'checksum'] = this.checksum;
      json[r'content_type'] = this.contentType;
      json[r'sha256'] = this.sha256;
      json[r'purpose'] = this.purpose;
    return json;
  }

  /// Returns a new [UploadBlob] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UploadBlob? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'filename'), 'Required key "UploadBlob[filename]" is missing from JSON.');
        assert(json[r'filename'] != null, 'Required key "UploadBlob[filename]" has a null value in JSON.');
        assert(json.containsKey(r'byte_size'), 'Required key "UploadBlob[byte_size]" is missing from JSON.');
        assert(json[r'byte_size'] != null, 'Required key "UploadBlob[byte_size]" has a null value in JSON.');
        assert(json.containsKey(r'checksum'), 'Required key "UploadBlob[checksum]" is missing from JSON.');
        assert(json[r'checksum'] != null, 'Required key "UploadBlob[checksum]" has a null value in JSON.');
        assert(json.containsKey(r'content_type'), 'Required key "UploadBlob[content_type]" is missing from JSON.');
        assert(json[r'content_type'] != null, 'Required key "UploadBlob[content_type]" has a null value in JSON.');
        assert(json.containsKey(r'sha256'), 'Required key "UploadBlob[sha256]" is missing from JSON.');
        assert(json[r'sha256'] != null, 'Required key "UploadBlob[sha256]" has a null value in JSON.');
        assert(json.containsKey(r'purpose'), 'Required key "UploadBlob[purpose]" is missing from JSON.');
        assert(json[r'purpose'] != null, 'Required key "UploadBlob[purpose]" has a null value in JSON.');
        return true;
      }());

      return UploadBlob(
        filename: mapValueOfType<String>(json, r'filename')!,
        byteSize: mapValueOfType<int>(json, r'byte_size')!,
        checksum: mapValueOfType<String>(json, r'checksum')!,
        contentType: mapValueOfType<String>(json, r'content_type')!,
        sha256: mapValueOfType<String>(json, r'sha256')!,
        purpose: UploadBlobPurposeEnum.fromJson(json[r'purpose'])!,
      );
    }
    return null;
  }

  static List<UploadBlob> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UploadBlob>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UploadBlob.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UploadBlob> mapFromJson(dynamic json) {
    final map = <String, UploadBlob>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UploadBlob.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UploadBlob-objects as value to a dart map
  static Map<String, List<UploadBlob>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UploadBlob>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UploadBlob.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'filename',
    'byte_size',
    'checksum',
    'content_type',
    'sha256',
    'purpose',
  };
}


enum UploadBlobPurposeEnum {
  mailboxFile._(r'mailbox_file'),
  ;

  /// Instantiate a new enum with the provided value.
  const UploadBlobPurposeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [UploadBlobPurposeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static UploadBlobPurposeEnum? fromJson(dynamic value) => UploadBlobPurposeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [UploadBlobPurposeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<UploadBlobPurposeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UploadBlobPurposeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UploadBlobPurposeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UploadBlobPurposeEnum] to String,
/// and [decode] dynamic data back to [UploadBlobPurposeEnum].
class UploadBlobPurposeEnumTypeTransformer {
  factory UploadBlobPurposeEnumTypeTransformer() => _instance ??= const UploadBlobPurposeEnumTypeTransformer._();

  const UploadBlobPurposeEnumTypeTransformer._();

  String encode(UploadBlobPurposeEnum data) => data._value;

  /// Returns the instance of [UploadBlobPurposeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UploadBlobPurposeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is UploadBlobPurposeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'mailbox_file': return UploadBlobPurposeEnum.mailboxFile;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static UploadBlobPurposeEnumTypeTransformer? _instance;
}


