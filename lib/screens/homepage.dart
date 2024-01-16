import 'dart:convert';
import 'package:flutter/material.dart';
import '../firebaseAPI/send_fcm.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titleController = TextEditingController();
  final messageController = TextEditingController();
  final dataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("FCM Text",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: messageController,
            decoration: InputDecoration(
                labelText: "Message",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: dataController,
            decoration: InputDecoration(
                labelText: "Data(JSON)",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          const SizedBox(
            height: 8,
          ),
          FilledButton(
              onPressed: () {
                sendMessage(
                    title: titleController.value.text,
                    body: messageController.value.text,
                    data: jsonDecode(dataController.value.text));
              },
              child: Text("Send Notification"))
        ]),
      ),
    );
  }
}
