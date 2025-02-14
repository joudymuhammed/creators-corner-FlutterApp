import 'package:creators_corner/main.dart';
import 'package:flutter/material.dart';



class CheckOutScreen extends StatelessWidget {
  final TextEditingController addressTitleController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController buildingNumberController = TextEditingController();
  final TextEditingController floorNumberController = TextEditingController();
  final TextEditingController apartmentNumberController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'Images/Super_Stars-removebg.png',
                height: 135,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      color: Colors.white.withOpacity(0.9),
                      offset: Offset(3, 1),
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(
                        "Add Location",
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 143,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[400],
                        ),
                        child: Center(
                          child: Text(
                            "Pin your Location",
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: addressTitleController,
                              decoration: InputDecoration(
                                labelText: "Address Title (Home, Office, etc)",
                                labelStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: areaController,
                              decoration: InputDecoration(
                                labelText: "Area",
                                labelStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: streetNameController,
                              decoration: InputDecoration(
                                labelText: "Street name",
                                labelStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: buildingNumberController,
                              decoration: InputDecoration(
                                labelText: "Building number",
                                labelStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: floorNumberController,
                              decoration: InputDecoration(
                                labelText: "Floor number",
                                labelStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: apartmentNumberController,
                              decoration: InputDecoration(
                                labelText: "Apartment number",
                                labelStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                labelText: "Phone",
                                labelStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffFF5454),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                // Create an order object
                                // Add the order to the provider

                                // Navigate to the Orders page or any other page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CustomBottomNavBar(), // Adjust as needed
                                  ),
                                );
                              },
                              child: Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}