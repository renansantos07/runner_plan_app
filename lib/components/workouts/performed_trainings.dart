import 'package:flutter/material.dart';

class PerformedTrainings extends StatelessWidget {
  const PerformedTrainings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                height: 240,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        elevation: 0,
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: const ListTile(
                          title: Text("teste"),
                          subtitle: Text("teste teste teste"),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: const ListTile(
                          title: Text("teste"),
                          subtitle: Text("teste teste teste"),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: const ListTile(
                          title: Text("teste"),
                          subtitle: Text("teste teste teste"),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: const ListTile(
                          title: Text("teste"),
                          subtitle: Text("teste teste teste"),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: const ListTile(
                          title: Text("teste"),
                          subtitle: Text("teste teste teste"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text('Ver todos'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
