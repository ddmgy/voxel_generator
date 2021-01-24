import 'package:flutter/material.dart';

class HomeFilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IconButton(
    icon: Icon(Icons.filter_list),
    onPressed: () => Scaffold.of(context).openEndDrawer(),
  );
}
