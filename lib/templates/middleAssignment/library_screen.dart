import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(157, 213, 235, 1), // Background color of the screen
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Library'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LibraryCard(
                title: 'Benefits of Contrast Showers',
                content: [
                  'A contrast shower involves alternating between hot and cold water during your shower. This practice is believed to have several benefits for physical and mental health, including:',
                  '- Improved circulation',
                  '- Enhanced recovery after exercise',
                  '- Increased alertness and energy levels',
                  '- Stress relief and relaxation',
                  '- Boosted immune system',
                ],
              ),
              SizedBox(height: 20),
              LibraryCard(
                title: 'How to Take a Contrast Shower',
                content: [
                  'Taking a contrast shower can be a simple yet effective part of your daily routine. Here are some steps to follow:',
                  '1. Start with a comfortable warm shower for 3-5 minutes.',
                  '2. Gradually decrease the water temperature to cool or cold for 1-2 minutes.',
                  '3. Repeat the cycle 2-3 times, ending with cold water.',
                  '4. Finish with warm water to relax your muscles.',
                ],
              ),
              SizedBox(height: 20),
              LibraryCard(
                title: 'Precautions for Contrast Showers',
                content: [
                  'While contrast showers can offer health benefits, they may not be suitable for everyone. Consider the following precautions:',
                  '- Consult with a healthcare provider if you have cardiovascular conditions.',
                  '- Avoid contrast showers if you have open wounds or skin conditions.',
                  '- Monitor your body\'s response to temperature changes and adjust as needed.',
                  '- Discontinue if you experience discomfort or adverse effects.',
                ],
              ),
              SizedBox(height: 20),
              LibraryCard(
                title: 'Contrast Shower Tips',
                content: [
                  'Here are some tips to enhance your contrast shower experience:',
                  '- Begin and end with warm water to avoid sudden temperature changes.',
                  '- Adjust the temperature gradually to allow your body to acclimate.',
                  '- Focus the cold water on areas needing muscle recovery or stress relief.',
                  '- Stay hydrated before and after your contrast shower.',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LibraryCard extends StatefulWidget {
  final String title;
  final List<String> content;

  const LibraryCard({required this.title, required this.content});

  @override
  _LibraryCardState createState() => _LibraryCardState();
}

class _LibraryCardState extends State<LibraryCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        
      ),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      selectionColor: Colors.white,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          if (_expanded)
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.content
                    .map((item) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            item,
                            style: TextStyle(fontSize: 16), 
                          ),
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LibraryScreen(),
  ));
}
