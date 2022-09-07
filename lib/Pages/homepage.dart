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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
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
                  '₹ 100',
                  style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold, color: color),
                ),
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            const Divider(
              indent: 8,
              endIndent: 8,
              color: Colors.grey,
              thickness: 1.2,
            ),
            SizedBox(
              // height: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Shortcuts',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70)),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: (){},
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: const Padding(
                              padding: EdgeInsets.all(12),
                              child: Icon(Icons.add,color: Colors.white70,),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Expanded(
                child: Container(
              width: width + 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey.shade900),
            )),
            const SizedBox(
              height: 17,
            )
          ],
        ),
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
              '₹ 1000',
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
              'Wallet',
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
}
