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
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Edit User Information",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField("First Name", Icons.person),
              const SizedBox(height: 10),
              _buildTextField("Last Name", Icons.person),
              const SizedBox(height: 10),
              _buildTextField("Email", Icons.email),
              const SizedBox(height: 10),
              _buildTextField("Mobile No.", Icons.phone,
                  keyboardType: TextInputType.phone, maxLength: 10),
              const SizedBox(height: 10),
              _buildPasswordField(
                  "Password",
                  _isPasswordVisible,
                  () =>
                      setState(() => _isPasswordVisible = !_isPasswordVisible)),
              const SizedBox(height: 10),
              _buildPasswordField(
                  "Confirm Password",
                  _isConfirmPasswordVisible,
                  () => setState(() =>
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible)),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _isTermsAccepted,
                    activeColor: Colors.amber,
                    side: BorderSide(color: Colors.white),
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
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                    backgroundColor: Colors.amber,
                    shadowColor: Colors.amber.withOpacity(0.4),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
            ],
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
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.amber),
        prefixIcon: Icon(icon, color: Colors.amber),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber, width: 2),
            borderRadius: BorderRadius.circular(10)),
        counterText: "",
      ),
    );
  }

  Widget _buildPasswordField(
      String label, bool isVisible, VoidCallback toggleVisibility) {
    return TextFormField(
      obscureText: !isVisible,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.amber),
        prefixIcon: const Icon(Icons.lock, color: Colors.amber),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.amber,
          ),
          onPressed: toggleVisibility,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber, width: 2),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
