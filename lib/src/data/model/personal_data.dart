class Personal {
  String title;
  String first;
  String last;

  Personal(this.title, this.first, this.last);

  Personal.fromMap(Map<String, dynamic> map)
      : this.title = map["title"],
        this.first = map["first"],
        this.last = map["last"];

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["title"] = title;
    map["first"] = first;
    map["last"] = last;
    return map;
  }

  toJson() {
    return {"title": title, "first": first, "last": last};
  }

  toJsonString() {
    return '{"title": "${title}", "first": "${first}", "last": "${last}"}';
  }
}
