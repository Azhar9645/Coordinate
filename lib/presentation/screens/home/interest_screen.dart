import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coordinate_app/presentation/screens/auth%20screen/signIn.dart';
import 'package:coordinate_app/presentation/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({Key? key}) : super(key: key);

  @override
  _InterestScreenState createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> allInterests = [
    "Traveling",
    "Cooking",
    "Photography",
    "Sports",
    "Music",
    "Art",
    "Technology",
    "Reading",
    "Fitness",
    "Gaming",
    "Fashion",
    "Movies",
    "Nature",
    "Writing",
  ];

  final List<String> selectedInterests = [];

  @override
  void initState() {
    super.initState();
    _checkUserAuthentication();
  }

  // Check if user is authenticated before allowing to proceed
  void _checkUserAuthentication() {
    User? user = _auth.currentUser;

    if (user == null) {
      // If user is not authenticated, navigate to login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()), // Replace with your login screen
      );
    }
  }

  // Save the selected interests to Firestore and navigate to HomeScreen
  Future<void> _saveInterestsAndNavigate() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // User is authenticated
      final String uid = user.uid;

      try {
        // Save selected interests to Firestore
        await _firestore.collection('users').doc(uid).set({
          'interests': selectedInterests,
        }, SetOptions(merge: true));

        // Navigate to HomeScreen on success
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } catch (e) {
        _showSnackBar('Error saving interests: $e');
      }
    } else {
      // User is not authenticated
      _showSnackBar('Error: User is not authenticated');
    }
  }

  // Toggle the selection of an interest
  void _toggleInterest(String interest) {
    setState(() {
      selectedInterests.contains(interest)
          ? selectedInterests.remove(interest)
          : selectedInterests.add(interest);
    });
  }

  // Show a snackbar with a message
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Your Interests",
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemCount: allInterests.length,
                itemBuilder: (context, index) {
                  final String interest = allInterests[index];
                  final bool isSelected = selectedInterests.contains(interest);

                  return GestureDetector(
                    onTap: () => _toggleInterest(interest),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          interest,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: selectedInterests.isNotEmpty
            ? _saveInterestsAndNavigate
            : null, // Disable button if no interests are selected
        backgroundColor:
            selectedInterests.isNotEmpty ? Colors.green : Colors.grey,
        label: const Text("Next"),
        icon: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
