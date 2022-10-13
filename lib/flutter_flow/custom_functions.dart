//import 'dart:math' as math;

//import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:intl/intl.dart';
//import 'package:timeago/timeago.dart' as timeago;
//import 'lat_lng.dart';
//import 'place.dart';
//import '../backend/backend.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import '../../auth/auth_util.dart';

double? miniValueFunction(double masterValue) {
  if (masterValue > 0) {
    return masterValue / 4;
  } else {
    return masterValue;
  }
}

String? modifyPhoneNumbers(String phoneNumber) {
  String num = phoneNumber.toString();

  if (phoneNumber == "") {
    return "";
  } else {
    return num[0] +
        num[1] +
        " " +
        "(" +
        num[2] +
        num[3] +
        num[4] +
        ")" +
        " " +
        num[5] +
        num[6] +
        num[7] +
        " " +
        num[8] +
        num[9] +
        num[10] +
        num[11];
  }
}

String? modifyPhoneNoCode(String phoneNumber) {
  String num = phoneNumber.toString();

  if (phoneNumber == "") {
    return "";
  } else {
    return "(" +
        num[2] +
        num[3] +
        num[4] +
        ")" +
        " " +
        num[5] +
        num[6] +
        num[7] +
        " " +
        num[8] +
        num[9] +
        num[10] +
        num[11];
  }
}
