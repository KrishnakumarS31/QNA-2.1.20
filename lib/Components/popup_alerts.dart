import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_alert_box.dart';

class CustomPopupAlerts {
  static Future<bool> nameMismatch(BuildContext context) async {
    var action = await CustomAlertDialog.customDialog(
        context,
        "Name mismatch",
        "Error Code: 404",
        "Retry", //"OK",
        null,
        Icons.info_outline_rounded);
    return action == DialogAction.ok ? true : false;
  }
}
