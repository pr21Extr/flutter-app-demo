import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireWrite extends StatelessWidget{
  FireWrite({super.key});

  final nameController = TextEditingController();
  final numberController = TextEditingController();
  @override

  Widget build(BuildContext context){
    return

      Scaffold(
        appBar:AppBar(
          title: Text('FireStore save'),
        ),
        body: Container(
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
          ElevatedButton(onPressed: (){
            CollectionReference collref = FirebaseFirestore.instance.collection('client');
            collref.add({
              'name':nameController.text,
              'number':numberController.text,
            });
          }, child: Text('Click to save'))

        ],
    ),
        ),
      );
  }
}