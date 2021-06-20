import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Common/ResponseType.dart';

class SettingController {
  List<DropdownMenuItem> dropdownList = new List<DropdownMenuItem>();

  getAvatar(Function callSetState) {
    int value = 0;
    for (int i = 0; i < Common.avatars.length; i++) {
      dropdownList.add(
        DropdownMenuItem(
          child: CircleAvatar(
            //taking random pictures from the avatar list and assigning to users
            backgroundImage:
                ExactAssetImage("images/avatars/${Common.avatars[value]}"),
            minRadius: 35,
            maxRadius: 35,
          ),
          value: "images/avatars/${Common.avatars[value]}",
        ),
      );
      value++;
      callSetState();
    }
  }
}
