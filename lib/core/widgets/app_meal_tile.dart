import 'package:aplazo_pt/features/details/presentation/pages/details_page.dart';
import 'package:flutter/material.dart';

class AppMealTile extends StatelessWidget {
  const AppMealTile({super.key, this.image, this.name, this.id});
  final String? image;
  final String? name;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: id == null
          ? null
          : () => Navigator.pushNamed(
              context,
              DetailsPage.routeName,
              arguments: id,
            ),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        backgroundImage: image == null ? null : NetworkImage(image!),
      ),
      title: Text(name ?? 'Unknown name'),
    );
  }
}
