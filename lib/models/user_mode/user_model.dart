class UserModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? profilePicture;


  String? college;
  String? branch;
  String? course;
  String? rollNo;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profilePicture,
    this.college,
    this.branch,
    this.course,
    this.rollNo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone']?.toString() ?? '',
      profilePicture: json['profilePicture'],
      college: json['college'] ?? '',
      branch: json['branch'] ?? '',
      course: json['course'] ?? '',
      rollNo: json['rollNo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profilePicture': profilePicture,
      'college': college,
      'branch': branch,
      'course': course,
      'rollNo': rollNo,
    };
  }
}
