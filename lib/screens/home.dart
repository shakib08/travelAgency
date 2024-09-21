import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import go_router package

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      endDrawer: Drawer( // Right side drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue, // Match container's color
                    Color(0xFF753a88),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              accountName: const Text("Shakib's Travel"), // Name below avatar
              accountEmail: null,
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Placeholder image for avatar
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => context.go('/home'), // Navigate to home
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () => {} // Navigate to profile
            ),
            ListTile(
              leading: const Icon(Icons.tour),
              title: const Text('Your Tours'),
              onTap: () => {} // Navigate to tours
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Tips & Guidelines'),
              onTap: (){} // Navigate to tips
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {} // Handle logout
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: size.width * 1,
                  height: size.height * 0.3,
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue,
                        Color(0xFF753a88),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            if (GoRouter.of(context).canPop()) {
                              context.pop();
                            } else {
                              context.go('/');
                            }
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Builder(
                          builder: (context) => IconButton(
                            icon: const Icon(Icons.menu, color: Colors.white), // Navbar icon
                            onPressed: () {
                              Scaffold.of(context).openEndDrawer(); // Open drawer on icon click
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.1,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome to",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.09,
                              ),
                            ),
                            const Text(
                              "Shakib's Travel",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
