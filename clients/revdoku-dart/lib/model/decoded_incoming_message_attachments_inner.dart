//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class DecodedIncomingMessageAttachmentsInner {
  /// Returns a new [DecodedIncomingMessageAttachmentsInner] instance.
  DecodedIncomingMessageAttachmentsInner({
    required this.path,
    required this.originalFilename,
    required this.contentType,
    required this.sizeBytes,
    this.origin,
  });

  /// Relative to message folder.
  String path;

  String originalFilename;

  String contentType;

  /// Minimum value: 0
  int sizeBytes;

  /// For normalized forwards: inner attachment, member addition, attached source EML, or unknown inline-forward origin.
  DecodedIncomingMessageAttachmentsInnerOriginEnum? origin;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DecodedIncomingMessageAttachmentsInner &&
    other.path == path &&
    other.originalFilename == originalFilename &&
    other.contentType == contentType &&
    other.sizeBytes == sizeBytes &&
    other.origin == origin;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (path.hashCode) +
    (originalFilename.hashCode) +
    (contentType.hashCode) +
    (sizeBytes.hashCode) +
    (origin == null ? 0 : origin!.hashCode);

  @override
  String toString() => 'DecodedIncomingMessageAttachmentsInner[path=$path, originalFilename=$originalFilename, contentType=$contentType, sizeBytes=$sizeBytes, origin=$origin]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'path'] = this.path;
      json[r'original_filename'] = this.originalFilename;
      json[r'content_type'] = this.contentType;
      json[r'size_bytes'] = this.sizeBytes;
    if (this.origin != null) {
      json[r'origin'] = this.origin;
    }
    return json;
  }

  /// Returns a new [DecodedIncomingMessageAttachmentsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DecodedIncomingMessageAttachmentsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'path'), 'Required key "DecodedIncomingMessageAttachmentsInner[path]" is missing from JSON.');
        assert(json[r'path'] != null, 'Required key "DecodedIncomingMessageAttachmentsInner[path]" has a null value in JSON.');
        assert(json.containsKey(r'original_filename'), 'Required key "DecodedIncomingMessageAttachmentsInner[original_filename]" is missing from JSON.');
        assert(json[r'original_filename'] != null, 'Required key "DecodedIncomingMessageAttachmentsInner[original_filename]" has a null value in JSON.');
        assert(json.containsKey(r'content_type'), 'Required key "DecodedIncomingMessageAttachmentsInner[content_type]" is missing from JSON.');
        assert(json[r'content_type'] != null, 'Required key "DecodedIncomingMessageAttachmentsInner[content_type]" has a null value in JSON.');
        assert(json.containsKey(r'size_bytes'), 'Required key "DecodedIncomingMessageAttachmentsInner[size_bytes]" is missing from JSON.');
        assert(json[r'size_bytes'] != null, 'Required key "DecodedIncomingMessageAttachmentsInner[size_bytes]" has a null value in JSON.');
        return true;
      }());

      return DecodedIncomingMessageAttachmentsInner(
        path: mapValueOfType<String>(json, r'path')!,
        originalFilename: mapValueOfType<String>(json, r'original_filename')!,
        contentType: mapValueOfType<String>(json, r'content_type')!,
        sizeBytes: mapValueOfType<int>(json, r'size_bytes')!,
        origin: DecodedIncomingMessageAttachmentsInnerOriginEnum.fromJson(json[r'origin']),
      );
    }
    return null;
  }

  static List<DecodedIncomingMessageAttachmentsInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DecodedIncomingMessageAttachmentsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DecodedIncomingMessageAttachmentsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DecodedIncomingMessageAttachmentsInner> mapFromJson(dynamic json) {
    final map = <String, DecodedIncomingMessageAttachmentsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DecodedIncomingMessageAttachmentsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DecodedIncomingMessageAttachmentsInner-objects as value to a dart map
  static Map<String, List<DecodedIncomingMessageAttachmentsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DecodedIncomingMessageAttachmentsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DecodedIncomingMessageAttachmentsInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'path',
    'original_filename',
    'content_type',
    'size_bytes',
  };
}

/// For normalized forwards: inner attachment, member addition, attached source EML, or unknown inline-forward origin.
enum DecodedIncomingMessageAttachmentsInnerOriginEnum {
  original._(r'original'),
  forwarder._(r'forwarder'),
  forwardedMessage._(r'forwarded_message'),
  unspecified._(r'unspecified'),
  ;

  /// Instantiate a new enum with the provided value.
  const DecodedIncomingMessageAttachmentsInnerOriginEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [DecodedIncomingMessageAttachmentsInnerOriginEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static DecodedIncomingMessageAttachmentsInnerOriginEnum? fromJson(dynamic value) => DecodedIncomingMessageAttachmentsInnerOriginEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [DecodedIncomingMessageAttachmentsInnerOriginEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<DecodedIncomingMessageAttachmentsInnerOriginEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DecodedIncomingMessageAttachmentsInnerOriginEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DecodedIncomingMessageAttachmentsInnerOriginEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DecodedIncomingMessageAttachmentsInnerOriginEnum] to String,
/// and [decode] dynamic data back to [DecodedIncomingMessageAttachmentsInnerOriginEnum].
class DecodedIncomingMessageAttachmentsInnerOriginEnumTypeTransformer {
  factory DecodedIncomingMessageAttachmentsInnerOriginEnumTypeTransformer() => _instance ??= const DecodedIncomingMessageAttachmentsInnerOriginEnumTypeTransformer._();

  const DecodedIncomingMessageAttachmentsInnerOriginEnumTypeTransformer._();

  String encode(DecodedIncomingMessageAttachmentsInnerOriginEnum data) => data._value;

  /// Returns the instance of [DecodedIncomingMessageAttachmentsInnerOriginEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DecodedIncomingMessageAttachmentsInnerOriginEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is DecodedIncomingMessageAttachmentsInnerOriginEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'original': return DecodedIncomingMessageAttachmentsInnerOriginEnum.original;
        case r'forwarder': return DecodedIncomingMessageAttachmentsInnerOriginEnum.forwarder;
        case r'forwarded_message': return DecodedIncomingMessageAttachmentsInnerOriginEnum.forwardedMessage;
        case r'unspecified': return DecodedIncomingMessageAttachmentsInnerOriginEnum.unspecified;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static DecodedIncomingMessageAttachmentsInnerOriginEnumTypeTransformer? _instance;
}


