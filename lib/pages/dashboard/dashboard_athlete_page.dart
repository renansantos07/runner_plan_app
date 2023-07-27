import 'package:flutter/material.dart';

class DashboardAthletePage extends StatelessWidget {
  const DashboardAthletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _index = 0;
    final workouts = [
      {
        "nome": "Treino 1",
        "velocidade": "10",
      },
      {
        "nome": "Treino 2",
        "velocidade": "5",
      },
      {
        "nome": "Treino 3",
        "velocidade": "20",
      },
      {
        "nome": "Treino 4",
        "velocidade": "4",
      }
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Card(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ListTile(
                    leading: Icon(Icons.run_circle_outlined),
                    title: Text('Plano de Treinamento'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  Container(
                    height: 200,
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: PageView.builder(
                        itemCount: workouts.length,
                        controller: PageController(viewportFraction: 0.7),
                        // onPageChanged: (int index) =>
                        //     setState(() => _index = index),
                        itemBuilder: (_, i) {
                          return Transform.scale(
                            scale: i == _index ? 1 : 0.9,
                            child: Card(
                              color: Theme.of(context).colorScheme.background,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title:
                                          Text('${workouts[i]['nome']} - Qui'),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Tipo de Treino: ${workouts[i]['velocidade']}',
                                          ),
                                          Text(
                                            'Distancia: ${workouts[i]['velocidade']}',
                                          ),
                                          Text(
                                            'Pace: ${workouts[i]['velocidade']}',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        TextButton(
                                          child: const Text('Registrar Treino'),
                                          onPressed: () {/* ... */},
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.rocket_launch_rounded),
            title: Text('Acessoria'),
          ),
          const Center(
            child: Card(
              margin: EdgeInsets.all(10),
              elevation: 1,
              child: SizedBox(
                width: 400,
                height: 150,
                child: Center(
                  child: Text('Filled Card'),
                ),
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text('Provas'),
          ),
          const Center(
            child: Card(
              margin: EdgeInsets.all(10),
              elevation: 1,
              child: SizedBox(
                width: 400,
                height: 150,
                child: Center(
                  child: Text('User card'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    // floatingActionButton: FloatingActionButton(
    //   //Floating action button on Scaffold
    //   onPressed: () {
    //     //code to execute on button press
    //   }, //icon inside button
    //   backgroundColor: Theme.of(context).primaryColor,
    //   shape: const CircleBorder(),
    //   child: const Icon(
    //     Icons.add,
    //     color: Colors.white,
    //   ),
    // ),

    // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    //floating action button location to left

    // bottomNavigationBar: BottomAppBar(
    //   clipBehavior: Clip.antiAlias,
    //   //bottom navigation bar on scaffold
    //   color: Theme.of(context).primaryColor,
    //   shape: CircularNotchedRectangle(), //shape of notch
    //   notchMargin:
    //       5, //notche margin between floating button and bottom appbar
    //   child: Row(
    //     //children inside bottom appbar
    //     mainAxisSize: MainAxisSize.max,
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: <Widget>[
    //       IconButton(
    //         icon: Icon(
    //           Icons.home_outlined,
    //           color: Colors.grey.shade200,
    //         ),
    //         onPressed: () {},
    //       ),
    //       Padding(
    //         padding: EdgeInsets.only(right: 90),
    //         child: IconButton(
    //           icon: Icon(
    //             Icons.run_circle_outlined,
    //             color: Colors.white,
    //           ),
    //           onPressed: () {},
    //         ),
    //       ),
    //       IconButton(
    //         icon: Icon(
    //           Icons.chat,
    //           color: Colors.white,
    //         ),
    //         onPressed: () {},
    //       ),
    //       IconButton(
    //         icon: Icon(
    //           Icons.supervised_user_circle_outlined,
    //           color: Colors.white,
    //         ),
    //         onPressed: () {},
    //       ),
    //     ],
    //   ),
    // ),
  }
}
