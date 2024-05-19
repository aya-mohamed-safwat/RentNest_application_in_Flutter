import 'package:flutter/material.dart';

class about extends StatefulWidget {
  const about({Key? key});

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> with SingleTickerProviderStateMixin {
  late String displayText; // Variable to hold the displayed text
  late String imageUrl; // Variable to hold the image URL
  bool isTextVisible = false; // Variable to track if text is visible
  Color button1Color = Colors.grey.shade200; // Default color for button 1
  Color button2Color = Colors.grey.shade200; // Default color for button 2
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Set the default image URL
    imageUrl = 'https://i.imgur.com/eGE1PDD.png';
    displayText = '';
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: size.height * 0.2,
                    fit: BoxFit.cover,
                  ),
                  Opacity(
                    opacity: 0.4,
                    child: Container(
                      width: double.infinity,
                      height: size.height * 0.2,
                      color: Colors.brown,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        displayText = 'In our app you can find the perfect place to stay in for a vacation, studying or living anywhere you want with \n- the pefect price \n- you won\'t need realtors anymore \n- No time wasted';
                        imageUrl = 'https://imageio.forbes.com/specials-images/imageserve/657b29edf09ae8354c4debba/Real-estate-agents-shake-hands-after-the-signing-of-the-contract-agreement-is/960x0.jpg?height=474&width=711&fit=bounds';
                        isTextVisible = true;
                        button1Color = Colors.brown;
                        button2Color = Colors.grey.shade200;
                        _controller.reset();
                        _controller.forward();
                      });
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0), // No elevation
                      backgroundColor: MaterialStateProperty.all<Color>(button1Color),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // More rectangular
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(size.width * 0.45, 50), // Wider button
                      ),
                    ),
                    child: Text(
                      'About RentNest',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        displayText = 'We care about implementing the axes of Egypt\'s Vision 2030, so the optimal solution has been provided to assist in housing in the new cities and the administrative capital, by displaying the available housing units and saving the time and effort of the tenant\'s search';
                        imageUrl = 'https://earthsguards.com/wp-content/uploads/2023/03/001.jpg';
                        isTextVisible = true;
                        button2Color = Colors.brown;
                        button1Color = Colors.grey.shade200;
                        _controller.reset();
                        _controller.forward();
                      });
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0), // No elevation
                      backgroundColor: MaterialStateProperty.all<Color>(button2Color),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // More rectangular
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(size.width * 0.45, 50), // Wider button
                      ),
                    ),
                    child: Text(
                      'Egypt Vision 2030',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget? child) {
                  return Transform.translate(
                    offset: Offset(
                      0.0,
                      (1 - _animation.value) * size.height * 0.4,
                    ),
                    child: Opacity(
                      opacity: _animation.value,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          displayText,
                          style: TextStyle(
                            fontSize: 20, // Larger font size
                            color: Colors.brown, // Brown color
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

    );
  }
}
