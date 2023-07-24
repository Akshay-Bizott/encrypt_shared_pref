library encrypt_shared_pref;

import 'package:encrypt_shared_pref/pref_service.dart';
import 'package:flutter/material.dart';


class SaveDataView extends StatefulWidget {
  @override
  _SaveDataViewState createState() => _SaveDataViewState();
}

class _SaveDataViewState extends State<SaveDataView> {
  final SecureStorage secureStorage = SecureStorage();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                /// Save data securely
                await secureStorage.writeString(key: 'name', value: _nameController.text);
                await secureStorage.writeString(key: 'phoneNumber', value: _phoneNumberController.text);
                await secureStorage.writeString(key: 'address', value: _addressController.text);
                await secureStorage.writeString(key: 'email', value: _emailController.text);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data saved successfully!')));
              },
              child: Text('Save'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                /// Read data securely
                String? name = await secureStorage.readString(key: 'name');
                String? phoneNumber = await secureStorage.readString(key: 'phoneNumber');
                String? address = await secureStorage.readString(key: 'address');
                String? email = await secureStorage.readString(key: 'email');

                /// Display the data in an alert dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Saved Data'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Name: ${name ?? ''}'),
                        Text('Phone Number: ${phoneNumber ?? ''}'),
                        Text('Address: ${address ?? ''}'),
                        Text('Email: ${email ?? ''}'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Read'),
            ),
          ],
        ),
      ),
    );
  }
}
