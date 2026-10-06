//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class MailboxFile {
  /// Returns a new [MailboxFile] instance.
  MailboxFile({
    required this.id,
    this.mailboxId,
    this.basename,
    required this.path,
    this.role,
    this.createdBySystem,
    this.deleted,
    this.metadata = const {},
    this.versionReasons = const [],
    this.lock = const {},
    this.currentFileVersion,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdByAgent = const {},
    this.updatedByAgent = const {},
    this.createdByApiKey = const {},
    this.updatedByApiKey = const {},
    this.read,
    this.readAt,
    this.readBy,
    this.readByApiKey,
  });

  String id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? mailboxId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? basename;

  String path;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? role;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? createdBySystem;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? deleted;

  Map<String, Object?> metadata;

  List<FileVersionReason> versionReasons;

  Map<String, Object?> lock;

  FileVersion? currentFileVersion;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  FileActor? createdBy;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? updatedAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? deletedAt;

  Map<String, Object?> createdByAgent;

  Map<String, Object?> updatedByAgent;

  Map<String, Object?> createdByApiKey;

  Map<String, Object?> updatedByApiKey;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? read;

  DateTime? readAt;

  FileActor? readBy;

  FileKey? readByApiKey;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MailboxFile &&
    other.id == id &&
    other.mailboxId == mailboxId &&
    other.basename == basename &&
    other.path == path &&
    other.role == role &&
    other.createdBySystem == createdBySystem &&
    other.deleted == deleted &&
    _deepEquality.equals(other.metadata, metadata) &&
    _deepEquality.equals(other.versionReasons, versionReasons) &&
    _deepEquality.equals(other.lock, lock) &&
    other.currentFileVersion == currentFileVersion &&
    other.createdBy == createdBy &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt &&
    other.deletedAt == deletedAt &&
    _deepEquality.equals(other.createdByAgent, createdByAgent) &&
    _deepEquality.equals(other.updatedByAgent, updatedByAgent) &&
    _deepEquality.equals(other.createdByApiKey, createdByApiKey) &&
    _deepEquality.equals(other.updatedByApiKey, updatedByApiKey) &&
    other.read == read &&
    other.readAt == readAt &&
    other.readBy == readBy &&
    other.readByApiKey == readByApiKey;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (mailboxId == null ? 0 : mailboxId!.hashCode) +
    (basename == null ? 0 : basename!.hashCode) +
    (path.hashCode) +
    (role == null ? 0 : role!.hashCode) +
    (createdBySystem == null ? 0 : createdBySystem!.hashCode) +
    (deleted == null ? 0 : deleted!.hashCode) +
    (metadata.hashCode) +
    (versionReasons.hashCode) +
    (lock.hashCode) +
    (currentFileVersion == null ? 0 : currentFileVersion!.hashCode) +
    (createdBy == null ? 0 : createdBy!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode) +
    (deletedAt == null ? 0 : deletedAt!.hashCode) +
    (createdByAgent.hashCode) +
    (updatedByAgent.hashCode) +
    (createdByApiKey.hashCode) +
    (updatedByApiKey.hashCode) +
    (read == null ? 0 : read!.hashCode) +
    (readAt == null ? 0 : readAt!.hashCode) +
    (readBy == null ? 0 : readBy!.hashCode) +
    (readByApiKey == null ? 0 : readByApiKey!.hashCode);

  @override
  String toString() => 'MailboxFile[id=$id, mailboxId=$mailboxId, basename=$basename, path=$path, role=$role, createdBySystem=$createdBySystem, deleted=$deleted, metadata=$metadata, versionReasons=$versionReasons, lock=$lock, currentFileVersion=$currentFileVersion, createdBy=$createdBy, createdAt=$createdAt, updatedAt=$updatedAt, deletedAt=$deletedAt, createdByAgent=$createdByAgent, updatedByAgent=$updatedByAgent, createdByApiKey=$createdByApiKey, updatedByApiKey=$updatedByApiKey, read=$read, readAt=$readAt, readBy=$readBy, readByApiKey=$readByApiKey]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
    if (this.mailboxId != null) {
      json[r'mailbox_id'] = this.mailboxId;
    }
    if (this.basename != null) {
      json[r'basename'] = this.basename;
    }
      json[r'path'] = this.path;
    if (this.role != null) {
      json[r'role'] = this.role;
    }
    if (this.createdBySystem != null) {
      json[r'created_by_system'] = this.createdBySystem;
    }
    if (this.deleted != null) {
      json[r'deleted'] = this.deleted;
    }
      json[r'metadata'] = this.metadata;
      json[r'version_reasons'] = this.versionReasons;
      json[r'lock'] = this.lock;
    if (this.currentFileVersion != null) {
      json[r'current_file_version'] = this.currentFileVersion;
    } else {
      json[r'current_file_version'] = null;
    }
    if (this.createdBy != null) {
      json[r'created_by'] = this.createdBy;
    }
    if (this.createdAt != null) {
      json[r'created_at'] = this.createdAt!.toUtc().toIso8601String();
    }
    if (this.updatedAt != null) {
      json[r'updated_at'] = this.updatedAt!.toUtc().toIso8601String();
    }
    if (this.deletedAt != null) {
      json[r'deleted_at'] = this.deletedAt!.toUtc().toIso8601String();
    }
      json[r'created_by_agent'] = this.createdByAgent;
      json[r'updated_by_agent'] = this.updatedByAgent;
      json[r'created_by_api_key'] = this.createdByApiKey;
      json[r'updated_by_api_key'] = this.updatedByApiKey;
    if (this.read != null) {
      json[r'read'] = this.read;
    }
    if (this.readAt != null) {
      json[r'read_at'] = this.readAt!.toUtc().toIso8601String();
    } else {
      json[r'read_at'] = null;
    }
    if (this.readBy != null) {
      json[r'read_by'] = this.readBy;
    } else {
      json[r'read_by'] = null;
    }
    if (this.readByApiKey != null) {
      json[r'read_by_api_key'] = this.readByApiKey;
    } else {
      json[r'read_by_api_key'] = null;
    }
    return json;
  }

  /// Returns a new [MailboxFile] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MailboxFile? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "MailboxFile[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "MailboxFile[id]" has a null value in JSON.');
        assert(json.containsKey(r'path'), 'Required key "MailboxFile[path]" is missing from JSON.');
        assert(json[r'path'] != null, 'Required key "MailboxFile[path]" has a null value in JSON.');
        return true;
      }());

      return MailboxFile(
        id: mapValueOfType<String>(json, r'id')!,
        mailboxId: mapValueOfType<String>(json, r'mailbox_id'),
        basename: mapValueOfType<String>(json, r'basename'),
        path: mapValueOfType<String>(json, r'path')!,
        role: mapValueOfType<String>(json, r'role'),
        createdBySystem: mapValueOfType<String>(json, r'created_by_system'),
        deleted: mapValueOfType<bool>(json, r'deleted'),
        metadata: mapCastOfType<String, Object?>(json, r'metadata') ?? const {},
        versionReasons: FileVersionReason.listFromJson(json[r'version_reasons']),
        lock: mapCastOfType<String, Object?>(json, r'lock') ?? const {},
        currentFileVersion: FileVersion.fromJson(json[r'current_file_version']),
        createdBy: FileActor.fromJson(json[r'created_by']),
        createdAt: mapDateTime(json, r'created_at', r''),
        updatedAt: mapDateTime(json, r'updated_at', r''),
        deletedAt: mapDateTime(json, r'deleted_at', r''),
        createdByAgent: mapCastOfType<String, Object?>(json, r'created_by_agent') ?? const {},
        updatedByAgent: mapCastOfType<String, Object?>(json, r'updated_by_agent') ?? const {},
        createdByApiKey: mapCastOfType<String, Object?>(json, r'created_by_api_key') ?? const {},
        updatedByApiKey: mapCastOfType<String, Object?>(json, r'updated_by_api_key') ?? const {},
        read: mapValueOfType<bool>(json, r'read'),
        readAt: mapDateTime(json, r'read_at', r''),
        readBy: FileActor.fromJson(json[r'read_by']),
        readByApiKey: FileKey.fromJson(json[r'read_by_api_key']),
      );
    }
    return null;
  }

  static List<MailboxFile> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MailboxFile>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MailboxFile.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MailboxFile> mapFromJson(dynamic json) {
    final map = <String, MailboxFile>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MailboxFile.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MailboxFile-objects as value to a dart map
  static Map<String, List<MailboxFile>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MailboxFile>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MailboxFile.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'path',
  };
}

