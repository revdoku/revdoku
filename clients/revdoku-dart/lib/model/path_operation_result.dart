//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class PathOperationResult {
  /// Returns a new [PathOperationResult] instance.
  PathOperationResult({
    required this.operation,
    required this.skipped,
    this.oldPath,
    required this.path,
    this.sourceMailboxId,
    this.targetMailboxId,
    this.sourceFile,
    this.file,
    this.version,
  });

  PathOperationResultOperationEnum operation;

  /// True when the file already had the requested path.
  bool skipped;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? oldPath;

  String path;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? sourceMailboxId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? targetMailboxId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MailboxFile? sourceFile;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MailboxFile? file;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  FileVersion? version;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PathOperationResult &&
    other.operation == operation &&
    other.skipped == skipped &&
    other.oldPath == oldPath &&
    other.path == path &&
    other.sourceMailboxId == sourceMailboxId &&
    other.targetMailboxId == targetMailboxId &&
    other.sourceFile == sourceFile &&
    other.file == file &&
    other.version == version;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (operation.hashCode) +
    (skipped.hashCode) +
    (oldPath == null ? 0 : oldPath!.hashCode) +
    (path.hashCode) +
    (sourceMailboxId == null ? 0 : sourceMailboxId!.hashCode) +
    (targetMailboxId == null ? 0 : targetMailboxId!.hashCode) +
    (sourceFile == null ? 0 : sourceFile!.hashCode) +
    (file == null ? 0 : file!.hashCode) +
    (version == null ? 0 : version!.hashCode);

  @override
  String toString() => 'PathOperationResult[operation=$operation, skipped=$skipped, oldPath=$oldPath, path=$path, sourceMailboxId=$sourceMailboxId, targetMailboxId=$targetMailboxId, sourceFile=$sourceFile, file=$file, version=$version]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'operation'] = this.operation;
      json[r'skipped'] = this.skipped;
    if (this.oldPath != null) {
      json[r'old_path'] = this.oldPath;
    }
      json[r'path'] = this.path;
    if (this.sourceMailboxId != null) {
      json[r'source_mailbox_id'] = this.sourceMailboxId;
    }
    if (this.targetMailboxId != null) {
      json[r'target_mailbox_id'] = this.targetMailboxId;
    }
    if (this.sourceFile != null) {
      json[r'source_file'] = this.sourceFile;
    }
    if (this.file != null) {
      json[r'file'] = this.file;
    }
    if (this.version != null) {
      json[r'version'] = this.version;
    }
    return json;
  }

  /// Returns a new [PathOperationResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PathOperationResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'operation'), 'Required key "PathOperationResult[operation]" is missing from JSON.');
        assert(json[r'operation'] != null, 'Required key "PathOperationResult[operation]" has a null value in JSON.');
        assert(json.containsKey(r'skipped'), 'Required key "PathOperationResult[skipped]" is missing from JSON.');
        assert(json[r'skipped'] != null, 'Required key "PathOperationResult[skipped]" has a null value in JSON.');
        assert(json.containsKey(r'path'), 'Required key "PathOperationResult[path]" is missing from JSON.');
        assert(json[r'path'] != null, 'Required key "PathOperationResult[path]" has a null value in JSON.');
        return true;
      }());

      return PathOperationResult(
        operation: PathOperationResultOperationEnum.fromJson(json[r'operation'])!,
        skipped: mapValueOfType<bool>(json, r'skipped')!,
        oldPath: mapValueOfType<String>(json, r'old_path'),
        path: mapValueOfType<String>(json, r'path')!,
        sourceMailboxId: mapValueOfType<String>(json, r'source_mailbox_id'),
        targetMailboxId: mapValueOfType<String>(json, r'target_mailbox_id'),
        sourceFile: MailboxFile.fromJson(json[r'source_file']),
        file: MailboxFile.fromJson(json[r'file']),
        version: FileVersion.fromJson(json[r'version']),
      );
    }
    return null;
  }

  static List<PathOperationResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PathOperationResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PathOperationResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PathOperationResult> mapFromJson(dynamic json) {
    final map = <String, PathOperationResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PathOperationResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PathOperationResult-objects as value to a dart map
  static Map<String, List<PathOperationResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PathOperationResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PathOperationResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'operation',
    'skipped',
    'path',
  };
}


enum PathOperationResultOperationEnum {
  rename._(r'rename'),
  move._(r'move'),
  copy._(r'copy'),
  ;

  /// Instantiate a new enum with the provided value.
  const PathOperationResultOperationEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [PathOperationResultOperationEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static PathOperationResultOperationEnum? fromJson(dynamic value) => PathOperationResultOperationEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [PathOperationResultOperationEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<PathOperationResultOperationEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PathOperationResultOperationEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PathOperationResultOperationEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [PathOperationResultOperationEnum] to String,
/// and [decode] dynamic data back to [PathOperationResultOperationEnum].
class PathOperationResultOperationEnumTypeTransformer {
  factory PathOperationResultOperationEnumTypeTransformer() => _instance ??= const PathOperationResultOperationEnumTypeTransformer._();

  const PathOperationResultOperationEnumTypeTransformer._();

  String encode(PathOperationResultOperationEnum data) => data._value;

  /// Returns the instance of [PathOperationResultOperationEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  PathOperationResultOperationEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is PathOperationResultOperationEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'rename': return PathOperationResultOperationEnum.rename;
        case r'move': return PathOperationResultOperationEnum.move;
        case r'copy': return PathOperationResultOperationEnum.copy;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static PathOperationResultOperationEnumTypeTransformer? _instance;
}


