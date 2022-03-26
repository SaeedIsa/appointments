import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  /// ************ App labels ************///
  String get appName;

  /// ************ Common labels ************///
  String get error;

  String get success;

  String get sent;

  String get successSent;

  String get submit;

  String get labelSelectLanguage;

  String get labelSignOut;

  String get labelContinue;

  /// ************ Landing labels ************///
  String get swiper1Title;
  String get swiper1SubTitle;
  String get swiper1Desc;

  String get swiper2Title;
  String get swiper2SubTitle;
  String get swiper2Desc;

  String get swiper3Title;
  String get swiper3SubTitle;
  String get swiper3Desc;

  String get swiper4Title;
  String get swiper4SubTitle;
  String get swiper4Desc;

  /// ************ Login labels ************///

  String get labelSignIn;

  String get labelEmail;

  String get labelPassword;

  String get labelForgotPassword;

  String get labelRememberMe;

  String get labelLogin;

  String get labelNoAccount;

  String get labelRegisterNow;

  String get labelEnterLoginDetails;

  String get labelUserName;

  /// ************ Forgot pass labels ************///
  String get labelForgot;

  String get labelFPassword;

  String get labelFMessage;

  /// ************ Registration labels ************///
  String get labelRegister;

  String get registerSuccess;

  String get labelAlreadyHaveAcc;

  String get labelLoginNow;

  String get labelRepeatPass;

  String get labelRegistrationConfirmMsg;

  String get labelTermsConditions;

  String get labelPrivacyPolicy;

  /// OTP ///
  String get labelMobileNumber;

  String get labelEnterOTP;

  String get labelMobileCodeSent;

  String get labelChange;
  String get labelResend;

  /// ************ Store labels ************///
  String get labelStore;

  String get labelOwner;

  String get labelStoreName;

  String get labelStoreAddress;

  String get labelStoreOwnerName;

  String get labelStoreOwnerNum;

  /// ************ Package labels ************///
  String get labelPackages;

  String get labelStatusDelivered;

  String get labelStatusPickedUp;

  String get labelStatusWaiting;

  String get deliveredMsg;

  String get pickedUpMsg;

  String get labelDeliveredPackages;

  String get labelContactDetails;

  String get labelStoreDetails;

  /// ************ New Package labels ************///
  String get labelNewPackage;

  String get labelClientName;

  String get labelName;

  String get labelClientPhone;

  String get labelAddress;

  String get labelPrice;

  String get labelDescription;

  String get labelDescriptionHint;

  String get labelPublish;

  String get labelUpdate;

  String get labelFlashPublish;

  String get publishSuccessMsg;

  /// ************ validation messages ************///
  String get emptyPrice;

  String get validPrice;

  String get validPhone;

  String get emptyContact;

  String get emptyAddress;
}
