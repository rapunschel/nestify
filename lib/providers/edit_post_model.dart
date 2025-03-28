import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nestify/apis/firestore_db.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'package:nestify/models/post_model.dart';

class EditPostModel extends ChangeNotifier implements PostModel {
  BlueprintPost _post = BlueprintPost();
  @override
  List<File> images = [];
  List<String> _imgUrls = [];
  List<String> markedUrlDeletion = [];
  @override
  String? category;
  final bool _isEdit = true;

  @override
  bool get isEdit => _isEdit;
  EditPostModel();

  @override
  set post(BlueprintPost post) {
    _post = post;
    markedUrlDeletion = [];
    //  images = [];
    category = _post.category;
    _imgUrls = _post.imageUrls.keys.toList();
  }

  @override
  BlueprintPost get post => _post;

  @override
  List<String> get imgUrls => _imgUrls;
  @override
  void removeImgUrl(String url) {
    _imgUrls.remove(url);
    markedUrlDeletion.add(url);
  }

  @override
  Future<void> updateBlueprint() async {
    // If a url was marked, delete
    for (File file in images) {
      await FirestoreDb.uploadImage(file, _post.id).then((value) {
        _post.imageUrls.addAll(value);
      });
    }
    images = [];

    // If a url was marked, delete
    for (String key in markedUrlDeletion) {
      String? filePath = _post.imageUrls.remove(key);
      if (filePath != null) {
        try {
          await FirestoreDb.deleteImage(filePath);
        } catch (error) {
          debugPrint("File dont exist: $error");
        }
      }
    }
    await FirestoreDb.updateUserBlueprint(_post);

    notifyListeners();
  }

  @override
  void updatePostFields({
    String? title,
    String? material,
    String? instruction,
  }) {
    debugPrint("Category is: $category");
    _post.title = title;
    _post.material = material;
    _post.instruction = instruction;
    _post.category = category;
  }
}

class HomeEditPostModel extends EditPostModel {}

class SearchEditPostModel extends EditPostModel {}

class ProfileEditPostModel extends EditPostModel {}
