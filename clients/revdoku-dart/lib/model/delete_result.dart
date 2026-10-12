//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class DeleteResult {
  /// Returns a new [DeleteResult] instance.
  DeleteResult({
    required this.deleted,
    required this.id,
  });

  bool deleted;

  /// ID of the deleted resource. A webhook delete returns the mailbox ID.
  String id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DeleteResult &&
    other.deleted == deleted &&
    other.id == id;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (deleted.hashCode) +
    (id.hashCode);

  @override
  String toString() => 'DeleteResult[deleted=$deleted, id=$id]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'deleted'] = this.deleted;
      json[r'id'] = this.id;
    return json;
  }

  /// Returns a new [DeleteResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DeleteResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'deleted'), 'Required key "DeleteResult[deleted]" is missing from JSON.');
        assert(json[r'deleted'] != null, 'Required key "DeleteResult[deleted]" has a null value in JSON.');
        assert(json.containsKey(r'id'), 'Required key "DeleteResult[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "DeleteResult[id]" has a null value in JSON.');
        return true;
      }());

      return DeleteResult(
        deleted: mapValueOfType<bool>(json, r'deleted')!,
        id: mapValueOfType<String>(json, r'id')!,
      );
    }
    return null;
  }

  static List<DeleteResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DeleteResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DeleteResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DeleteResult> mapFromJson(dynamic json) {
    final map = <String, DeleteResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DeleteResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DeleteResult-objects as value to a dart map
  static Map<String, List<DeleteResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DeleteResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DeleteResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'deleted',
    'id',
  };
}

