import 'package:flutter/material.dart';

class settingScreen extends StatefulWidget {
  const settingScreen({super.key});

  @override
  State<settingScreen> createState() => _settingScreenState();
}

class _settingScreenState extends State<settingScreen> {
  bool isSellAllowed = false; // "Allow Sell" Checkbox state
  bool isBuyAllowed = false; // "Allow Buy" Checkbox state

  final TextEditingController buyRateController =
      TextEditingController(text: "+300");
  final TextEditingController sellRateController =
      TextEditingController(text: "+200");

  @override
  void dispose() {
    buyRateController.dispose();
    sellRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ✅ "Allow Sell" Checkbox
            _buildCheckboxTile("Allow Sell", isSellAllowed, (value) {
              setState(() {
                isSellAllowed = value;
              });
            }),

            /// ✅ "Allow Buy" Checkbox
            _buildCheckboxTile("Allow Buy", isBuyAllowed, (value) {
              setState(() {
                isBuyAllowed = value;
              });
            }),

            const SizedBox(height: 20), // Space

            /// ✅ Gold Buy Rate MCX TextField
            _buildTextField("Gold Buy Rate MCX", buyRateController),

            /// ✅ Gold Sell Rate MCX TextField
            _buildTextField("Gold Sell Rate MCX", sellRateController),
          ],
        ),
      ),
    );
  }

  /// 📌 Reusable Checkbox Tile with Golden Theme
  Widget _buildCheckboxTile(
      String title, bool value, Function(bool) onChanged) {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.amber, width: 1.5), // Golden border
      ),
      elevation: 3,
      child: CheckboxListTile(
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        value: value,
        side: BorderSide(color: Colors.white),
        onChanged: (bool? newValue) {
          onChanged(newValue ?? false);
        },
        activeColor: Colors.amber,
        checkColor: Colors.white,
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }

  /// 📌 Reusable TextField Widget with Golden Theme
  Widget _buildTextField(String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.amber)),
        const SizedBox(height: 8), // Space
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.amber),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.amber),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.amber.shade700, width: 2),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        const SizedBox(height: 16), // Space
      ],
    );
  }
}
