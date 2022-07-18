import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin'),
    WorldTime(location: 'London', flag: 'england.png', url: 'Europe/London'),
    WorldTime(
        location: 'Cape Town',
        flag: 'southafrica.png',
        url: 'Africa/Johannesburg'),
    WorldTime(
        location: 'Sao Paulo', flag: 'brazil.png', url: 'America/Sao_Paulo'),
    WorldTime(
        location: 'New York', flag: 'usa_circle.png', url: 'America/New_York'),
    WorldTime(location: 'Tokyo', flag: 'japan.png', url: 'Asia/Tokyo'),
    WorldTime(location: 'Dubai', flag: 'uae_circle.png', url: 'Asia/Dubai'),
    WorldTime(
        location: 'Auckland',
        flag: 'newzealand_circle.png',
        url: 'Pacific/Auckland'),
    WorldTime(location: 'Toronto', flag: 'canada.png', url: 'America/Toronto'),
    WorldTime(
        location: 'Casablanca', flag: 'morocco.png', url: 'Africa/Casablanca'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    // navigate to home screen with data of instance
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  print(locations[index].location);
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
