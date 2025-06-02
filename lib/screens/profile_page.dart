import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:luwas_travel_app/features/auth/email_password_login/pages/login_page.dart'; // Import your login page

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Controllers for editable text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _isEditing = false; // To toggle edit mode

  @override
  void initState() {
    super.initState();
    _loadUserProfile(); // Load initial user data
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // Placeholder for loading user data (e.g., from Firebase Auth or a database)
  void _loadUserProfile() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _nameController.text = user.displayName ?? "User Name";
      _emailController.text = user.email ?? "user@example.com";
      // For phone and address, you'd typically fetch from a database (Firestore/Realtime DB)
      // For now, use dummy data or leave empty if not available from FirebaseAuth
      _phoneController.text = "09123456789"; // Dummy phone number
      _addressController.text = "123 Main St, Anytown, PH"; // Dummy address
    } else {
      _nameController.text = "Guest User";
      _emailController.text = "guest@example.com";
      _phoneController.text = "";
      _addressController.text = "";
    }
  }

  // Placeholder for saving user data
  void _saveUserProfile() async {
    // In a real app, you would save these to Firebase Firestore or another backend
    // For example:
    // await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).update({
    //   'name': _nameController.text,
    //   'phone': _phoneController.text,
    //   'address': _addressController.text,
    // });

    // Update Firebase Auth display name if changed
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.displayName != _nameController.text) {
      await user.updateDisplayName(_nameController.text);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully!')),
    );
    setState(() {
      _isEditing = false; // Exit edit mode after saving
    });
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate back to the login page and remove all previous routes
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login', // Your login page route
        (Route<dynamic> route) => false, // Remove all routes from the stack
      );
    } catch (e) {
      print("Error signing out: $e"); // For debugging
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: ${e.toString()}')),
      );
    }
  }

  Widget _buildInfoField(String label, TextEditingController controller, {bool isEmail = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          _isEditing
              ? TextField(
                  controller: controller,
                  readOnly: isEmail, // Email usually isn't editable directly here
                  keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
                )
              : Text(
                  controller.text.isEmpty ? "N/A" : controller.text,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
                ),
          const SizedBox(height: 8),
          const Divider(height: 1),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB), // Consistent background
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0C356A),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.save : Icons.edit,
              color: const Color(0xFF0C356A),
            ),
            onPressed: () {
              if (_isEditing) {
                _saveUserProfile(); // Save changes
              }
              setState(() {
                _isEditing = !_isEditing; // Toggle edit mode
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // User Avatar
            CircleAvatar(
              radius: 60,
              backgroundImage: const AssetImage('assets/images/avatar.jpg'), // Use your avatar image
              backgroundColor: Colors.grey[200],
              child: _isEditing
                  ? Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // Handle image selection (e.g., using image_picker package)
                          print('Change profile picture');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              _nameController.text.isEmpty ? "User Name" : _nameController.text,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0C356A),
              ),
            ),
            Text(
              _emailController.text,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 32),

            // Contact Information
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Contact Information',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0C356A),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildInfoField('Full Name', _nameController),
            _buildInfoField('Email', _emailController, isEmail: true), // Email usually not editable here
            _buildInfoField('Phone Number', _phoneController),
            _buildInfoField('Address', _addressController),
            const SizedBox(height: 32),

            // Sign Out Button
            ElevatedButton(
              onPressed: _signOut,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 27, 93, 225), // Accent color for sign out
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                'Sign Out',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}