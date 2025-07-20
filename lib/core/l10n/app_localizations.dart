import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get welcome;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @start_title.
  ///
  /// In en, this message translates to:
  /// **'Discover your best version here'**
  String get start_title;

  /// No description provided for @start_body.
  ///
  /// In en, this message translates to:
  /// **'Easily browse and schedule appointments for beauty, hair and wellness services tailored to your needs and style.'**
  String get start_body;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone_number;

  /// No description provided for @account_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your account'**
  String get account_hint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @password_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get password_hint;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgot_password;

  /// No description provided for @remember_me.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get remember_me;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get sign_in;

  /// No description provided for @terms_1.
  ///
  /// In en, this message translates to:
  /// **'By successfully logging in, you agree to our '**
  String get terms_1;

  /// No description provided for @terms_2.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get terms_2;

  /// No description provided for @terms_3.
  ///
  /// In en, this message translates to:
  /// **' and our '**
  String get terms_3;

  /// No description provided for @terms_4.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get terms_4;

  /// No description provided for @successful_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Successful sign in'**
  String get successful_sign_in;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get sign_up;

  /// No description provided for @have_account.
  ///
  /// In en, this message translates to:
  /// **'Have an account?'**
  String get have_account;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account'**
  String get dont_have_account;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Names'**
  String get name;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Surnames'**
  String get lastName;

  /// No description provided for @name_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get name_hint;

  /// No description provided for @birthdate.
  ///
  /// In en, this message translates to:
  /// **'Birthdate'**
  String get birthdate;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @hair.
  ///
  /// In en, this message translates to:
  /// **'Hair'**
  String get hair;

  /// No description provided for @nails.
  ///
  /// In en, this message translates to:
  /// **'Nails'**
  String get nails;

  /// No description provided for @spa.
  ///
  /// In en, this message translates to:
  /// **'Spa'**
  String get spa;

  /// No description provided for @makeup.
  ///
  /// In en, this message translates to:
  /// **'Make-up'**
  String get makeup;

  /// No description provided for @server_error.
  ///
  /// In en, this message translates to:
  /// **'Server error'**
  String get server_error;

  /// No description provided for @cache_error.
  ///
  /// In en, this message translates to:
  /// **'Cache error'**
  String get cache_error;

  /// No description provided for @network_connection_error.
  ///
  /// In en, this message translates to:
  /// **'Network connection error'**
  String get network_connection_error;

  /// No description provided for @unexpected_error.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error'**
  String get unexpected_error;

  /// No description provided for @password_error.
  ///
  /// In en, this message translates to:
  /// **'Password error'**
  String get password_error;

  /// No description provided for @incomplete_fields.
  ///
  /// In en, this message translates to:
  /// **'Incomplete Fields'**
  String get incomplete_fields;

  /// No description provided for @model_not_found_error.
  ///
  /// In en, this message translates to:
  /// **'The user is not registered'**
  String get model_not_found_error;

  /// No description provided for @invalid_user_email_error.
  ///
  /// In en, this message translates to:
  /// **'The format of the email entered is not correct'**
  String get invalid_user_email_error;

  /// No description provided for @invalid_user_birthdate_error.
  ///
  /// In en, this message translates to:
  /// **'The date of birth is invalid'**
  String get invalid_user_birthdate_error;

  /// No description provided for @user_already_exists_error.
  ///
  /// In en, this message translates to:
  /// **'The user is already registered'**
  String get user_already_exists_error;

  /// No description provided for @invalid_user_name_error.
  ///
  /// In en, this message translates to:
  /// **'The username is invalid'**
  String get invalid_user_name_error;

  /// No description provided for @invalid_dni_error.
  ///
  /// In en, this message translates to:
  /// **'The ID is invalid'**
  String get invalid_dni_error;

  /// No description provided for @invalid_phone_number_error.
  ///
  /// In en, this message translates to:
  /// **'The format of cell phone number is invalid'**
  String get invalid_phone_number_error;

  /// No description provided for @invalid_user_password_error.
  ///
  /// In en, this message translates to:
  /// **'The format of the password is invalid'**
  String get invalid_user_password_error;

  /// No description provided for @change_language.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get change_language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @info_change_language.
  ///
  /// In en, this message translates to:
  /// **'Change the language of buttons, titles and other text in \'Antonella\'.'**
  String get info_change_language;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get dark_mode;

  /// No description provided for @select_mode.
  ///
  /// In en, this message translates to:
  /// **'Select a mode'**
  String get select_mode;

  /// No description provided for @info_dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Switch between dark and light modes as needed, right from this screen.'**
  String get info_dark_mode;

  /// No description provided for @activated.
  ///
  /// In en, this message translates to:
  /// **'Activated'**
  String get activated;

  /// No description provided for @disabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// No description provided for @use_system_configuration.
  ///
  /// In en, this message translates to:
  /// **'Use system configuration'**
  String get use_system_configuration;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

  /// No description provided for @log_out.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get log_out;

  /// No description provided for @purchases.
  ///
  /// In en, this message translates to:
  /// **'Purchases'**
  String get purchases;

  /// No description provided for @purchases_history.
  ///
  /// In en, this message translates to:
  /// **'Purchases History'**
  String get purchases_history;

  /// No description provided for @shopping_cart.
  ///
  /// In en, this message translates to:
  /// **'Shopping Cart'**
  String get shopping_cart;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @idm.
  ///
  /// In en, this message translates to:
  /// **'ENG'**
  String get idm;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @support_and_legal.
  ///
  /// In en, this message translates to:
  /// **'Support and Legal'**
  String get support_and_legal;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @technical_support.
  ///
  /// In en, this message translates to:
  /// **'Technical Support'**
  String get technical_support;

  /// No description provided for @no_notifications.
  ///
  /// In en, this message translates to:
  /// **'No Notifications'**
  String get no_notifications;

  /// No description provided for @notification_message.
  ///
  /// In en, this message translates to:
  /// **'We will let you know when there is something new for you.'**
  String get notification_message;

  /// No description provided for @administrator.
  ///
  /// In en, this message translates to:
  /// **'Administrator'**
  String get administrator;

  /// No description provided for @write_message.
  ///
  /// In en, this message translates to:
  /// **'Write a message...'**
  String get write_message;

  /// No description provided for @promotions.
  ///
  /// In en, this message translates to:
  /// **'Promotions'**
  String get promotions;

  /// No description provided for @no_promotions.
  ///
  /// In en, this message translates to:
  /// **'There are no promotions at this time'**
  String get no_promotions;

  /// No description provided for @agenda.
  ///
  /// In en, this message translates to:
  /// **'Agenda'**
  String get agenda;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// No description provided for @to_confirm.
  ///
  /// In en, this message translates to:
  /// **'To be confirmed'**
  String get to_confirm;

  /// No description provided for @january.
  ///
  /// In en, this message translates to:
  /// **'JANUARY'**
  String get january;

  /// No description provided for @february.
  ///
  /// In en, this message translates to:
  /// **'FEBRUARY'**
  String get february;

  /// No description provided for @march.
  ///
  /// In en, this message translates to:
  /// **'MARCH'**
  String get march;

  /// No description provided for @april.
  ///
  /// In en, this message translates to:
  /// **'APRIL'**
  String get april;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'MAY'**
  String get may;

  /// No description provided for @june.
  ///
  /// In en, this message translates to:
  /// **'JUNE'**
  String get june;

  /// No description provided for @july.
  ///
  /// In en, this message translates to:
  /// **'JULY'**
  String get july;

  /// No description provided for @august.
  ///
  /// In en, this message translates to:
  /// **'AUGUST'**
  String get august;

  /// No description provided for @september.
  ///
  /// In en, this message translates to:
  /// **'SEPTEMBER'**
  String get september;

  /// No description provided for @october.
  ///
  /// In en, this message translates to:
  /// **'OCTOBER'**
  String get october;

  /// No description provided for @november.
  ///
  /// In en, this message translates to:
  /// **'NOVEMBER'**
  String get november;

  /// No description provided for @december.
  ///
  /// In en, this message translates to:
  /// **'DECEMBER'**
  String get december;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'SU'**
  String get sunday;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'TH'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'F'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get saturday;

  /// No description provided for @no_appointments.
  ///
  /// In en, this message translates to:
  /// **'No appointments for this day'**
  String get no_appointments;

  /// No description provided for @welcome_user.
  ///
  /// In en, this message translates to:
  /// **'Welcome, '**
  String get welcome_user;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @iva.
  ///
  /// In en, this message translates to:
  /// **'Sale Tax'**
  String get iva;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
