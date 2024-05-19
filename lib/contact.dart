import 'package:flutter/material.dart';

class contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i.imgur.com/Tx3KGM6.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8, // Decrease the width of the container
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: Border.all(),
              color: Colors.white.withOpacity(0.7), // Adding opacity for better readability
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Contact Us',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                Divider(),
                SizedBox(height: 20.0),
                IconWithText(icon: Icons.email, text: 'RentNest@gmail.com', color: Colors.brown),
                Divider(),
                IconWithText(icon: Icons.phone, text: '01255886258', color: Colors.brown),
                Divider(),
                IconWithText(icon: Icons.location_on, text: 'M.E.T Academy', color: Colors.brown),
                SizedBox(height: 20.0),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IconWithText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  IconWithText({required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 40.0, color: color),
        SizedBox(width: 12.0),
        Text(text),
      ],
    );
  }
}
