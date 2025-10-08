import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

class Video {
  final String? title;
  final String? description;
  final String? youtubeLink;
  final bool isTemporary; // True if saved before login

  Video({
    this.title,
    this.description,
    this.youtubeLink,
    this.isTemporary = true,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'youtubeLink': youtubeLink,
    'isTemporary': isTemporary,
  };

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    title: json['title'],
    description: json['description'],
    youtubeLink: json['youtubeLink'],
    isTemporary: json['isTemporary'] ?? true,
  );
}

class VideoController extends GetxController {
  static VideoController get to => Get.find<VideoController>();

  var savedVideos = <Video>[].obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadSavedVideos();
  }

  void addVideo(Video video) {
    if (!savedVideos.any((v) => v.title == video.title)) {
      savedVideos.add(video);
      saveToStorage();
    }
  }

  void removeVideo(Video video) {
    savedVideos.removeWhere((v) => v.title == video.title);
    saveToStorage();
  }

  void saveToStorage() {
    final jsonList = savedVideos.map((v) => json.encode(v.toJson())).toList();
    storage.write('savedVideos', jsonList);
  }

  void loadSavedVideos() {
    final jsonList = storage.read<List>('savedVideos') ?? [];
    savedVideos.value =
        jsonList.map((e) => Video.fromJson(json.decode(e))).toList();
  }

  /// Convert temporary saved videos to permanent after login/signup
  void saveTemporaryVideosPermanently() {
    savedVideos.value = savedVideos
        .map((v) => Video(
      title: v.title,
      description: v.description,
      youtubeLink: v.youtubeLink,
      isTemporary: false,
    ))
        .toList();
    saveToStorage();
  }
}
