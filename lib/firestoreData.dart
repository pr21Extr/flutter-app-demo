import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FireApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Demo',
      home: FireWrite(),
    );
  }
}

class FireWrite extends StatefulWidget {
  @override
  _FireWriteState createState() => _FireWriteState();
}

class _FireWriteState extends State<FireWrite> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Save & Display'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
              ),
            ),
            TextFormField(
              controller: numberController,
              decoration: const InputDecoration(
                hintText: 'Number',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                CollectionReference collRef =
                FirebaseFirestore.instance.collection('client');
                collRef.add({
                  'name': nameController.text,
                  'number': numberController.text,
                });
              },
              child: Text('Click to save'),
            ),
            SizedBox(height: 20),
            Text('Saved Data:'),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('client').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return Text('No data available.');
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot doc = snapshot.data!.docs[index];
                      String name = doc['name'];
                      String number = doc['number'];
                      return ListTile(
                        title: Text(name),
                        subtitle: Text(number),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
