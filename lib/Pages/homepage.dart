import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() {
    final width = (MediaQuery.of(context).size.width - 40);
    const color = Colors.red;
    // Singlechildscrollview
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSBox(width: width / 2),
              buildSBox(width: width / 2)
            ],
          ),
          const SizedBox(
            height: 17,
          ),
          Container(
            height: 70,
            width: width + 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey.shade900),
            child: const Center(
              child: Text(
                '₹ newTab',
                style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.bold, color: color),
              ),
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          Expanded(
              child: Container(
            width: width + 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey.shade900),
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     const Padding(
            //       padding: EdgeInsets.only(left: 10, top: 10),
            //       child: Text(
            //         'Shortcuts',
            //         style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 10),
            //       child: Container(
            //         child: SingleChildScrollView(
            //           scrollDirection: Axis.horizontal,
            //           child: Row(
            //             children: [
            //               buildButton(text: 'Collage'),
            //               buildButton(text: 'Collage'),
            //               buildButton(text: 'Collage'),
            //               buildButton(text: 'Collage'),
            //               buildButton(text: 'Collage'),
            //               buildButton(text: 'Collage'),
            //               buildButton(text: 'Collage'),
            //               buildButton(text: 'Collage'),
            //               buildButton(text: 'Collage'),
            //               buildButton(text: 'Collage'),
            //               buildButton(text: 'Collage'),
            //             ],
            //           ),
            //         ),
            //       ),
            //     )
            //   ],
            // ),
          )),
          const SizedBox(
            height: 17,
          )
        ],
      ),
    );
  }

  Widget buildSBox({required double width}) {
    return Container(
      height: 80,
      width: width,
      margin: const EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.grey.shade900),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Text(
              '₹ amount',
              // Change text size
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Text(
              // Change text size
              "type",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
            ),
          )
        ],
      ),
    );
  }

  Widget buildButton({required String text}) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(top: 3.0, bottom: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.cabin),
                  )),
              const SizedBox(
                height: 4,
              ),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
