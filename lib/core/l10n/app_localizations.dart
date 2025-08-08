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

  /// No description provided for @profile_picture.
  ///
  /// In en, this message translates to:
  /// **'Profile Picture'**
  String get profile_picture;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @galery.
  ///
  /// In en, this message translates to:
  /// **'Galery'**
  String get galery;

  /// No description provided for @image_cut.
  ///
  /// In en, this message translates to:
  /// **'Image Cut'**
  String get image_cut;

  /// No description provided for @change_password_full_info.
  ///
  /// In en, this message translates to:
  /// **'Complete the information to change your password correctly.'**
  String get change_password_full_info;

  /// No description provided for @last_password.
  ///
  /// In en, this message translates to:
  /// **'Last Password'**
  String get last_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @repeat_password.
  ///
  /// In en, this message translates to:
  /// **'Repeat Password'**
  String get repeat_password;

  /// No description provided for @updated_password.
  ///
  /// In en, this message translates to:
  /// **'Updated Password'**
  String get updated_password;

  /// No description provided for @not_same_password.
  ///
  /// In en, this message translates to:
  /// **'Passwords are not the same'**
  String get not_same_password;

  /// No description provided for @wrong_password.
  ///
  /// In en, this message translates to:
  /// **'The current password is incorrect'**
  String get wrong_password;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @select_technical_support.
  ///
  /// In en, this message translates to:
  /// **'Select one of the methods below to receive technical support:'**
  String get select_technical_support;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get email;

  /// No description provided for @contact_mail.
  ///
  /// In en, this message translates to:
  /// **'contacto@antonella.com'**
  String get contact_mail;

  /// No description provided for @good_moorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning, I have a problem with'**
  String get good_moorning;

  /// No description provided for @whatsapp.
  ///
  /// In en, this message translates to:
  /// **'Whatsapp'**
  String get whatsapp;

  /// No description provided for @instagram.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get instagram;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create_account;

  /// No description provided for @successful_sign_up.
  ///
  /// In en, this message translates to:
  /// **'Successful Sign Up'**
  String get successful_sign_up;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'Id'**
  String get id;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @select_gender.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get select_gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @write_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get write_new_password;

  /// No description provided for @enter_associated_email.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address associated with your account'**
  String get enter_associated_email;

  /// No description provided for @code_sent.
  ///
  /// In en, this message translates to:
  /// **'Code Sent'**
  String get code_sent;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @edit_account_information.
  ///
  /// In en, this message translates to:
  /// **'Edit Account Information'**
  String get edit_account_information;

  /// No description provided for @confirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get confirmation;

  /// No description provided for @code_sent_to_number.
  ///
  /// In en, this message translates to:
  /// **'The code has been sent to your phone number'**
  String get code_sent_to_number;

  /// No description provided for @enter_code.
  ///
  /// In en, this message translates to:
  /// **'Enter Code'**
  String get enter_code;

  /// No description provided for @right_code.
  ///
  /// In en, this message translates to:
  /// **'Right Code'**
  String get right_code;

  /// No description provided for @wrong_code.
  ///
  /// In en, this message translates to:
  /// **'Wrong Code'**
  String get wrong_code;

  /// No description provided for @product_added.
  ///
  /// In en, this message translates to:
  /// **'Product added'**
  String get product_added;

  /// No description provided for @add_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get add_to_cart;

  /// No description provided for @service_applied_to_promo.
  ///
  /// In en, this message translates to:
  /// **'Services applied to this promotion'**
  String get service_applied_to_promo;

  /// No description provided for @haircut.
  ///
  /// In en, this message translates to:
  /// **'Haircut'**
  String get haircut;

  /// No description provided for @manicure_and_pedicure.
  ///
  /// In en, this message translates to:
  /// **'Manicure and Pedicure'**
  String get manicure_and_pedicure;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @all_ages_service.
  ///
  /// In en, this message translates to:
  /// **'This is a service that applies to all ages.'**
  String get all_ages_service;

  /// No description provided for @total_billed.
  ///
  /// In en, this message translates to:
  /// **'Total Billed'**
  String get total_billed;

  /// No description provided for @total_customers.
  ///
  /// In en, this message translates to:
  /// **'Total Customers'**
  String get total_customers;

  /// No description provided for @total_to_receive.
  ///
  /// In en, this message translates to:
  /// **'Total to Receive'**
  String get total_to_receive;

  /// No description provided for @no_service_for_category.
  ///
  /// In en, this message translates to:
  /// **'There are no services for this category'**
  String get no_service_for_category;

  /// No description provided for @select_time_then_continue.
  ///
  /// In en, this message translates to:
  /// **'Select a time you prefer by swiping the screen to book the appointment, and then continue'**
  String get select_time_then_continue;

  /// No description provided for @requested_date.
  ///
  /// In en, this message translates to:
  /// **'Requested date:'**
  String get requested_date;

  /// No description provided for @requested_schedule.
  ///
  /// In en, this message translates to:
  /// **'Requested schedule:'**
  String get requested_schedule;

  /// No description provided for @approximate_value.
  ///
  /// In en, this message translates to:
  /// **'Approximate value:'**
  String get approximate_value;

  /// No description provided for @request_sent_succesfully.
  ///
  /// In en, this message translates to:
  /// **'Request sent successfully \n The administrator will contact you shortly'**
  String get request_sent_succesfully;

  /// No description provided for @submit_request.
  ///
  /// In en, this message translates to:
  /// **'Submit Request'**
  String get submit_request;

  /// No description provided for @delete_service.
  ///
  /// In en, this message translates to:
  /// **'Delete service'**
  String get delete_service;

  /// No description provided for @sure_delete_service.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the selected service?'**
  String get sure_delete_service;

  /// No description provided for @eliminate.
  ///
  /// In en, this message translates to:
  /// **'Eliminate'**
  String get eliminate;

  /// No description provided for @no_service_selected.
  ///
  /// In en, this message translates to:
  /// **'No services selected'**
  String get no_service_selected;

  /// No description provided for @appointment_started.
  ///
  /// In en, this message translates to:
  /// **'Appointment started'**
  String get appointment_started;

  /// No description provided for @start_appointment.
  ///
  /// In en, this message translates to:
  /// **'Start appointment'**
  String get start_appointment;

  /// No description provided for @customer_data.
  ///
  /// In en, this message translates to:
  /// **'Customer data'**
  String get customer_data;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @form_loaded.
  ///
  /// In en, this message translates to:
  /// **'Form Loaded'**
  String get form_loaded;

  /// No description provided for @appointment_ended.
  ///
  /// In en, this message translates to:
  /// **'Appointment ended'**
  String get appointment_ended;

  /// No description provided for @end_appointment.
  ///
  /// In en, this message translates to:
  /// **'End appointment'**
  String get end_appointment;

  /// No description provided for @form_saved.
  ///
  /// In en, this message translates to:
  /// **'Form saved'**
  String get form_saved;

  /// No description provided for @not_all_fields_completed.
  ///
  /// In en, this message translates to:
  /// **'You have not completed all fields'**
  String get not_all_fields_completed;

  /// No description provided for @appointment_confirmed.
  ///
  /// In en, this message translates to:
  /// **'Appointment confirmed'**
  String get appointment_confirmed;

  /// No description provided for @confirm_appointment.
  ///
  /// In en, this message translates to:
  /// **'Confirm appointment'**
  String get confirm_appointment;

  /// No description provided for @pay_now.
  ///
  /// In en, this message translates to:
  /// **'Pay now'**
  String get pay_now;

  /// No description provided for @no_appointments_to_be_confirmed.
  ///
  /// In en, this message translates to:
  /// **'There are no pending appointments to be confirmed.'**
  String get no_appointments_to_be_confirmed;

  /// No description provided for @see_more.
  ///
  /// In en, this message translates to:
  /// **'See more'**
  String get see_more;

  /// No description provided for @billing_information.
  ///
  /// In en, this message translates to:
  /// **'Billing information'**
  String get billing_information;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About:'**
  String get about;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get value;

  /// No description provided for @form_done.
  ///
  /// In en, this message translates to:
  /// **'Form done'**
  String get form_done;

  /// No description provided for @view_form.
  ///
  /// In en, this message translates to:
  /// **'View form'**
  String get view_form;

  /// No description provided for @add_service.
  ///
  /// In en, this message translates to:
  /// **'Add Service'**
  String get add_service;

  /// No description provided for @recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent;

  /// No description provided for @find_an_appointment.
  ///
  /// In en, this message translates to:
  /// **'Find an appointment'**
  String get find_an_appointment;

  /// No description provided for @states.
  ///
  /// In en, this message translates to:
  /// **'States'**
  String get states;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @appointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get appointment;

  /// No description provided for @control_panel.
  ///
  /// In en, this message translates to:
  /// **'Control Panel'**
  String get control_panel;

  /// No description provided for @manega_monitor_appointments.
  ///
  /// In en, this message translates to:
  /// **'Manage and monitor your appointments efficiently.'**
  String get manega_monitor_appointments;

  /// No description provided for @review_your_performance.
  ///
  /// In en, this message translates to:
  /// **'Review your performance and ensure good performance'**
  String get review_your_performance;

  /// No description provided for @no_purchases_yet.
  ///
  /// In en, this message translates to:
  /// **'You have no purchases yet'**
  String get no_purchases_yet;

  /// No description provided for @no_products_for_category.
  ///
  /// In en, this message translates to:
  /// **'There are no products for this category'**
  String get no_products_for_category;

  /// No description provided for @pay_products.
  ///
  /// In en, this message translates to:
  /// **'Pay products'**
  String get pay_products;

  /// No description provided for @confirm_purchase.
  ///
  /// In en, this message translates to:
  /// **'Confirm purchase'**
  String get confirm_purchase;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @nothing_found.
  ///
  /// In en, this message translates to:
  /// **'Nothing found'**
  String get nothing_found;

  /// No description provided for @what_looking_for.
  ///
  /// In en, this message translates to:
  /// **'What are you looking for?'**
  String get what_looking_for;

  /// No description provided for @not_implemented_yet.
  ///
  /// In en, this message translates to:
  /// **'Not implemented yet'**
  String get not_implemented_yet;

  /// No description provided for @not_available.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get not_available;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @activate_notifications.
  ///
  /// In en, this message translates to:
  /// **'Activate notifications'**
  String get activate_notifications;

  /// No description provided for @do_not_miss_out.
  ///
  /// In en, this message translates to:
  /// **'Don\'t miss out on anything!'**
  String get do_not_miss_out;

  /// No description provided for @set_up_push_notifications.
  ///
  /// In en, this message translates to:
  /// **'Set up push notifications so you know when you receive messages or notifications.'**
  String get set_up_push_notifications;

  /// No description provided for @discover_the_queen.
  ///
  /// In en, this message translates to:
  /// **'Discover the queen\n within you'**
  String get discover_the_queen;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get done;

  /// No description provided for @requieres_confirmation.
  ///
  /// In en, this message translates to:
  /// **'It requires your confirmation'**
  String get requieres_confirmation;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;
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
