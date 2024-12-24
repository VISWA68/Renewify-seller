import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:seller_app/pages/shop/addproduct.dart';
import 'package:seller_app/pages/shop/shop.dart';
import 'package:seller_app/provider/sellerProvider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? sellerData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchSellerData();
    });
  }

  Future<void> fetchSellerData() async {
    // Accessing sellerId from Provider after the widget is built
    final sellerId =
        Provider.of<SellerProvider>(context, listen: false).sellerId;

    final response = await http.get(
      Uri.parse('http://192.168.234.231:8000/seller/$sellerId'),
    );

    if (response.statusCode == 200) {
      setState(() {
        sellerData = jsonDecode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch seller data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Renewify Seller Dashboard')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : sellerData == null
              ? const Center(child: Text('No seller data found'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome, ${sellerData!['name']}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Phone number:  ${sellerData!['phone']}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddShopPage(),
                              ));
                        },
                        child: const Text('Manage shop'),
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.push(context, MaterialPageRoute(builder: (context) => ,))
                      //   },
                      //   child: const Text('Manage products'),
                      // ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddProductPage()
                                ,
                              ));
                        },
                        child: const Text('Add products'),
                      ),
                    ],
                  ),
                ),
    );
  }
}
