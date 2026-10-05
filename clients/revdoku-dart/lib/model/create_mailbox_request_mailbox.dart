//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class CreateMailboxRequestMailbox {
  /// Returns a new [CreateMailboxRequestMailbox] instance.
  CreateMailboxRequestMailbox({
    this.title,
    this.description,
    this.metadata = const {},
    this.tagIds = const [],
    this.tagPaths = const [],
    this.email,
  });

  /// Optional display title; defaults to the assigned username.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? title;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? description;

  Map<String, Object?> metadata;

  List<String> tagIds;

  List<String> tagPaths;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  CreateMailboxRequestMailboxEmail? email;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CreateMailboxRequestMailbox &&
    other.title == title &&
    other.description == description &&
    _deepEquality.equals(other.metadata, metadata) &&
    _deepEquality.equals(other.tagIds, tagIds) &&
    _deepEquality.equals(other.tagPaths, tagPaths) &&
    other.email == email;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title == null ? 0 : title!.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (metadata.hashCode) +
    (tagIds.hashCode) +
    (tagPaths.hashCode) +
    (email == null ? 0 : email!.hashCode);

  @override
  String toString() => 'CreateMailboxRequestMailbox[title=$title, description=$description, metadata=$metadata, tagIds=$tagIds, tagPaths=$tagPaths, email=$email]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.title != null) {
      json[r'title'] = this.title;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    }
      json[r'metadata'] = this.metadata;
      json[r'tag_ids'] = this.tagIds;
      json[r'tag_paths'] = this.tagPaths;
    if (this.email != null) {
      json[r'email'] = this.email;
    }
    return json;
  }

  /// Returns a new [CreateMailboxRequestMailbox] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CreateMailboxRequestMailbox? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return CreateMailboxRequestMailbox(
        title: mapValueOfType<String>(json, r'title'),
        description: mapValueOfType<String>(json, r'description'),
        metadata: mapCastOfType<String, Object?>(json, r'metadata') ?? const {},
        tagIds: json[r'tag_ids'] is Iterable
            ? (json[r'tag_ids'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        tagPaths: json[r'tag_paths'] is Iterable
            ? (json[r'tag_paths'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        email: CreateMailboxRequestMailboxEmail.fromJson(json[r'email']),
      );
    }
    return null;
  }

  static List<CreateMailboxRequestMailbox> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateMailboxRequestMailbox>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateMailboxRequestMailbox.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CreateMailboxRequestMailbox> mapFromJson(dynamic json) {
    final map = <String, CreateMailboxRequestMailbox>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateMailboxRequestMailbox.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CreateMailboxRequestMailbox-objects as value to a dart map
  static Map<String, List<CreateMailboxRequestMailbox>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CreateMailboxRequestMailbox>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CreateMailboxRequestMailbox.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

