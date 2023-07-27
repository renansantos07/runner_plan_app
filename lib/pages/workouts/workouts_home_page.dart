import 'package:flutter/material.dart';
import 'package:runner_plan_app/components/common/card_button_icon.dart';

class WorkoutsHomePage extends StatelessWidget {
  const WorkoutsHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 50),
            child: Column(children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Treino",
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ),
              Text(
                "Consulte informações relacionadas aos treinos do seus atletas!",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              )
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CardButtonIcon(
                icon: Icons.calendar_month,
                actionText: 'Nova Planilha',
              ),
              CardButtonIcon(
                icon: Icons.run_circle,
                actionText: 'Provas',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CardButtonIcon(
                icon: Icons.today,
                actionText: 'Aulas Presenciais',
              ),
              CardButtonIcon(
                icon: Icons.event_available,
                actionText: 'Treinos Realizados',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
