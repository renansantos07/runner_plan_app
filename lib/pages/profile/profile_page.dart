import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runner_plan_app/components/common/user_image.dart';
import 'package:runner_plan_app/components/profile/profile_form.dart';
import 'package:runner_plan_app/core/interface/Auth/auth_interface.dart';
import 'package:runner_plan_app/core/interface/user/user_interface.dart';
import 'package:runner_plan_app/core/model/common/session_user_model.dart';
import 'package:runner_plan_app/core/service/user/user_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final keyFormProfile = GlobalKey<ProfileFormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        title: Text(
          "Perfil",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Builder(
                  builder: (context) => TextButton(
                    child: Text(
                      "Salvar",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    onPressed: () =>
                        {keyFormProfile.currentState?.saveProfile()},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary),
                    height: 300,
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 10),
                    alignment: Alignment.topRight,
                    child: Center(
                      child: Column(
                        children: [
                          Column(
                            children: <Widget>[
                              Hero(
                                tag: user.id,
                                child: UserImage(
                                  imageUrl: user.imageURL,
                                  width: 150,
                                  height: 150,
                                  canChange: true,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${user.name} ${user.surname}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                          Text(
                            user.email,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              constraints: BoxConstraints(
                  minHeight: 100, minWidth: double.infinity, maxHeight: 400),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Theme.of(context).colorScheme.background,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary,
                    spreadRadius: 15,
                  ),
                  BoxShadow(
                      color: Theme.of(context).colorScheme.background,
                      offset: const Offset(0, 20)),
                ],
              ),
              child: Center(
                  child: ProfileForm(key: keyFormProfile, userId: user.id)),
            )
          ],
        ),
      ),
    );
  }
}
