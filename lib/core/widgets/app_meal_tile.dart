import 'package:flutter/material.dart';

class AppMealTile extends StatelessWidget {
  const AppMealTile({super.key, this.image, this.name});
  final String? image;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        backgroundImage: image == null ? null : NetworkImage(image!),
      ),
      title: Text(name ?? 'Unknown name'),
    );
  }
}
