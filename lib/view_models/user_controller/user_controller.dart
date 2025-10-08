import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_mode/user_model.dart';

class UserController extends GetxController {
  Rx<UserModel?> user = Rx<UserModel?>(null);

  void updateUser(UserModel newUser) {
    user.value = newUser;
  }

  void updateName(String name) {
    user.update((val) {
      if (val != null) val.name = name;
    });
  }

  void updateEmail(String email) {
    user.update((val) {
      if (val != null) val.email = email;
    });
  }

  void updatePhone(String phone) {
    user.update((val) {
      if (val != null) val.phone = phone;
    });
  }

  void updateProfilePicture(String profilePicture) {
    user.update((val) {
      if (val != null) val.profilePicture = profilePicture;
    });
  }

  // ✅ Education fields updates
  void updateCollege(String college) {
    user.update((val) {
      if (val != null) val.college = college;
    });
  }

  void updateBranch(String branch) {
    user.update((val) {
      if (val != null) val.branch = branch;
    });
  }

  void updateCourse(String course) {
    user.update((val) {
      if (val != null) val.course = course;
    });
  }

  void updateRollNo(String rollNo) {
    user.update((val) {
      if (val != null) val.rollNo = rollNo;
    });
  }

  String get userName => user.value?.name ?? "User";
  bool get isLoggedIn => user.value != null && (user.value!.name?.isNotEmpty ?? false);

  // Load user data from Firestore
  Future<void> loadUserData(String uid) async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (snapshot.exists) {
        final data = snapshot.data()!;
        updateUser(UserModel(
          id: uid,
          name: data['name'] ?? '',
          email: data['email'] ?? '',
          phone: data['phone'] ?? '',
          profilePicture: data['profilePicture'] ?? '',
          college: data['college'] ?? '',
          branch: data['branch'] ?? '',
          course: data['course'] ?? '',
          rollNo: data['rollNo'] ?? '',
        ));
      } else {
        print("User document not found for uid: $uid");
      }
    } catch (e) {
      print("Failed to load user data: $e");
    }
  }

  // Save updated user data to Firestore
  Future<void> saveUserData() async {
    if (user.value == null) return;
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.value!.id).set(user.value!.toJson());
    } catch (e) {
      print("Failed to save user data: $e");
    }
  }
}
