import 'package:flutter/material.dart';
import 'package:jewelbook_calculator/widget/DefaultButton.dart';

class savingSchemeJoinScreen extends StatefulWidget {
  const savingSchemeJoinScreen({Key? key}) : super(key: key);

  @override
  State<savingSchemeJoinScreen> createState() => _savingSchemeJoinScreenState();
}

class _savingSchemeJoinScreenState extends State<savingSchemeJoinScreen> {
  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saving Scheme',
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
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // Close the keyboard
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gradient Title Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepOrange.shade900,
                      Colors.deepOrange.shade900
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const Text(
                  'Ishwaryam - 1000',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Details Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _DetailRow(
                          label: 'Duration',
                          value: '11 months',
                        ),
                        SizedBox(height: 16),
                        _DetailRow(
                          label: 'Installment Payable',
                          value: 'INR 1000.00',
                        ),
                        SizedBox(height: 16),
                        _DetailRow(
                          label: 'Total Payable',
                          value: 'INR 11000.00',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Form Fields Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _InputField(
                          labelText: 'Account Name',
                          icon: Icons.person,
                        ),
                        SizedBox(height: 16),
                        _InputField(
                          labelText: 'Referral Code (Optional)',
                          icon: Icons.code,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Terms and Conditions Checkbox
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Checkbox(
                      value: _isAgreed,
                      activeColor: Colors.deepOrange.shade900,
                      onChanged: (value) {
                        setState(() {
                          _isAgreed = value!;
                        });
                      },
                    ),
                    const Flexible(
                      child: Text(
                        'I agree with the terms and conditions.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Join Scheme Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: DefaultButton(
                    text: "Join Scheme",
                    press: _isAgreed
                        ? () {
                            // Logic for Join Scheme
                          }
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Footer Section
              const Center(
                child: Text(
                  '© Jewelbook Jewellers',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _InputField extends StatelessWidget {
  final String labelText;
  final IconData icon;

  const _InputField({required this.labelText, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
