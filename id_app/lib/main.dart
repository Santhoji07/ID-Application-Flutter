import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: IDCardApp(),
  ));
}

class IDCardApp extends StatefulWidget {
  const IDCardApp({super.key});

  @override
  State<IDCardApp> createState() => _IDCardAppState();
}

class _IDCardAppState extends State<IDCardApp> {
  File? _image;
  final picker = ImagePicker();

  String name = 'SANTHOJI V';
  String college = 'NMAMIT';
  String course = 'MCA';
  String usn = 'NNM24MC134';

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void removeImage() {
    setState(() {
      _image = null;
    });
  }

  void editDetails() {
    TextEditingController nameCtrl = TextEditingController(text: name);
    TextEditingController collegeCtrl = TextEditingController(text: college);
    TextEditingController courseCtrl = TextEditingController(text: course);
    TextEditingController usnCtrl = TextEditingController(text: usn);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Details"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Name")),
              TextField(controller: collegeCtrl, decoration: const InputDecoration(labelText: "College")),
              TextField(controller: courseCtrl, decoration: const InputDecoration(labelText: "Course")),
              TextField(controller: usnCtrl, decoration: const InputDecoration(labelText: "USN")),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                name = nameCtrl.text;
                college = collegeCtrl.text;
                course = courseCtrl.text;
                usn = usnCtrl.text;
              });
              Navigator.of(context).pop();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("ID Card"),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(onPressed: editDetails, icon: const Icon(Icons.edit)),
        ],
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 6,
          margin: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 350,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: pickImage,
                  onLongPress: removeImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: _image != null
                        ? FileImage(_image!) as ImageProvider
                        : const AssetImage('assets/images/id_photo.jpeg'),
                  ),
                ),
                const SizedBox(height: 15),
                Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const Divider(),
                infoRow("College", college),
                infoRow("Course", course),
                infoRow("USN", usn),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text("$title:", style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Flexible(child: Text(value)),
        ],
      ),
    );
  }
}
