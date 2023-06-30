import 'package:flutter/material.dart';

class CommunicationPage extends StatelessWidget {
  const CommunicationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comunicação"),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            Text(
                "Registre suas atividades e metas para que seu personal possa acompanhar sua evolução!")
          ]),
        ),
      ),
    );
  }
}
