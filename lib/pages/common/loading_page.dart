import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(height: 10),
            Text(
              'Carregando...',
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.headlineSmall?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
