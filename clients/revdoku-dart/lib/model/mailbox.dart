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
    this.metadataVersion,
    required this.email,
    this.archived,
    this.archivedAt,
    this.lock,
    this.storageBytes,
    this.filesCount,
    this.createdAt,
    this.updatedAt,
    this.dashboardUrl,
    this.currentMailboxRevisionId,
    this.currentMailboxRevisionNumber,
    this.archive,
    this.unarchive,
    this.delete,
  });

  String id;

  String accountId;

  String? description;

  Map<String, Object?> metadata;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? metadataVersion;

  MailboxEmail email;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? archived;

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

  /// Minimum value: 0
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? filesCount;

  DateTime? createdAt;

  DateTime? updatedAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? dashboardUrl;

  String? currentMailboxRevisionId;

  /// Minimum value: 0
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? currentMailboxRevisionNumber;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MailboxAction? archive;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MailboxAction? unarchive;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MailboxAction? delete;

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
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt &&
    other.dashboardUrl == dashboardUrl &&
    other.currentMailboxRevisionId == currentMailboxRevisionId &&
    other.currentMailboxRevisionNumber == currentMailboxRevisionNumber &&
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
    (metadataVersion == null ? 0 : metadataVersion!.hashCode) +
    (email.hashCode) +
    (archived == null ? 0 : archived!.hashCode) +
    (archivedAt == null ? 0 : archivedAt!.hashCode) +
    (lock == null ? 0 : lock!.hashCode) +
    (storageBytes == null ? 0 : storageBytes!.hashCode) +
    (filesCount == null ? 0 : filesCount!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode) +
    (dashboardUrl == null ? 0 : dashboardUrl!.hashCode) +
    (currentMailboxRevisionId == null ? 0 : currentMailboxRevisionId!.hashCode) +
    (currentMailboxRevisionNumber == null ? 0 : currentMailboxRevisionNumber!.hashCode) +
    (archive == null ? 0 : archive!.hashCode) +
    (unarchive == null ? 0 : unarchive!.hashCode) +
    (delete == null ? 0 : delete!.hashCode);

  @override
  String toString() => 'Mailbox[id=$id, accountId=$accountId, description=$description, metadata=$metadata, metadataVersion=$metadataVersion, email=$email, archived=$archived, archivedAt=$archivedAt, lock=$lock, storageBytes=$storageBytes, filesCount=$filesCount, createdAt=$createdAt, updatedAt=$updatedAt, dashboardUrl=$dashboardUrl, currentMailboxRevisionId=$currentMailboxRevisionId, currentMailboxRevisionNumber=$currentMailboxRevisionNumber, archive=$archive, unarchive=$unarchive, delete=$delete]';

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
    if (this.metadataVersion != null) {
      json[r'metadata_version'] = this.metadataVersion;
    }
      json[r'email'] = this.email;
    if (this.archived != null) {
      json[r'archived'] = this.archived;
    }
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
    if (this.currentMailboxRevisionId != null) {
      json[r'current_mailbox_revision_id'] = this.currentMailboxRevisionId;
    } else {
      json[r'current_mailbox_revision_id'] = null;
    }
    if (this.currentMailboxRevisionNumber != null) {
      json[r'current_mailbox_revision_number'] = this.currentMailboxRevisionNumber;
    }
    if (this.archive != null) {
      json[r'archive'] = this.archive;
    }
    if (this.unarchive != null) {
      json[r'unarchive'] = this.unarchive;
    }
    if (this.delete != null) {
      json[r'delete'] = this.delete;
    }
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
        assert(json.containsKey(r'email'), 'Required key "Mailbox[email]" is missing from JSON.');
        assert(json[r'email'] != null, 'Required key "Mailbox[email]" has a null value in JSON.');
        return true;
      }());

      return Mailbox(
        id: mapValueOfType<String>(json, r'id')!,
        accountId: mapValueOfType<String>(json, r'account_id')!,
        description: mapValueOfType<String>(json, r'description'),
        metadata: mapCastOfType<String, Object?>(json, r'metadata') ?? const {},
        metadataVersion: mapValueOfType<String>(json, r'metadata_version'),
        email: MailboxEmail.fromJson(json[r'email'])!,
        archived: mapValueOfType<bool>(json, r'archived'),
        archivedAt: mapDateTime(json, r'archived_at', r''),
        lock: MailboxLock.fromJson(json[r'lock']),
        storageBytes: mapValueOfType<int>(json, r'storage_bytes'),
        filesCount: mapValueOfType<int>(json, r'files_count'),
        createdAt: mapDateTime(json, r'created_at', r''),
        updatedAt: mapDateTime(json, r'updated_at', r''),
        dashboardUrl: mapValueOfType<String>(json, r'dashboard_url'),
        currentMailboxRevisionId: mapValueOfType<String>(json, r'current_mailbox_revision_id'),
        currentMailboxRevisionNumber: mapValueOfType<int>(json, r'current_mailbox_revision_number'),
        archive: MailboxAction.fromJson(json[r'archive']),
        unarchive: MailboxAction.fromJson(json[r'unarchive']),
        delete: MailboxAction.fromJson(json[r'delete']),
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
    'email',
  };
}

