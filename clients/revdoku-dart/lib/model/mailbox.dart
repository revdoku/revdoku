//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class Mailbox {
  /// Returns a new [Mailbox] instance.
  Mailbox({
    required this.id,
    required this.accountId,
    this.description,
    this.metadata = const {},
    required this.metadataVersion,
    required this.email,
    required this.archived,
    this.archivedAt,
    this.lock,
    this.storageBytes,
    this.filesCount,
    required this.versionId,
    required this.versionNumber,
    this.createdAt,
    this.updatedAt,
    this.dashboardUrl,
    required this.archive,
    required this.unarchive,
    required this.delete,
  });

  String id;

  String accountId;

  String? description;

  /// Your application data. PATCH replaces the whole object.
  Map<String, Object?> metadata;

  /// Send as expected_metadata_version on PATCH. Changes only when description or metadata changes.
  String metadataVersion;

  MailboxEmail email;

  bool archived;

  DateTime? archivedAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MailboxLock? lock;

  /// Minimum value: 0
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? storageBytes;

  /// Current files, including stored emails and attachments.
  ///
  /// Minimum value: 0
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? filesCount;

  /// Current mailbox file-tree version. Send as expected_mailbox_version on file writes to detect concurrent changes.
  String? versionId;

  /// Minimum value: 0
  int versionNumber;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Opens the mailbox for signed-in members. It does not grant access.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? dashboardUrl;

  MailboxAction archive;

  MailboxAction unarchive;

  MailboxAction delete;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Mailbox &&
    other.id == id &&
    other.accountId == accountId &&
    other.description == description &&
    _deepEquality.equals(other.metadata, metadata) &&
    other.metadataVersion == metadataVersion &&
    other.email == email &&
    other.archived == archived &&
    other.archivedAt == archivedAt &&
    other.lock == lock &&
    other.storageBytes == storageBytes &&
    other.filesCount == filesCount &&
    other.versionId == versionId &&
    other.versionNumber == versionNumber &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt &&
    other.dashboardUrl == dashboardUrl &&
    other.archive == archive &&
    other.unarchive == unarchive &&
    other.delete == delete;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (accountId.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (metadata.hashCode) +
    (metadataVersion.hashCode) +
    (email.hashCode) +
    (archived.hashCode) +
    (archivedAt == null ? 0 : archivedAt!.hashCode) +
    (lock == null ? 0 : lock!.hashCode) +
    (storageBytes == null ? 0 : storageBytes!.hashCode) +
    (filesCount == null ? 0 : filesCount!.hashCode) +
    (versionId == null ? 0 : versionId!.hashCode) +
    (versionNumber.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode) +
    (dashboardUrl == null ? 0 : dashboardUrl!.hashCode) +
    (archive.hashCode) +
    (unarchive.hashCode) +
    (delete.hashCode);

  @override
  String toString() => 'Mailbox[id=$id, accountId=$accountId, description=$description, metadata=$metadata, metadataVersion=$metadataVersion, email=$email, archived=$archived, archivedAt=$archivedAt, lock=$lock, storageBytes=$storageBytes, filesCount=$filesCount, versionId=$versionId, versionNumber=$versionNumber, createdAt=$createdAt, updatedAt=$updatedAt, dashboardUrl=$dashboardUrl, archive=$archive, unarchive=$unarchive, delete=$delete]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'account_id'] = this.accountId;
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
      json[r'metadata'] = this.metadata;
      json[r'metadata_version'] = this.metadataVersion;
      json[r'email'] = this.email;
      json[r'archived'] = this.archived;
    if (this.archivedAt != null) {
      json[r'archived_at'] = this.archivedAt!.toUtc().toIso8601String();
    } else {
      json[r'archived_at'] = null;
    }
    if (this.lock != null) {
      json[r'lock'] = this.lock;
    }
    if (this.storageBytes != null) {
      json[r'storage_bytes'] = this.storageBytes;
    }
    if (this.filesCount != null) {
      json[r'files_count'] = this.filesCount;
    }
    if (this.versionId != null) {
      json[r'version_id'] = this.versionId;
    } else {
      json[r'version_id'] = null;
    }
      json[r'version_number'] = this.versionNumber;
    if (this.createdAt != null) {
      json[r'created_at'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'created_at'] = null;
    }
    if (this.updatedAt != null) {
      json[r'updated_at'] = this.updatedAt!.toUtc().toIso8601String();
    } else {
      json[r'updated_at'] = null;
    }
    if (this.dashboardUrl != null) {
      json[r'dashboard_url'] = this.dashboardUrl;
    }
      json[r'archive'] = this.archive;
      json[r'unarchive'] = this.unarchive;
      json[r'delete'] = this.delete;
    return json;
  }

  /// Returns a new [Mailbox] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Mailbox? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "Mailbox[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "Mailbox[id]" has a null value in JSON.');
        assert(json.containsKey(r'account_id'), 'Required key "Mailbox[account_id]" is missing from JSON.');
        assert(json[r'account_id'] != null, 'Required key "Mailbox[account_id]" has a null value in JSON.');
        assert(json.containsKey(r'metadata_version'), 'Required key "Mailbox[metadata_version]" is missing from JSON.');
        assert(json[r'metadata_version'] != null, 'Required key "Mailbox[metadata_version]" has a null value in JSON.');
        assert(json.containsKey(r'email'), 'Required key "Mailbox[email]" is missing from JSON.');
        assert(json[r'email'] != null, 'Required key "Mailbox[email]" has a null value in JSON.');
        assert(json.containsKey(r'archived'), 'Required key "Mailbox[archived]" is missing from JSON.');
        assert(json[r'archived'] != null, 'Required key "Mailbox[archived]" has a null value in JSON.');
        assert(json.containsKey(r'version_id'), 'Required key "Mailbox[version_id]" is missing from JSON.');
        assert(json.containsKey(r'version_number'), 'Required key "Mailbox[version_number]" is missing from JSON.');
        assert(json[r'version_number'] != null, 'Required key "Mailbox[version_number]" has a null value in JSON.');
        assert(json.containsKey(r'archive'), 'Required key "Mailbox[archive]" is missing from JSON.');
        assert(json[r'archive'] != null, 'Required key "Mailbox[archive]" has a null value in JSON.');
        assert(json.containsKey(r'unarchive'), 'Required key "Mailbox[unarchive]" is missing from JSON.');
        assert(json[r'unarchive'] != null, 'Required key "Mailbox[unarchive]" has a null value in JSON.');
        assert(json.containsKey(r'delete'), 'Required key "Mailbox[delete]" is missing from JSON.');
        assert(json[r'delete'] != null, 'Required key "Mailbox[delete]" has a null value in JSON.');
        return true;
      }());

      return Mailbox(
        id: mapValueOfType<String>(json, r'id')!,
        accountId: mapValueOfType<String>(json, r'account_id')!,
        description: mapValueOfType<String>(json, r'description'),
        metadata: mapCastOfType<String, Object?>(json, r'metadata') ?? const {},
        metadataVersion: mapValueOfType<String>(json, r'metadata_version')!,
        email: MailboxEmail.fromJson(json[r'email'])!,
        archived: mapValueOfType<bool>(json, r'archived')!,
        archivedAt: mapDateTime(json, r'archived_at', r''),
        lock: MailboxLock.fromJson(json[r'lock']),
        storageBytes: mapValueOfType<int>(json, r'storage_bytes'),
        filesCount: mapValueOfType<int>(json, r'files_count'),
        versionId: mapValueOfType<String>(json, r'version_id'),
        versionNumber: mapValueOfType<int>(json, r'version_number')!,
        createdAt: mapDateTime(json, r'created_at', r''),
        updatedAt: mapDateTime(json, r'updated_at', r''),
        dashboardUrl: mapValueOfType<String>(json, r'dashboard_url'),
        archive: MailboxAction.fromJson(json[r'archive'])!,
        unarchive: MailboxAction.fromJson(json[r'unarchive'])!,
        delete: MailboxAction.fromJson(json[r'delete'])!,
      );
    }
    return null;
  }

  static List<Mailbox> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Mailbox>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Mailbox.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Mailbox> mapFromJson(dynamic json) {
    final map = <String, Mailbox>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Mailbox.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Mailbox-objects as value to a dart map
  static Map<String, List<Mailbox>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Mailbox>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Mailbox.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'account_id',
    'metadata_version',
    'email',
    'archived',
    'version_id',
    'version_number',
    'archive',
    'unarchive',
    'delete',
  };
}

