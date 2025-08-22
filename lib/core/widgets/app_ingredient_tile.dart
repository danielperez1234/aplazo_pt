import 'package:flutter/material.dart';

class AppIngredientTile extends StatelessWidget {
  const AppIngredientTile({super.key, this.image, this.name, this.measure});
  final String? image;
  final String? name;
  final String? measure;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        backgroundImage: image == null ? null : NetworkImage(image!),
      ),
      title: Text(name ?? 'Unknown name'),
      trailing: Text(measure ?? 'medida desconocida'),
    );
  }
}
