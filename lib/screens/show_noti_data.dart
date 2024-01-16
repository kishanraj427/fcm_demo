import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class ShowNotificationData extends StatefulWidget {
  String title, message;
  Map<String, dynamic> data;

  ShowNotificationData({super.key, required this.title, required this.message, required this.data});

  @override
  State<ShowNotificationData> createState() => _ShowNotificationDataState();
}

class _ShowNotificationDataState extends State<ShowNotificationData> {
  
  final textSTyle = const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text("Notification Page", style: textSTyle,),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Showing the title of the incoming notification
          Text(
            "Title: ${widget.title}",
            style: textSTyle, 
          ),
          // Showing the body of the incoming notification
          Text(
            "Message: ${widget.message}",
            style: textSTyle
          ),
          // Showing the other data passed by the incoming notification
          Text(
            "Data: ${widget.data.toString()}",
            style: textSTyle
          ),
        ]
      ),
    );
  }
}
