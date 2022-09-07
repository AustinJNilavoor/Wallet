import 'package:flutter/material.dart';
import 'package:wallet/Pages/inputpage.dart';

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
    const color = Colors.red;
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InputPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildSBox(),
                const SizedBox(
                  width: 7,
                ),
                buildSBox()
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey.shade900),
              child: const Center(
                child: Text(
                  '₹ 100',
                  style: TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold, color: color),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey.shade900),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 5.0, bottom: 4),
                      child: Text('Today',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text('₹ 1,000',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                        Text('₹ 1,000',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                      ],
                    )
                  ],
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Shortcuts',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade900,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: const Padding(
                                padding: EdgeInsets.all(12),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white70,
                                ),
                              ),
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
              height: 17,
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey.shade900),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Recent History',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                    const SizedBox(
                      height: 5,
                    ),
                    buildRHisory(),
                    buildRHisory(),
                    buildRHisory()
                  ],
                ),
              ),
            )),
            const SizedBox(
              height: 17,
            )
          ],
        ),
      ),
    );
  }

  Widget buildSBox() {
    return Container(
      height: 80,
      width: (MediaQuery.of(context).size.width - 30) / 2,
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
              '₹ 1,000',
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

  Widget buildRHisory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Wallet',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'today , bus',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                '1000',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '10,000,000',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          )
        ],
      ),
    );
  }
}
