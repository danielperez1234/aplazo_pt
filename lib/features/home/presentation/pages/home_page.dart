import 'package:aplazo_pt/core/widgets/app_error_screen.dart';
import 'package:aplazo_pt/core/widgets/app_progreess_window.dart';
import 'package:aplazo_pt/features/home/domain/entities/home_list_item.dart';
import 'package:aplazo_pt/features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/widgets/app_meal_tile.dart';
import '../../../serch_by_name/presentation/pages/search_by_name_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<HomeBloc>()..add(const GetCategoriesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, SearchByNamePage.routeName);
              },
            ),
          ],
        ),
        body: const _HomeView(),
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading && state.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeError) {
          return AppErrorScreen(
            message: state.message,
            onRetry: () =>
                context.read<HomeBloc>().add(const GetCategoriesEvent()),
          );
        }

        if (state.items.isEmpty) {
          return const Center(child: Text('No categories found.'));
        }

        return Stack(
          children: [
            ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                if (item is HomeCategoryItem) {
                  return ListTile(
                    title: Text(
                      item.category,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      context.read<HomeBloc>().add(
                        GetMealsByCategoryEvent(item.category),
                      );
                    },
                  );
                } else if (item is HomeMealItem) {
                  return AppMealTile(
                    name: item.meal.name,
                    image: item.meal.image?.small,
                    id: item.meal.id,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            if (state is HomeLoading && state.items.isNotEmpty)
              AppProgreessWindow(),
          ],
        );
      },
    );
  }
}
