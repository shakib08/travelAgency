import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui/main.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // State variables
  bool _isPasswordVisible = false;
  bool _isRetypePasswordVisible = false;
  String? _selectedDivision;
  String? _selectedDistrict;
  File? _profileImage; // To store the selected profile image
  String? _imageName; // To store the name of the selected image

  final List<String> _divisions = [
    'Dhaka',
    'Chattogram',
    'Khulna',
    'Rajshahi',
    'Barishal',
    'Sylhet',
    'Rangpur',
    'Mymensingh',
  ];

  final Map<String, List<String>> _districts = {
    'Dhaka': ['Dhaka', 'Narayanganj', 'Narsingdi', 'Gazipur', 'Manikgonj', 'Munshigonj', 'Tangail', 'Kishorgonj',
     'Netrokona', 'Faridpur', 'Gopalgonj', 'Madaripur', 'Rajbari', 'Shariatpur'],
    'Chattogram': ['Chattogram', 'Cox\'s Bazar', 'Feni', 'Rangamati', 'Bandarban', 'Khagrachhari', 'Lakshmipur', 'Comilla', 'Noakhali', 'Brahmanbaria', 'Chandpur'],
    'Khulna': ['Khulna', 'Jessore', 'Satkhira', 'Bagherhat', 'Magura', 'Jhenaidah', 'Narail', 'Kushtia', 'Chuadanga', 'Meherpur'],
    'Rajshahi': ['Rajshahi', 'Naogaon', 'Pabna', 'Bogra',  'Natore', 'Chapainawabganj', 'Sirajganj', 'Joypurhat'],
    'Barishal': ['Barishal', 'Jhalokati', 'Patuakhali', 'Barguna', 'Pirojpur', 'Bhola'],
    'Sylhet': ['Sylhet', 'Moulvibazar', 'Habiganj',  'Sunamganj'],
    'Rangpur': ['Rangpur', 'Kurigram', 'Dinajpur', 'Gaibandha', 'Nilphamari', 'Lalmonirhat', 'Thakurgaon', 'Panchagarh'],
    'Mymensingh': ['Mymensingh', 'Jamalpur', 'Netrokona', 'Sherpur'],
  };

  
  // Function to pick an image
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path); // Store the selected image
        _imageName = pickedFile.name; // Store the image name
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Decorative Shape at the Top
              Stack(
                children: [
                  Container(
                    height: screenHeight * 0.25,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.12),
                    child: Center(
                      child: Text(
                        "Create Account,\nSign Up!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.07),

              // Name Input Field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "NAME",
                    hintText: "John Doe",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Address Division Dropdown
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: DropdownButtonFormField<String>(
                  value: _selectedDivision,
                  decoration: InputDecoration(
                    labelText: "ADDRESS DIVISION",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  items: _divisions.map((String division) {
                    return DropdownMenuItem<String>(
                      value: division,
                      child: Text(division),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedDivision = newValue;
                      _selectedDistrict = null; // Reset district when division changes
                    });
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // District Dropdown
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: DropdownButtonFormField<String>(
                  value: _selectedDistrict,
                  decoration: InputDecoration(
                    labelText: "DISTRICT",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  items: _selectedDivision != null
                      ? _districts[_selectedDivision]!.map((String district) {
                          return DropdownMenuItem<String>(
                            value: district,
                            child: Text(district),
                          );
                        }).toList()
                      : [],
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedDistrict = newValue;
                    });
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Address Input Field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "ADDRESS",
                    hintText: "Your address here",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                     prefixIcon: Icon(Icons.location_city_sharp),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Contact Number Input Field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "CONTACT NUMBER",
                    hintText: "+8801XXXXXXXXX",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              //5 Profile Picture Upload Button
                Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text("Upload Profile Picture"),
                    ),
                    SizedBox(width: 10),
                    Text(
                      _imageName ?? "No image selected",
                      style: TextStyle(fontSize: screenWidth * 0.045),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: screenHeight * 0.02),
              // Password Input Field with toggle visibility
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "PASSWORD",
                    hintText: "********",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Retype Password Input Field with toggle visibility
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "RETYPE PASSWORD",
                    hintText: "********",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isRetypePasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isRetypePasswordVisible = !_isRetypePasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_isRetypePasswordVisible,
                ),
              ),
              SizedBox(height: screenHeight * 0.04),

              // Sign Up Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Container(
                  width: double.infinity,
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade700, Colors.blueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/home');// Handle signup action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),

              // Don't have an account? Sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: screenWidth * 0.04),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/login');// Navigate to login page
                    },
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
