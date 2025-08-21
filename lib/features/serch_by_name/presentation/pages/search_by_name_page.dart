import 'package:aplazo_pt/features/serch_by_name/presentation/bloc/search_by_name_bloc/search_by_name_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SearchByNamePage extends StatefulWidget {
  const SearchByNamePage({super.key});

  @override
  State<SearchByNamePage> createState() => _SearchByNamePageState();
}

class _SearchByNamePageState extends State<SearchByNamePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<SearchByNameBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Meal Search')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              BlocBuilder<SearchByNameBloc, SearchByNameState>(
                builder: (context, state) {
                  return TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search by first letter',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          final char = _searchController.text.trim();
                          if (char.isNotEmpty) {
                            context.read<SearchByNameBloc>().add(
                              GetMealsByNameEvent(char.substring(0, 1)),
                            );
                          }
                        },
                      ),
                    ),
                    onSubmitted: (char) {
                      if (char.isNotEmpty) {
                        context.read<SearchByNameBloc>().add(
                          GetMealsByNameEvent(char.substring(0, 1)),
                        );
                      }
                    },
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
                        return const Center(child: Text('No meals found'));
                      } else {
                        return ListView.builder(
                          itemCount: state.meals.length,
                          itemBuilder: (context, index) {
                            final meal = state.meals[index];
                            return ListTile(
                              title: Text(meal.name ?? ''),
                              leading: meal.image != null
                                  ? Image.network(meal.image!.small!)
                                  : null,
                            );
                          },
                        );
                      }
                    } else if (state is SearchByNameError) {
                      return Center(child: Text(state.message));
                    } else if (state is SearchByNameInitial) {
                      return const Center(
                        child: Text('Search for meals by typing a letter'),
                      );
                    }
                    return const Center(child: Text('Something went wrong!'));
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
