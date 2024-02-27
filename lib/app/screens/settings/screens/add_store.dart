import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maderkinkao/app/utils/constants.dart';

class AddStorePage extends StatelessWidget {
  const AddStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _controller = TextEditingController();

    void submitData() async {
      if (_formKey.currentState!.validate()) {
        Map<String, dynamic> payload = {};
        payload['shopName'] = _controller.text;
        payload['open'] = 0;
        print(payload);
        FirebaseFirestore database = FirebaseFirestore.instance;
        try {
          await database.collection('shops').add(payload);
        } catch (e) {
          print(e);
        }
      }
    }
  
    return Scaffold(
      appBar: AppBar(
        title: const Text("เพิ่มร้านค้า"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding*3),
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Please enter some text";
                  return null;
                },
              ),
              TextButton(onPressed: submitData, child: const Text("Add shop"))
              
            ],
          ),
        ),
      ),
    );
  }
}