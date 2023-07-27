import 'package:flutter/material.dart';
import 'package:runner_plan_app/components/common/card_button_icon.dart';
import 'package:runner_plan_app/components/common/card_button_number.dart';
import 'package:runner_plan_app/components/workouts/performed_trainings.dart';
import 'package:runner_plan_app/core/app_routes.dart';

class DashboardPersonalPage extends StatelessWidget {
  const DashboardPersonalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                  textButton: 'Ver Todos',
                  functionButton: () {},
                ),
                CardButtonNumber(
                  title: 'Atletas Sem Treino',
                  number: 10,
                  textButton: 'Ver Todos',
                  functionButton: () {},
                ),
              ],
            ),
            PerformedTrainings(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CardButtonIcon(
                  icon: Icons.person_add,
                  actionText: 'Novo Atleta',
                  functionButton: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.NewAthlete,
                    );
                  },
                ),
                CardButtonIcon(
                  icon: Icons.calendar_month,
                  actionText: 'Nova Planilha',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
