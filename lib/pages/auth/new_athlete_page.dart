import 'package:flutter/material.dart';
import 'package:runner_plan_app/components/auth/new_athlete_form.dart';
import 'package:runner_plan_app/components/common/card_button_number.dart';

class NewAthletePage extends StatelessWidget {
  const NewAthletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        title: Text(
          "Novo Atleta",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CardButtonNumber(
                    title: 'Atletas Ativos',
                    number: 10,
                    color: Colors.green,
                    functionButton: () {},
                  ),
                  CardButtonNumber(
                    title: 'Vagas Disponíveis',
                    number: 10,
                    color: Colors.amber,
                    functionButton: () {},
                  ),
                ],
              ),
              newAthleteForm()
            ],
          ),
        ),
      ),
    );
  }
}
