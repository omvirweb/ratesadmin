import 'package:flutter/material.dart';
import 'package:jewelbook_calculator/ui/saving_scheme/saving_schemeJoinScrenn.dart';

class savingSchemeScreen extends StatelessWidget {
  final List<SavingScheme> schemes = [
    SavingScheme(
        name: "Ishwaryam - 1000", payable: 1000, duration: "11 months"),
    SavingScheme(
        name: "Ishwaryam - 2000", payable: 2000, duration: "11 months"),
    SavingScheme(
        name: "Ishwaryam - 5000", payable: 5000, duration: "11 months"),
    SavingScheme(
        name: "Ishwaryam - 10000", payable: 10000, duration: "11 months"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Saving Schemes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // Close the keyboard
          },
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "ISHWARYAM",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  suffixIcon: const Icon(Icons.add),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: schemes.length,
                  itemBuilder: (context, index) {
                    return SchemeCard(scheme: schemes[index]);
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "© Jewelbook Jewellers",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SavingScheme {
  final String name;
  final double payable;
  final String duration;

  SavingScheme(
      {required this.name, required this.payable, required this.duration});
}

class SchemeCard extends StatelessWidget {
  final SavingScheme scheme;

  const SchemeCard({Key? key, required this.scheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.deepOrangeAccent.shade700,
              radius: 25,
              child: Icon(Icons.money, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scheme.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Payable: INR ${scheme.payable.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    "Duration: ${scheme.duration}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.deepOrange.shade900),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => savingSchemeJoinScreen(),
                    ));
              },
              child: const Text(
                "Join",
                style: TextStyle(color: Colors.brown),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
