import 'package:flutter/material.dart';
import 'package:runner_plan_app/pages/dashboard/dashboard_personal_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return DashboardPersonalPage();
  }
}
