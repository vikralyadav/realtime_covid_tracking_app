import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  DetailScreen({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SizedBox(height: 70),
                          ReusableRow(
                            title: 'Total Cases',
                            value: widget.totalCases.toString(),
                          ),
                          ReusableRow(
                            title: 'Total Deaths',
                            value: widget.totalDeaths.toString(),
                          ),
                          ReusableRow(
                            title: 'Total Recovered',
                            value: widget.totalRecovered.toString(),
                          ),
                          ReusableRow(
                            title: 'Active Cases',
                            value: widget.active.toString(),
                          ),
                          ReusableRow(
                            title: 'Critical Cases',
                            value: widget.critical.toString(),
                          ),
                          ReusableRow(
                            title: 'Today Recovered',
                            value: widget.todayRecovered.toString(),
                          ),
                          ReusableRow(
                            title: 'Tests Conducted',
                            value: widget.test.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title;
  final String value;

  ReusableRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
