part of '../pages/details_page.dart';

class _FavouriteButton extends StatefulWidget {
  const _FavouriteButton({required this.state});
  final DetailsLoaded state;
  @override
  State<_FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<_FavouriteButton> {
  final debounder = Debouncer(delay: Duration(milliseconds: 500));

  @override
  void dispose() {
    debounder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<DetailsBloc>(context);
    final isFav = bloc.mealsFav.contains(widget.state.meals.id);
    return IconButton(
      icon: Icon(
        isFav ? Icons.favorite : Icons.favorite_outline,
        color: Theme.of(context).colorScheme.primary,
      ),
      onPressed: () => debounder.run(() {
        bloc.add(MealFavouritePressdEvent(widget.state.meals.id ?? ''));
        setState(() {});
      }),
    );
  }
}
