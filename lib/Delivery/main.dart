import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_notifier.dart';
import 'core/localization/app_localizations.dart';
import 'features/customer/auth/screens/splash_screen.dart';
import 'features/customer/auth/screens/login_screen.dart';
import 'features/customer/auth/screens/registration_choice_screen.dart';
import 'features/customer/auth/screens/phone_entry_screen.dart';
import 'features/customer/auth/screens/otp_screen.dart';
import 'features/customer/auth/screens/signup_screen.dart';
import 'features/customer/auth/screens/email_signup_screen.dart';
import 'features/driver/services/driver_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const ProviderScope(child: SavoraApp()));
}

// ── GoRouter ─────────────────────────────────────────────────────────────────
// Single router for the whole app.
// Customer screens use GoRoute (no shell — they have their own full-screen UI).
// Driver screens use ShellRoute with a bottom nav (inside driverRoutes).
final _appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false,
  routes: [

    // ── Splash ──────────────────────────────────────────────────────────────
    GoRoute(
      path: '/',
      builder: (_, __) => const SplashScreen(),
    ),

    // ── Customer auth ────────────────────────────────────────────────────────
    GoRoute(
      path: '/login',
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (_, __) => const RegistrationChoiceScreen(),
    ),
    GoRoute(
      path: '/phone-entry',
      builder: (_, __) => const PhoneEntryScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (_, __) => const OtpScreen(phone: '',),
    ),
    GoRoute(
      path: '/signup',
      builder: (_, __) => const SignupScreen(),
    ),
    GoRoute(
      path: '/email-signup',
      builder: (_, __) => const EmailSignupScreen(),
    ),

    // ── Driver module (all under /driver/*) ─────────────────────────────────
    ...driverRoutes,
  ],
);

// ── Root App ──────────────────────────────────────────────────────────────────
class SavoraApp extends StatefulWidget {
  const SavoraApp({super.key});

  @override
  State<SavoraApp> createState() => _SavoraAppState();
}

class _SavoraAppState extends State<SavoraApp> {
  @override
  void initState() {
    super.initState();
    localeProvider.addListener(_rebuild);
    themeModeNotifier.addListener(_rebuild);
  }

  @override
  void dispose() {
    localeProvider.removeListener(_rebuild);
    themeModeNotifier.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Savora',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeModeNotifier.value,
      locale: localeProvider.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: _appRouter,
    );
  }
}
