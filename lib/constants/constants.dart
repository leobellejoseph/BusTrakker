import 'package:flutter/material.dart';

const label = {
  1: 'Incoming',
  2: 'Next',
  3: 'Third',
};
const kBusStopTileSize = 190.0;
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
const kArriving = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 22,
  color: Colors.blue,
);
