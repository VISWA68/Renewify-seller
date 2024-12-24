import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController upiController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController shopImageController = TextEditingController();

  Future<void> registerSeller() async {
    final response = await http.post(
      Uri.parse('http://your-backend-url/register_seller'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': nameController.text,
        'phone': phoneController.text,
        'shop_name': shopNameController.text,
        'address': addressController.text,
        'upi_id': upiController.text,
        'user_id': userIdController.text,
        'shop_image': shopImageController.text, // Image URL
      }),
    );
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Seller registered successfully!'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to register seller: ${response.body}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Seller')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Seller Name'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: shopNameController,
                decoration: const InputDecoration(labelText: 'Shop Name'),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Shop Address'),
              ),
              TextField(
                controller: upiController,
                decoration: const InputDecoration(labelText: 'UPI ID'),
              ),
              TextField(
                controller: userIdController,
                decoration: const InputDecoration(labelText: 'User ID'),
              ),
              TextField(
                controller: shopImageController,
                decoration: const InputDecoration(labelText: 'Shop Image URL'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: registerSeller,
                child: const Text('Register Seller'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
