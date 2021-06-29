import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  const Grid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        // Generate 100 widgets that display their index in the List.

        itemCount: 20,
        itemBuilder: (context, index) {
          // return Center(
          //   child: Container(
          //     width: 50,
          //     height: 50,
          //     color: Colors.blue,
          //     child: Text('$index'),
          //   ),
          // );
          return CustomContainer(
            color: Colors.blue,
            value: index,
          );
        },
      ),
    );
  }
}

class CustomContainer extends StatefulWidget {
  CustomContainer({Key? key, required this.color, required this.value})
      : super(key: key);
  int value;
  Color color;

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  initState() {
    super.initState();
    changeColor(widget.value);
  }

  changeColor(int value) {
    if (value >= 0 && value <= 5) {
      setState(() {
        widget.color = Colors.amber[200]!;
      });
    } else if (value > 5 && value <= 10) {
      setState(() {
        widget.color = Colors.amber;
      });
    } else if (value > 10 && value <= 20) {
      setState(() {
        widget.color = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: widget.color,
        height: 50,
        width: 50,
      ),
    );
  }
}
