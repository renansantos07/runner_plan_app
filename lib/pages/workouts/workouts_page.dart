import 'package:flutter/material.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Treino"),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            Text(
                "Consulte informações relacionadas ao seus treinos disponibilizadas pelo seu personal!")
          ]),
        ),
      ),
    );
  }
}
