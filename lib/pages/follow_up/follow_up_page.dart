import 'package:flutter/material.dart';

class followUpPage extends StatelessWidget {
  const followUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acompanhamento"),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            Text(
                "Acesse suas avaliações físicas e acesso contéudos disponibilizados pelo seu Personal!")
          ]),
        ),
      ),
    );
  }
}
