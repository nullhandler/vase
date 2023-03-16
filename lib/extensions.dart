import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  DateTime copyTime(TimeOfDay from){
    return DateTime(year, month, day, from.hour, from.minute);
  }
  
  String formatDate(){
    return DateFormat("dd-MM-yyyy").format(this);
  }

  String formatTime(){
    return DateFormat("hh:mm a").format(this);
  }
}