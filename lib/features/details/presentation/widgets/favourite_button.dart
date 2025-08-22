part of '../pages/details_page.dart';

class _FavouriteButton extends StatefulWidget {
  _FavouriteButton({required this.isFav, required this.state});
  bool isFav;
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
    return IconButton(
      icon: Icon(
        widget.isFav ? Icons.favorite : Icons.favorite_outline,
        color: Theme.of(context).colorScheme.primary,
      ),
      onPressed: () => debounder.run(() {
        final bloc = BlocProvider.of<DetailsBloc>(context);
        bloc.add(MealFavouritePressdEvent(widget.state.meals.id ?? ''));
        setState(() {
          widget.isFav = !widget.isFav;
        });
      }),
    );
  }
}
