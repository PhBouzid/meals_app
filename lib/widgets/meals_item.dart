import 'package:flutter/material.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:meals_app/widgets/meals_item_trait.dart';

class MealsItem extends StatelessWidget {
  const MealsItem(
      {super.key, required this.meal, required this.onToggleFavorite});

  final Meal meal;
  final Function(Meal) onToggleFavorite;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affodabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  void _selectMeal(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MealDetailsScreen(
              meal: meal,
              onToggleFavorite: onToggleFavorite,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          _selectMeal(context);
        },
        splashColor: Theme.of(context).primaryColor,
        child: Container(
            child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealsItemTrait(
                            icon: Icons.schedule,
                            label: '${meal.duration} min'),
                        const SizedBox(
                          width: 12,
                        ),
                        MealsItemTrait(icon: Icons.work, label: complexityText),
                        const SizedBox(
                          width: 12,
                        ),
                        MealsItemTrait(
                            icon: Icons.attach_money, label: affodabilityText),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
