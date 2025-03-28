import 'package:flutter/material.dart';
import 'package:nestify/screens/detail_screen/widgets/tab_box.dart';
import 'package:nestify/screens/detail_screen/widgets/comment_section.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'package:nestify/widgets/favorite_icon_button.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:nestify/providers/model.dart';
import 'package:nestify/widgets/options_menu.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final BlueprintPost post;
  final Function() onEdit;

  const DetailScreen({required this.post, required this.onEdit, super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final String placeholderImage = 'assets/images/buzzhotel.jpg';

  @override
  Widget build(BuildContext context) {
    TextEditingController commentController = TextEditingController();
    List<Image> images = [];
    try {
      images = widget.post.imageUrls.keys.isEmpty
          ? []
          : widget.post.imageUrls.keys.map((url) {
              return Image.network(
                url,
                height: 400,
                width: 100,
                fit: BoxFit
                    .scaleDown, // Optional: to cover the box size proportionally
              );
            }).toList();
    } catch (error) {
      debugPrint("Displaying network url went wrong: $error");
    }

    return DefaultTabController(
      length: 2, // We have 2 tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.post.title ?? "missing title"),
          actions: [
            Provider.of<Model>(context, listen: false)
                    .isUserPostOwner(widget.post.owner)
                ? OptionsMenu(
                    post: widget.post,
                    onEdit: () {
                      setState(() {});
                    },
                    onDelete: () {
                      context.pop();
                    },
                  )
                : FavoriteIconButton(post: widget.post)
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Back icon
            onPressed: () => context.pop(),
          ), // Go back
        ),
        body: ListView(
          // Wrap everything in ListView for overall scrollability
          padding: const EdgeInsets.all(16.0),

          children: [
            ImageSlideshow(
              height: 400,
              width: 100,
              children: images.isEmpty
                  ? [
                      Image.asset(
                        placeholderImage,
                        height: 400,
                        width: 100,
                        fit: BoxFit
                            .cover, // Optional: to cover the box size proportionally
                      )
                    ]
                  : images,
            ),

            // Spacing
            const SizedBox(height: 16),

            // Box with Tabs
            TabBox(
              post: widget.post,
            ),

            // Spacing
            const SizedBox(height: 16),

            // Comment Section
            CommentSection(
              commentController: commentController,
            ),

            // Spacing
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
