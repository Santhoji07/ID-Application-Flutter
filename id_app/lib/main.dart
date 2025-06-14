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
              TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: "Name")),
              TextField(
                  controller: collegeCtrl,
                  decoration: const InputDecoration(labelText: "College")),
              TextField(
                  controller: courseCtrl,
                  decoration: const InputDecoration(labelText: "Course")),
              TextField(
                  controller: usnCtrl,
                  decoration: const InputDecoration(labelText: "USN")),
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
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text("ID Card"),
        backgroundColor: const Color(0xFFfbb900), // Yellow top bar like ID
        actions: [
          IconButton(onPressed: editDetails, icon: const Icon(Icons.edit)),
        ],
      ),
      body: Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: const Color(0xFFfbb900),
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  children: [
                    Image.asset('assets/images/nitte_logo.png',
                        height: 60), // Replace with actual logo asset
                    const SizedBox(height: 4),
                    //const Text(
                    // 'NMAM INSTITUTE\nOF TECHNOLOGY',
                    // textAlign: TextAlign.center,
                    //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                    //),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: pickImage,
                onLongPress: removeImage,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(8), // Rounded corners (optional)
                  child: Image(
                    image: _image != null
                        ? FileImage(_image!)
                        : const AssetImage('assets/images/id_photo.jpeg')
                            as ImageProvider,
                    width: 120,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 17, 99, 165))),
              const SizedBox(height: 10),
              idDetail("College", college),
              idDetail("Course", course),
              idDetail("USN", usn),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Image.asset('assets/images/barcode.png',
                      height: 100), // placeholder barcode
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Principal",
                        style: TextStyle(fontStyle: FontStyle.italic)),
                    Text("NNM24MC134",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget idDetail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: Row(
        children: [
          Text("$title :", style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
