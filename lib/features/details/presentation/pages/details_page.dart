import 'package:aplazo_pt/core/utils/debouncer.dart';
import 'package:aplazo_pt/core/widgets/app_error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/widgets/app_ingredient_tile.dart';
import '../../domain/entities/meals_details_category.dart';
import '../bloc/details_bloc/details_bloc.dart';
part '../widgets/details_loaded_view.dart';
part '../widgets/favourite_button.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});
  static const routeName = '/details';

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late String idMenu;

  @override
  Widget build(BuildContext context) {
    // get idMenu argument on the actual route navigator
    idMenu = ModalRoute.of(context)?.settings.arguments as String;
    return BlocProvider(
      create: (context) => sl<DetailsBloc>()..add(GetMealDetailsEvent(idMenu)),
      child: _DetailsView(idMenu),
    );
  }
}

class _DetailsView extends StatelessWidget {
  const _DetailsView(this.idMenu);
  final String idMenu;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withAlpha(200),

        actions: [
          BlocBuilder<DetailsBloc, DetailsState>(
            builder: (context, state) {
              if (state is DetailsLoaded) {
                return _FavouriteButton(state: state);
              }
              return Container();
            },
          ),
        ],
        title: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            switch (state) {
              case DetailsLoaded _:
                return Text((state).meals.name ?? 'unNamed');
              case DetailsError _:
                return Text("Error");
              case DetailsLoading _:
                return Text("Cargando");
              default:
                return Text("Cargando");
            }
          },
        ),
      ),
      body: BlocBuilder<DetailsBloc, DetailsState>(
        builder: (context, state) {
          if (state is DetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DetailsError) {
            return AppErrorScreen(
              message: state.message,
              onRetry: () =>
                  context.read<DetailsBloc>().add(GetMealDetailsEvent(idMenu)),
            );
          }
          return Column(
            children: [
              if (state is DetailsLoaded)
                _DetailsLoadedView(meals: state.meals),
            ],
          );
        },
      ),
    );
  }
}
