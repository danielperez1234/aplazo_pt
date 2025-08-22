part of '../pages/details_page.dart';

class _DetailsLoadedView extends StatelessWidget {
  const _DetailsLoadedView({required this.meals});
  final MealDetails meals;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 250,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                  child: Image.network(
                    meals.image?.large ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
                  ),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                meals.instructions ?? 'Sin instrucciones.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            if (meals.ingredients.isNotEmpty) ...[
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Ingredients:',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: meals.ingredients.length,
                itemBuilder: (context, index) {
                  final ingredient = meals.ingredients[index];
                  return AppIngredientTile(
                    name: ingredient.name,
                    image: ingredient.image?.small,
                    measure: ingredient.measure,
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
