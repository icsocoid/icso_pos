import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiskonPageMobile extends StatefulWidget {
  const DiskonPageMobile({super.key});

  @override
  State<DiskonPageMobile> createState() => _DiskonPageMobile();
}

class _DiskonPageMobile extends State<DiskonPageMobile> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 20,
        leading: IconButton(
            padding: EdgeInsets.only(left: 20),
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios, color: Colors.grey.shade600,)
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                iconSize: 30,
                onPressed: () {},
                icon: Icon(Icons.notifications_none, color: Colors.grey.shade400,)
            ),
          )
        ],
        title: Container(
          height: 45,
          child: TextField(
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              filled: true,
              fillColor: Colors.grey.shade200,
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none
              ),
              hintText: "Search e.g Software Developer",
              hintStyle: TextStyle(fontSize: 14),

            ),
          ),
        ),
      ),
      body: const Text(
        'Halaman Diskon',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

}