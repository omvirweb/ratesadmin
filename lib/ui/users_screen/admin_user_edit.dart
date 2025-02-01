import 'package:flutter/material.dart';
import 'package:jewelbook_calculator/ui/users_screen/admin_user_list.dart';

class AdminUserEdit extends StatefulWidget {
  const AdminUserEdit({super.key});

  @override
  State<AdminUserEdit> createState() => _AdminUserEditState();
}

class _AdminUserEditState extends State<AdminUserEdit> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Admin User Edit",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus(); // Close the keyboard
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Section Title
                const Text(
                  "Edit User Information",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // First Name Field
                _buildTextField("First Name", Icons.person),
                const SizedBox(height: 10),
                // Last Name Field
                _buildTextField("Last Name", Icons.person),
                const SizedBox(height: 10),
                // Email Field
                _buildTextField("Email", Icons.email),
                const SizedBox(height: 10),
                // Mobile Number Field
                _buildTextField("Mobile No.", Icons.phone,
                    keyboardType: TextInputType.phone, maxLength: 10),
                const SizedBox(height: 10),
                // Password Field
                _buildPasswordField(
                    "Password",
                    _isPasswordVisible,
                    () => setState(
                        () => _isPasswordVisible = !_isPasswordVisible)),
                const SizedBox(height: 10),
                // Confirm Password Field
                _buildPasswordField(
                    "Confirm Password",
                    _isConfirmPasswordVisible,
                    () => setState(() => _isConfirmPasswordVisible =
                        !_isConfirmPasswordVisible)),
                const SizedBox(height: 20),
                // Terms and Conditions
                Row(
                  children: [
                    Checkbox(
                      value: _isTermsAccepted,
                      activeColor: Colors.deepOrange.shade900,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      onChanged: (value) {
                        setState(() {
                          _isTermsAccepted = value!;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        "I accept the Terms and Conditions.",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminUserList(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Colors.deepOrange.shade900,
                      shadowColor: Colors.deepOrange.withOpacity(0.4),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon,
      {TextInputType keyboardType = TextInputType.text, int? maxLength}) {
    return TextFormField(
      keyboardType: keyboardType,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        counterText: "",
      ),
    );
  }

  Widget _buildPasswordField(
      String label, bool isVisible, VoidCallback toggleVisibility) {
    return TextFormField(
      obscureText: !isVisible,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: toggleVisibility,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
