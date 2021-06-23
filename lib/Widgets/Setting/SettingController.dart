import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Common/ResponseType.dart';

class SettingController {
  List<DropdownMenuItem> dropdownList = new List<DropdownMenuItem>();

  int _user;

//users = Common.avatars

  // retrieveAvatar() {
  //
  //   return new DropdownButton(
  //       hint: new Text('Choose your avatar') ,
  //       value:  _user == null ? null : Common.avatars[_user],
  //       items: Common.avatars.map( (String value)
  //       {
  //         return new DropdownMenuItem(
  //
  //             value:  value,
  //             child: new Text(value),
  //         );
  //       }).toList(),
  //     onChanged: (value) {
  //
  //         setState ( ()  {
  //           _user = Common.avatars.indexOf(value);
  //
  //         });
  //     },
  //
  //
  //   );
  //
  //
  // }

  // getAvatar(Function callSetState) {
  //   int value = 0;
  //   for (int i = 0; i < Common.avatars.length; i++) {
  //     dropdownList.add(
  //       DropdownMenuItem(
  //         child: CircleAvatar(
  //           //taking random pictures from the avatar list and assigning to users
  //           backgroundImage:
  //               ExactAssetImage("images/avatars/${Common.avatars[value]}"),
  //           minRadius: 38,
  //           maxRadius: 38,
  //         ),
  //         value: "images/avatars/${Common.avatars[value]}",
  //       ),
  //     );
  //     print(Common.avatars[value]);
  //     value++;
  //     callSetState();
  //   }
  // }
}

//onChanged: (String? newValue) {         setState(() {           dropdownValue = newValue!;         });       }
