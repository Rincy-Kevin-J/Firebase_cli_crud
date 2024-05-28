import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_firebase_flutter_project/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
      MaterialApp(
    home: FireBaseCrud(),
  ));
}

class FireBaseCrud extends StatefulWidget {
  const FireBaseCrud({super.key});

  @override
  State<FireBaseCrud> createState() => _FireBaseCrudState();
}

class _FireBaseCrudState extends State<FireBaseCrud> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  late CollectionReference _userCollections;

  @override
  void initState() {
    _userCollections = FirebaseFirestore.instance.collection('Users');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Add Users Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder()
              ),
            ),
            MaterialButton(onPressed: () {
              addUser();
            }, color: Colors.brown,
              minWidth: 100,
              child: Text("Add Users"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addUser() {
    return _userCollections.add(
        {"name": nameController.text, "email": emailController.text}).then((value){
      print('Users Added Successfully');
      nameController.clear();
      emailController.clear();
    }).catchError((error){
    print ("failed to add Users:$error");
    }
    );
  }
}
