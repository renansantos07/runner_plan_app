import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runner_plan_app/components/common/app_drawer.dart';
import 'package:runner_plan_app/components/common/notification_drawer.dart';
import 'package:runner_plan_app/core/app_routes.dart';
import 'package:runner_plan_app/core/interface/Auth/auth_interface.dart';
import 'package:runner_plan_app/core/model/common/session_user_model.dart';
import 'package:runner_plan_app/core/service/user/user_provider.dart';
import 'package:runner_plan_app/pages/communication/communication_page.dart';
import 'package:runner_plan_app/pages/dashboard/dashboard_page.dart';
import 'package:runner_plan_app/pages/follow_up/follow_up_page.dart';
import 'package:runner_plan_app/pages/workouts/workouts_home_page.dart';

import '../../components/common/user_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Map<String, Object>>? _screens;
  @override
  void initState() {
    super.initState();
    _screens = [
      {
        'screen': const DashboardPage(),
      },
      {
        'screen': const WorkoutsHomePage(),
      },
      {
        'screen': const CommunicationPage(),
      },
      {
        'screen': const followUpPage(),
      }
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              iconTheme: IconThemeData(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
              backgroundColor: Theme.of(context).colorScheme.background,
              centerTitle: true,
              title: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Hero(
                        tag: _user.id,
                        child: UserImage(
                          imageUrl: _user.imageURL,
                          width: 50,
                          height: 50,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.Profile,
                        );
                      },
                    )
                  ],
                ),
                title: Text(
                  'Olá,',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                subtitle: Text(
                  _user.name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Builder(
                        builder: (context) => IconButton(
                          icon: Icon(
                            Icons.notifications,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                          onPressed: () => Scaffold.of(context).openEndDrawer(),
                          tooltip: MaterialLocalizations.of(context)
                              .openAppDrawerTooltip,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          : null,
      drawer: const AppDrawer(),
      endDrawer: const NotificationDrawer(),
      body: _screens![_selectedIndex]['screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Theme.of(context).colorScheme.primary,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Treinos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Comunicação',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart),
            label: 'Acompanhamento',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onBackground,
        onTap: _onItemTapped,
      ),
    );
  }
}
