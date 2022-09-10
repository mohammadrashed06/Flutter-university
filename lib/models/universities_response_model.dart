
class UniversitiesResponseModel {
/*
{
  "domains": [
    "aabfs.org"
  ],
  "alpha_two_code": "JO",
  "country": "Jordan",
  "web_pages": [
    "http://www.aabfs.org/"
  ],
  "name": "Arab Academy for Banking and Financial Sciences",
  "state-province": null
}
*/

  List<String?>? domains;
  String? alphaTwoCode;
  String? country;
  List<String?>? webPages;
  String? name;
  String? stateProvince;

  UniversitiesResponseModel({
    this.domains,
    this.alphaTwoCode,
    this.country,
    this.webPages,
    this.name,
    this.stateProvince,
  });
  UniversitiesResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['domains'] != null) {
      final v = json['domains'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      domains = arr0;
    }
    alphaTwoCode = json['alpha_two_code']?.toString();
    country = json['country']?.toString();
    if (json['web_pages'] != null) {
      final v = json['web_pages'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      webPages = arr0;
    }
    name = json['name']?.toString();
    stateProvince = json['state-province']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (domains != null) {
      final v = domains;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['domains'] = arr0;
    }
    data['alpha_two_code'] = alphaTwoCode;
    data['country'] = country;
    if (webPages != null) {
      final v = webPages;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['web_pages'] = arr0;
    }
    data['name'] = name;
    data['state-province'] = stateProvince;
    return data;
  }
}
