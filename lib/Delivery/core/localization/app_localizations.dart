import 'package:flutter/material.dart';

final LocaleProvider localeProvider = LocaleProvider();

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('ar');
  Locale get locale => _locale;

  void setLocale(Locale l) {
    _locale = l;
    notifyListeners();
  }
}

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations? maybeOf(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  static AppLocalizations of(BuildContext context) =>
      maybeOf(context) ?? AppLocalizations(const Locale('en'));

  /// Returns the translated string for [key], or [key] itself as fallback.
  String t(String key) => (_strings[locale.languageCode]?[key] ??
      _strings['en']?[key] ??
      key);

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
    Locale('es'),
    Locale('fr'),
    Locale('zh'),
  ];

  // ── Embedded translations — no asset loading, no pubspec declaration needed ──
  static const Map<String, Map<String, String>> _strings = {
    'en': {
      'splashTagline': 'Happy meal. Happy life.\nYou deserve it, with love.',
      'tagline': 'Real food. Real flavor.\nHomemade meals from local kitchens, delivered.',
      'continueWithPhone': 'Continue with phone',
      'or': 'or',
      'continueWithGoogle': 'Continue with Google',
      'continueWithApple': 'Continue with Apple',
      'termsPrefix': 'By continuing you agree to our ',
      'terms': 'Terms',
      'and': ' and ',
      'privacyPolicy': 'Privacy Policy',
      'termsSuffix': '.',
      'whatsYourNumber': "What's your\nnumber?",
      'weWillTextYou': "We'll text you a code to verify it's really you.",
      'sendCode': 'Send code',
      'verifyYourNumber': 'Verify your\nnumber',
      'enterCode': 'Enter the 5-digit code sent to ',
      'resendCode': 'Resend code',
      'resendIn': 'Resend code in 0:',
      'verify': 'Verify',
      'youreIn': "You're in!",
      'welcome': "Welcome to Savora. Let's get you fed.",
      'welcomeBack': 'Welcome back, food lover',
      'joinFamily': 'Join the Savora family',
      'forgotPassword': 'Forgot password?',
      'alreadyHaveAccount': 'Already have an account? ',
      'orContinueWith': 'or continue with',
      'phoneOrUsername': 'Phone or Username',
      'password': 'Password',
      'logIn': 'Log In',
      'dontHaveAccount': "Don't have an account? ",
      'signUp': 'Sign Up',
      'createAccount': 'Create your account',
      'username': 'Username',
      'fullName': 'Full Name',
      'phoneNumber': 'Phone Number',
      'confirmPassword': 'Confirm Password',
      'skip': 'Skip',
      'next': 'Next',
      'getStarted': 'Get Started',
      'registerWithPhone': 'Register with\nPhone Number',
      'registerWithEmail': 'Register with\nEmail & Password',
      'emailAddress': 'Email Address',
      'catItalian': 'Italian',
      'catEgyptian': 'Egyptian',
      'catAsian': 'Asian',
      'catHealthy': 'Healthy',
      'catDesserts': 'Desserts',
    },
    'ar': {
      'splashTagline': 'وجبة سعيدة. حياة سعيدة.\nأنت تستحقها، مع الحب.',
      'tagline': 'طعام حقيقي. نكهة حقيقية.\nوجبات منزلية من مطابخ محلية، تُوصَل إليك.',
      'continueWithPhone': 'المتابعة بالهاتف',
      'or': 'أو',
      'continueWithGoogle': 'المتابعة مع جوجل',
      'continueWithApple': 'المتابعة مع أبل',
      'termsPrefix': 'بالمتابعة أنت توافق على ',
      'terms': 'الشروط',
      'and': ' و ',
      'privacyPolicy': 'سياسة الخصوصية',
      'termsSuffix': '.',
      'whatsYourNumber': 'ما هو\nرقمك؟',
      'weWillTextYou': 'سنرسل لك رمزًا للتحقق من هويتك.',
      'sendCode': 'إرسال الرمز',
      'verifyYourNumber': 'تأكيد\nرقمك',
      'enterCode': 'أدخل الرمز المكون من 5 أرقام المرسل إلى ',
      'resendCode': 'إعادة إرسال الرمز',
      'resendIn': 'إعادة الإرسال بعد 0:',
      'verify': 'تأكيد',
      'youreIn': 'مرحبًا بك!',
      'welcome': 'أهلاً بك في سافورا. دعنا نطعمك.',
      'welcomeBack': 'مرحبًا بعودتك يا عاشق الطعام',
      'joinFamily': 'انضم إلى عائلة سافورا',
      'forgotPassword': 'نسيت كلمة المرور؟',
      'alreadyHaveAccount': 'لديك حساب بالفعل؟ ',
      'orContinueWith': 'أو تابع بواسطة',
      'phoneOrUsername': 'الهاتف أو اسم المستخدم',
      'password': 'كلمة المرور',
      'logIn': 'تسجيل الدخول',
      'dontHaveAccount': 'ليس لديك حساب؟ ',
      'signUp': 'اشتراك',
      'createAccount': 'إنشاء حسابك',
      'username': 'اسم المستخدم',
      'fullName': 'الاسم الكامل',
      'phoneNumber': 'رقم الهاتف',
      'confirmPassword': 'تأكيد كلمة المرور',
      'skip': 'تخطى',
      'next': 'التالي',
      'getStarted': 'ابدأ',
      'registerWithPhone': 'التسجيل برقم\nالهاتف',
      'registerWithEmail': 'التسجيل بالبريد\nالإلكتروني',
      'emailAddress': 'البريد الإلكتروني',
      'catItalian': 'إيطالي',
      'catEgyptian': 'مصري',
      'catAsian': 'آسيوي',
      'catHealthy': 'صحي',
      'catDesserts': 'حلويات',
    },
    'es': {
      'splashTagline': 'Comida feliz, vida feliz.\nTe lo mereces, con amor.',
      'logIn': 'Iniciar sesión',
      'signUp': 'Registrarse',
      'password': 'Contraseña',
      'phoneNumber': 'Número de teléfono',
    },
    'fr': {
      'splashTagline': 'Repas heureux. Vie heureuse.\nVous le méritez, avec amour.',
      'logIn': 'Se connecter',
      'signUp': "S'inscrire",
      'password': 'Mot de passe',
      'phoneNumber': 'Numéro de téléphone',
    },
    'zh': {
      'splashTagline': '快乐用餐。快乐生活。\n你值得拥有，充满爱。',
      'logIn': '登录',
      'signUp': '注册',
      'password': '密码',
      'phoneNumber': '电话号码',
    },
  };
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar', 'es', 'fr', 'zh'].contains(locale.languageCode);

  @override
  // Now synchronous — no async file loading, no freeze.
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
