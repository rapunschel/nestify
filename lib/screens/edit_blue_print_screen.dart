import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'package:nestify/widgets/blueprint_form/blueprint_form.dart';

class EditBlueprintScreen extends StatelessWidget {
  const EditBlueprintScreen(
      {super.key, required this.post, required this.onEdit});
  final BlueprintPost post;
  final Function() onEdit;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Editing blueprint"),
          ),
          body: BlueprintForm(
            post: post,
            onEdit: onEdit,
          )),
    );
  }
}
