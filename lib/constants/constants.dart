import 'package:flutter/material.dart';

const kItemSize = 210.0;
const kAppName = 'myBus';
const kBusType = {
  'DD': 'Double',
  'SD': 'Single',
  'BD': 'Bendy',
};
const kBusLoad = {'SEA': 'Seats Avl.', 'SDA': 'Standing', 'LSD': 'Limited'};
const kBusFeature = {'WAB': Icons.wheelchair_pickup_outlined};
const kOperators = {
  'SBST': 'SBS',
  'SMRT': 'SMRT',
  'TTS': 'Tower Transit',
  'GAS': 'Go Ahead',
};
const kMinuteArrival = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 26, color: Colors.blueAccent);
const kArriving =
    TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: Colors.blue);
