import 'package:aplazo_pt/core/widgets/app_error_screen.dart';
import 'package:aplazo_pt/core/widgets/app_meal_tile.dart';
import 'package:aplazo_pt/features/serch_by_name/presentation/bloc/search_by_name_bloc/search_by_name_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/utils/debouncer.dart';

class SearchByNamePage extends StatefulWidget {
  const SearchByNamePage({super.key});
  static const routeName = '/search-by-name';

  @override
  State<SearchByNamePage> createState() => _SearchByNamePageState();
}

class _SearchByNamePageState extends State<SearchByNamePage> {
  final TextEditingController _searchController = TextEditingController();
  final Debouncer debouncer = Debouncer(delay: Duration(milliseconds: 500));

  @override
  void dispose() {
    debouncer.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<SearchByNameBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Busqueda de menús')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              BlocBuilder<SearchByNameBloc, SearchByNameState>(
                builder: (context, state) {
                  return TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Buscar por nombre',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () => debouncer.run(() {
                          final char = _searchController.text.trim();
                          if (char.isNotEmpty) {
                            context.read<SearchByNameBloc>().add(
                              GetMealsByNameEvent(char),
                            );
                          }
                        }),
                      ),
                    ),
                    onSubmitted: (char) => debouncer.run(() {
                      if (char.isNotEmpty) {
                        context.read<SearchByNameBloc>().add(
                          GetMealsByNameEvent(char),
                        );
                      }
                    }),
                  );
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<SearchByNameBloc, SearchByNameState>(
                  builder: (context, state) {
                    if (state is SearchByNameLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SearchByNameLoaded) {
                      if (state.meals.isEmpty) {
                        return AppErrorScreen(
                          message: 'No se encontraron menús',
                          onRetry: () => context.read<SearchByNameBloc>().add(
                            GetMealsByNameEvent(_searchController.text),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: state.meals.length,
                          itemBuilder: (context, index) {
                            final meal = state.meals[index];
                            return AppMealTile(
                              id: meal.id,
                              name: meal.name,
                              image: meal.image?.small,
                            );
                          },
                        );
                      }
                    } else if (state is SearchByNameError) {
                      return AppErrorScreen(message: state.message);
                    } else if (state is SearchByNameInitial) {
                      return const Center(
                        child: Text('Utiliza el buscador para ver los menús.'),
                      );
                    }
                    return AppErrorScreen(message: 'Algo salió mal.');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
