import 'package:flutter/material.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/widgets/category_item.dart';
import 'package:meals_app/data/categories_data.dart';
import 'package:meals_app/models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavorite});

  final Function(Meal) onToggleFavorite;

  void _selectCategory(BuildContext context, Category category) {
    final meals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MealsScreen(
              title: category.title,
              meals: meals,
              onToggleFavorite: onToggleFavorite,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: availableCategories
          .map((e) => CategoryItem(
              category: e,
              onSelectCategory: () {
                _selectCategory(context, e);
              }))
          .toList(),
    );
  }
}
