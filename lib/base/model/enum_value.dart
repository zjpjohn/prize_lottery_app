class EnumValue {
  ///
  dynamic value;

  ///
  String description = '';

  EnumValue.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    if (json['description'] != null) {
      description = json['description'];
    }
    if (json['label'] != null) {
      description = json['label'];
    }
  }

  Map toJson() {
    return {}
      ..['value'] = value
      ..['description'] = description;
  }

  @override
  bool operator ==(Object other) {
    if (other is! EnumValue) {
      return false;
    }
    return value == other.value;
  }

  @override
  int get hashCode {
    return value.hashCode;
  }
}
