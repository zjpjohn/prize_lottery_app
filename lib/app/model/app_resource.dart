///
///
class AppResource {
  late String uri;
  late String defUri;
  late ResourceSpecs specs;

  AppResource.fromJson(Map<String, dynamic> json) {
    uri = json['uri'];
    defUri = json['defUri'];
    specs = ResourceSpecs.fromJson(json['specs']);
  }

  Map toJson() {
    Map json = {};
    json['uri'] = uri;
    json['defUri'] = defUri;
    json['specs'] = specs;
    return json;
  }
}

class ResourceSpecs {
  ///
  late double width;

  ///
  late double height;

  ResourceSpecs.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
  }

  Map toJson() {
    Map json = {};
    json['width'] = width;
    json['height'] = height;
    return json;
  }
}
