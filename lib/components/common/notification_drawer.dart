import 'package:flutter/material.dart';

class NotificationDrawer extends StatelessWidget {
  const NotificationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width,
    );
  }
}
