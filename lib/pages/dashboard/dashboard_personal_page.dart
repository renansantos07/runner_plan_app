import 'package:flutter/material.dart';

class DashboardPersonalPage extends StatelessWidget {
  const DashboardPersonalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                child: Card(
                  // elevation: 0,
                  // shape: RoundedRectangleBorder(
                  //   side: BorderSide(
                  //     color: Theme.of(context).colorScheme.primary,
                  //   ),
                  //   borderRadius: const BorderRadius.all(Radius.circular(12)),
                  // ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Atletas Ativos',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          Text(
                            '10',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Card(
                  // elevation: 0,
                  // shape: RoundedRectangleBorder(
                  //   side: BorderSide(
                  //     color: Theme.of(context).colorScheme.primary,
                  //   ),
                  //   borderRadius: const BorderRadius.all(Radius.circular(12)),
                  // ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Atletas Sem Treino',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          Text(
                            '10',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Card(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.rocket_launch_rounded),
                      title: Text('Novos Treinos Realizados'),
                    ),
                    SizedBox(
                      height: 300,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Card(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              child: const ListTile(
                                title: Text("teste"),
                                subtitle: Text("teste teste teste"),
                              ),
                            ),
                            Card(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              child: const ListTile(
                                title: Text("teste"),
                                subtitle: Text("teste teste teste"),
                              ),
                            ),
                            Card(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              child: const ListTile(
                                title: Text("teste"),
                                subtitle: Text("teste teste teste"),
                              ),
                            ),
                            Card(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              child: const ListTile(
                                title: Text("teste"),
                                subtitle: Text("teste teste teste"),
                              ),
                            ),
                            Card(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              child: const ListTile(
                                title: Text("teste"),
                                subtitle: Text("teste teste teste"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
