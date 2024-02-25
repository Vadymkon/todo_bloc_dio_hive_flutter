
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const List<DropdownMenuEntry<String>> categories = [
  DropdownMenuEntry(value: '', label: ''),
  DropdownMenuEntry(value: 'Job', label: 'Job'),
  DropdownMenuEntry(value: 'Family', label: 'Family'),
  DropdownMenuEntry(value: 'Own', label: 'Own'),
];

const List<DropdownMenuEntry<String>> readyStates = [
  DropdownMenuEntry(value: '', label: ''),
  DropdownMenuEntry(value: 'ready', label: 'ready'),
  DropdownMenuEntry(value: 'not ready', label: 'not ready'),
];

/*  "Minimal layout, emphasis on logic."
ready minumum Icon-pack. In other cases - it will be just .cloud
*/

const Map<String,IconData> weatherMap =
{
  'Rain': CupertinoIcons.cloud_bolt_rain,
  'Sun' : CupertinoIcons.sun_dust,
  'Lightning' : CupertinoIcons.cloud_bolt_rain,
  'Clouds' : CupertinoIcons.cloud
};
