import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          // shrinkWrap: true,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            buildSBox(amount: 10000, text: 'Total Balance'),
            const SizedBox(
              height: 17,
            ),
            buildBoxGrid(),
            const SizedBox(
              height: 9,
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
              color: Colors.grey,
              thickness: 1.2,
            ),
            const SizedBox(
              height: 9,
            ),
            buildButtonGrid(),
            const SizedBox(
              height: 17,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoxGrid() {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      mainAxisSpacing: 15,
      children: [
        buildSBox(amount: 1000, text: 'Wallet'),
        buildSBox(amount: 102, text: 'Bank'),
        buildSBox(amount: 500, text: 'Home'),
        buildSBox(amount: 27, text: 'Amazon Pay'),
        buildSBox(amount: 54425, text: 'Lend'),
      ],
    );
  }

  Widget buildButtonGrid() {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      mainAxisSpacing: 8,
      crossAxisSpacing: 6,
      crossAxisCount: 5,
      childAspectRatio: 0.78,
      children: [
        buildButton(icon: Icons.money_rounded, text1: 'Adv.', text2: 'Add'),
        buildButton(icon: Icons.add, text1: 'Add', text2: 'Tranfer'),
        buildButton(
            icon: Icons.celebration_rounded, text1: 'Add', text2: 'Reward'),
        buildButton(icon: Icons.category, text1: 'Add', text2: 'Category'),
        buildButton(
            icon: Icons.shortcut_rounded, text1: 'Create', text2: 'Shortcut'),
        buildButton(icon: Icons.settings, text1: 'add', text2: 'Button 6'),
        buildButton(icon: Icons.search, text1: 'Search', text2: ''),
        buildButton(icon: Icons.fire_hydrant, text1: 'add', text2: 'Button 8'),
        buildButton(icon: Icons.mic, text1: '', text2: 'Button 9'),
        buildButton(
            icon: Icons.swipe_left_alt_sharp, text1: '', text2: 'Button 10'),
        buildButton(icon: Icons.textsms, text1: '', text2: 'Button 11'),
        buildButton(icon: Icons.kayaking, text1: '', text2: 'Button 12'),
      ],
    );
  }

  Widget buildSBox({required int amount, required String text}) {
    return Container(
      height: 70,
      width: (MediaQuery.of(context).size.width - 40),
      margin: const EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.grey.shade800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Text('₹ $amount',
                // Change text size
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                )),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Text(
              // Change text size
              text,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
            ),
          )
        ],
      ),
    );
  }

  Widget buildButton(
      {required IconData icon, required String text1, required String text2}) {
    return InkWell(
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
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(icon,color: Colors.white70,),
                )),
            const SizedBox(
              height: 4,
            ),
            Text(
              text1,
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              text2,
              style: const TextStyle(color: Colors.white70),
            )
          ],
        ),
      ),
    );
  }
}
