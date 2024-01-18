import 'package:flutter/material.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meals_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key,
      this.title,
      required this.meals,
      required this.onToggleFavorite});

  final String? title;

  final List<Meal> meals;
  final Function(Meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.separated(
      itemBuilder: (context, index) {
        return MealsItem(
            meal: meals[index], onToggleFavorite: onToggleFavorite);
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: meals.length,
    );
    if (meals.isEmpty) {
      content = Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'No meals found',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(height: 16),
          Text(
            "Try selecting another category",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          )
        ],
      ));
    }
    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
