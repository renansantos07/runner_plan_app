import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runner_plan_app/pages/auth/auth_or_app_page.dart';
import 'package:runner_plan_app/pages/dashboard_page.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF1460A5),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFD3E4FF),
  onPrimaryContainer: Color(0xFF001C38),
  secondary: Color(0xFF545F70),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD7E3F8),
  onSecondaryContainer: Color(0xFF111C2B),
  tertiary: Color(0xFF4359A9),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFDCE1FF),
  onTertiaryContainer: Color(0xFF001550),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFDFCFF),
  onBackground: Color(0xFF1A1C1E),
  surface: Color(0xFFFDFCFF),
  onSurface: Color(0xFF1A1C1E),
  surfaceVariant: Color(0xFFDFE2EB),
  onSurfaceVariant: Color(0xFF43474E),
  outline: Color(0xFF73777F),
  onInverseSurface: Color(0xFFF1F0F4),
  inverseSurface: Color(0xFF2F3033),
  inversePrimary: Color(0xFFA2C9FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF1460A5),
  outlineVariant: Color(0xFFC3C6CF),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFA2C9FF),
  onPrimary: Color(0xFF00315B),
  primaryContainer: Color(0xFF004881),
  onPrimaryContainer: Color(0xFFD3E4FF),
  secondary: Color(0xFFBBC7DB),
  onSecondary: Color(0xFF263141),
  secondaryContainer: Color(0xFF3C4758),
  onSecondaryContainer: Color(0xFFD7E3F8),
  tertiary: Color(0xFFB6C4FF),
  onTertiary: Color(0xFF0A2978),
  tertiaryContainer: Color(0xFF294190),
  onTertiaryContainer: Color(0xFFDCE1FF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF1A1C1E),
  onBackground: Color(0xFFE3E2E6),
  surface: Color(0xFF1A1C1E),
  onSurface: Color(0xFFE3E2E6),
  surfaceVariant: Color(0xFF43474E),
  onSurfaceVariant: Color(0xFFC3C6CF),
  outline: Color(0xFF8D9199),
  onInverseSurface: Color(0xFF1A1C1E),
  inverseSurface: Color(0xFFE3E2E6),
  inversePrimary: Color(0xFF1460A5),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFA2C9FF),
  outlineVariant: Color(0xFF43474E),
  scrim: Color(0xFF000000),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(
          listTileTheme: ListTileThemeData(
            iconColor: Color(0xFFA2C9FF),
            titleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Color(0xFFA2C9FF),
                ),
          ),
          useMaterial3: true,
          colorScheme: darkColorScheme),
      home: const AuthOrAppPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
