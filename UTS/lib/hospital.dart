class Hospital {
  final String name;
  final String image;
  final String desc;

  Hospital({
    required this.name,
    required this.image,
    required this.desc,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    if (json['name'] == null || json['image'] == null || json['desc'] == null) {
      throw FormatException("Data JSON tidak lengkap: $json");
    }
    return Hospital(
      name: json['name'],
      image: json['image'],
      desc: json['desc'],
    );
  }
}
