import 'package:flutter/material.dart';

// void main() {
//   runApp(ProfileCard(
//     imageUrl:
//         'https://images2.pics4learning.com/catalog/b/thumb_big/blackbear_thumb_big.jpg',
//     name: 'smth',
//     description: 'smth_desc',
//   ));
// }

// class MyAPP extends StatelessWidget {
//   const MyAPP({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('text')),
//         body: ProfileCard(
//           imageUrl:
//               'https://images2.pics4learning.com/catalog/b/thumb_big/blackbear_thumb_big.jpg',
//           name: 'smth',
//           description: 'smth_desc',
//         ),
//       ),
//     );
//   }
// }

class ProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;

  ProfileCard({
    required this.imageUrl,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                radius: 30,
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(description),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
