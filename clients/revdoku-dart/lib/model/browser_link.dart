//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of revdoku.api;

class BrowserLink {
  /// Returns a new [BrowserLink] instance.
  BrowserLink({
    required this.url,
    required this.path,
    this.singleUse,
    this.requiresLogin,
    this.redirectPath,
  });

  /// Dashboard link. The user signs in normally; the link grants nothing.
  String url;

  String path;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? singleUse;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? requiresLogin;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? redirectPath;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BrowserLink &&
    other.url == url &&
    other.path == path &&
    other.singleUse == singleUse &&
    other.requiresLogin == requiresLogin &&
    other.redirectPath == redirectPath;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (url.hashCode) +
    (path.hashCode) +
    (singleUse == null ? 0 : singleUse!.hashCode) +
    (requiresLogin == null ? 0 : requiresLogin!.hashCode) +
    (redirectPath == null ? 0 : redirectPath!.hashCode);

  @override
  String toString() => 'BrowserLink[url=$url, path=$path, singleUse=$singleUse, requiresLogin=$requiresLogin, redirectPath=$redirectPath]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'url'] = this.url;
      json[r'path'] = this.path;
    if (this.singleUse != null) {
      json[r'single_use'] = this.singleUse;
    }
    if (this.requiresLogin != null) {
      json[r'requires_login'] = this.requiresLogin;
    }
    if (this.redirectPath != null) {
      json[r'redirect_path'] = this.redirectPath;
    }
    return json;
  }

  /// Returns a new [BrowserLink] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BrowserLink? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'url'), 'Required key "BrowserLink[url]" is missing from JSON.');
        assert(json[r'url'] != null, 'Required key "BrowserLink[url]" has a null value in JSON.');
        assert(json.containsKey(r'path'), 'Required key "BrowserLink[path]" is missing from JSON.');
        assert(json[r'path'] != null, 'Required key "BrowserLink[path]" has a null value in JSON.');
        return true;
      }());

      return BrowserLink(
        url: mapValueOfType<String>(json, r'url')!,
        path: mapValueOfType<String>(json, r'path')!,
        singleUse: mapValueOfType<bool>(json, r'single_use'),
        requiresLogin: mapValueOfType<bool>(json, r'requires_login'),
        redirectPath: mapValueOfType<String>(json, r'redirect_path'),
      );
    }
    return null;
  }

  static List<BrowserLink> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BrowserLink>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BrowserLink.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BrowserLink> mapFromJson(dynamic json) {
    final map = <String, BrowserLink>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BrowserLink.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BrowserLink-objects as value to a dart map
  static Map<String, List<BrowserLink>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BrowserLink>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BrowserLink.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'url',
    'path',
  };
}

