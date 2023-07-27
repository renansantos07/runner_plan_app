import 'package:flutter/material.dart';

class CardButtonNumber extends StatelessWidget {
  CardButtonNumber({
    Key? key,
    required this.title,
    required this.number,
    this.textButton = "",
    this.color,
    this.functionButton,
  }) : super(key: key);

  final String title;
  final double number;
  final String textButton;
  final Color? color;
  final Function()? functionButton;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: functionButton ?? () {},
        child: Card(
          surfaceTintColor: color,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            // height: 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        color: color ?? Theme.of(context).colorScheme.primary),
                  ),
                  Text(
                    number.toStringAsFixed(0),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: color ?? Theme.of(context).colorScheme.primary),
                  ),
                  if (textButton.isNotEmpty)
                    Text(
                      textButton,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color:
                              color ?? Theme.of(context).colorScheme.primary),
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}
