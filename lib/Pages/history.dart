import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        buildBoxHis(),
        buildBoxHis(),
        buildBoxHis(),
        buildBoxHis(),
        buildBoxHis(),
        buildBoxHis(),
        buildBoxHis(),
        buildBoxHis(),
        buildBoxHis(),
        buildBoxHis(),
      ],
    );
  }

  Widget buildBoxHis() {
    // Long press to delete
    // tap to edit
    return Column(
      children: [
        Container(
          width: (MediaQuery.of(context).size.width - 20),
          decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Wallet',
                      style: TextStyle(
                          fontSize: 18,
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
                          fontSize: 16,
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
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
