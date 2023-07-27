import 'package:flutter/material.dart';

class CardButtonIcon extends StatelessWidget {
  CardButtonIcon({
    Key? key,
    required this.icon,
    required this.actionText,
    this.functionButton,
    this.iconSize = 50,
  }) : super(key: key);

  final String actionText;
  final IconData icon;
  final double iconSize;
  final Function()? functionButton;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: functionButton ?? () {},
      child: Card(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          height: 120,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  size: iconSize,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  actionText,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
