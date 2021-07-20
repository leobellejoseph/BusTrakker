import 'package:flutter/material.dart';

const kAppName = 'myBus';
// const kBusLoad = {
//   'SEA': 'Seats Available',
//   'SDA': 'Standing Available',
//   'LSD': 'Limited Standing'
// };
// const kBusFeature = {'WAB': FontAwesomeIcons.wheelchair};
// const kOperators = {
//   'SBST': 'SBS', // 'SBST': 'SBS Transit',
//   'SMRT': 'SMRT', // 'SMRT': 'SMRT Corporation',
//   'TTS': 'TowerTransit', // 'TTS': 'Tower Transit Singapore',
//   'GAS': 'GoAhead', // 'GAS': 'Go Ahead Singapore',
// };
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
    fontWeight: FontWeight.bold, fontSize: 24, color: Colors.blueAccent);
const kArriving =
    TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: Colors.blue);
