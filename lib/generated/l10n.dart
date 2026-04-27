import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_localizations.dart';

extension L10nContextExt on BuildContext {
  L10n get l10n => L10n.of(this)!;
}

extension L10nStateExt on State {
  L10n get l10n => L10n.of(context)!;
}

L10n get l10n => L10n.of(Get.context!)!;
