import 'package:covid_tracker/View/detail_screen.dart';
import 'package:covid_tracker/model/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search With Country Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: statesServices.countriesListApi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildShimmerEffect();
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return Center(child: const Text('No data available'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (searchController.text.isEmpty ||
                            name.toLowerCase().contains(searchController.text.toLowerCase())) {
                          return _buildCountryTile(snapshot.data![index]);
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade700,
          highlightColor: Colors.grey.shade100,
          child: Column(
            children: [
              ListTile(
                title: Container(
                  height: 10,
                  width: 89,
                  color: Colors.white,
                ),
                subtitle: Container(
                  height: 10,
                  width: 89,
                  color: Colors.white,
                ),
                leading: Container(
                  height: 50,
                  width: 50,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCountryTile(Map<String, dynamic> countryData) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  name: countryData['country'],
                  image: countryData['countryInfo']['flag'],
                  totalCases: countryData['cases'],
                  todayRecovered: countryData['todayRecovered'],
                  totalDeaths: countryData['deaths'],
                  active: countryData['active'],
                  test: countryData['tests'],
                  critical: countryData['critical'],
                  totalRecovered: countryData['recovered'],
                ),
              ),
            );
          },
          child: ListTile(
            title: Text(countryData['country']),
            subtitle: Text(countryData['cases'].toString()),
            leading: Image(
              height: 50,
              width: 50,
              image: NetworkImage(countryData['countryInfo']['flag']),
            ),
          ),
        ),
      ],
    );
  }
}
