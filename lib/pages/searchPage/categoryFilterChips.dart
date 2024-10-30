import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nestify/models/searchModel.dart';

class CategoryFilterChips extends StatefulWidget {
  const CategoryFilterChips({super.key});

  @override
  State<CategoryFilterChips> createState() => _CategoryFilterChipsState();
}

class _CategoryFilterChipsState extends State<CategoryFilterChips> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchModel>(
      builder: (context, model, child) {
        Set<String> selectedCategories = model.getSelectedCategories;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category:', style: Theme.of(context).textTheme.labelLarge),
            Wrap(
                spacing: 8.0,
                children: model.categories.map((String category) {
                  return FilterChip(
                    label: Text(category),
                    selected: selectedCategories.contains(category),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          selectedCategories.add(category);
                        } else {
                          selectedCategories.remove(category);
                        }
                      });
                    },
                  );
                }).toList()),
          ],
        );
      },
    );
  }
}