import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/pages/side_menu.dart';

class CurrencyCenter extends StatefulWidget {
  final String userID; // User ID parameter

  const CurrencyCenter({Key? key, required this.userID}) : super(key: key);

  @override
  _CurrencyCenterState createState() => _CurrencyCenterState();
}

class _CurrencyCenterState extends State<CurrencyCenter> {
  double usdToThb = 0.0;
  double usdToEur = 0.0;
  double usdToCad = 0.0;
  double usdToJpy = 0.0;
  double usdToChf = 0.0;
  double usdToAed = 0.0;
  double usdToGbp = 0.0;
  double usdToHkd = 0.0;
  double usdToSgd = 0.0;
  double usdToCny = 0.0;
  double usdToMmk = 0.0;
  double usdToKrw = 0.0;

  // Variables to store the favorite currencies
  List<String> favoriteCurrencies = [];
  List<String> selectedFavoriteCurrencies = [];

  Future<void> _fetchExchangeRate() async {
    try {
      final apiKey = '7c71b4c22bb04eb9b03ddfe7aacabcda';
      final response = await http.get(
          Uri.parse('https://open.er-api.com/v6/latest/USD?apikey=$apiKey'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          usdToThb = data['rates']['THB'];
          usdToEur = data['rates']['EUR'];
          usdToCad = data['rates']['CAD'];
          usdToChf = data['rates']['CHF'];
          usdToJpy = data['rates']['JPY'];
          usdToAed = data['rates']['AED'];
          usdToGbp = data['rates']['GBP'];
          usdToHkd = data['rates']['HKD'];
          usdToSgd = data['rates']['SGD'];
          usdToCny = data['rates']['CNY'];
          usdToMmk = data['rates']['MMK'];
          usdToKrw = data['rates']['KRW'];
        });
      } else {
        throw Exception(
            'Failed to load exchange rates: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching exchange rates: $error');
      // Handle error, show a message to the user, or retry
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchExchangeRate();
    _printUserID(); // Call the function to print the userID
  }

  Future<void> _printUserID() async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users') // Assuming 'users' is the collection
          .doc(
              'userID') // Replace 'specific_document_id' with the actual document ID
          .get();

      // Check if the document exists and data is not null
      if (snapshot.exists && snapshot.data() != null) {
        // Cast the data to Map<String, dynamic>
        final data = snapshot.data()! as Map<String, dynamic>;
        // Get the user ID field from the document data
        final userID =
            data['userID']; // Replace 'userID' with the actual field name
        print('User ID: $userID');
      } else {
        print('Document does not exist or data is null.');
      }
    } catch (error) {
      print('Error printing userID: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0000EB),
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 1.0, top: 10.0, bottom: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(left: 1.0),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Icon(Icons.menu, color: Colors.black),
                  ),
                ),
              ),
            );
          },
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Currency Center',
            style: TextStyle(
              color: Color(0xFFFEC4DD),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              height: 0.06,
            ),
          ),
        ),
      ),
      drawer: NavDrawer(),
      backgroundColor: Color(0xFF0000EB),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 30), // Adjust left padding
                Text(
                  'Favorite currency',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    height: 0.08,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: 350,
              height: 45,
              decoration: ShapeDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Text(
                      selectedFavoriteCurrencies.join(', '),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0.08,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 350,
              height: 550,
              decoration: ShapeDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildCurrencyRow(
                      'THB',
                      usdToThb,
                      '🇹🇭',
                    ),
                    _buildCurrencyRow('EUR', usdToEur, '🇪🇺'),
                    _buildCurrencyRow('CAD', usdToCad, '🇨🇦'),
                    _buildCurrencyRow('CHF', usdToChf, '🇨🇭'),
                    _buildCurrencyRow('JPY', usdToJpy, '🇯🇵'),
                    _buildCurrencyRow('AED', usdToAed, '🇦🇪'),
                    _buildCurrencyRow('GBP', usdToGbp, '🇬🇧'),
                    _buildCurrencyRow('HKD', usdToHkd, '🇭🇰'),
                    _buildCurrencyRow('SGD', usdToSgd, '🇸🇬'),
                    _buildCurrencyRow('CNY', usdToCny, '🇨🇳'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyRow(
      String currencyCode, double exchangeRate, String flagEmoji) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$flagEmoji  $currencyCode',
            style: TextStyle(fontSize: 15),
          ),
          Text(
            '${exchangeRate.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 15),
          ),
          _buildFavoriteButton(currencyCode)
        ],
      ),
    );
  }

  Widget _buildFavoriteButton(String currencyCode) {
    return IconButton(
      icon: Icon(
        favoriteCurrencies.contains(currencyCode)
            ? Icons.favorite
            : Icons.favorite_border,
        color: favoriteCurrencies.contains(currencyCode)
            ? Colors.red
            : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          if (favoriteCurrencies.contains(currencyCode)) {
            favoriteCurrencies.remove(currencyCode);
            selectedFavoriteCurrencies.remove(currencyCode);
            print('$currencyCode is deselected as favorite.');
          } else {
            favoriteCurrencies.add(currencyCode);
            selectedFavoriteCurrencies.add(currencyCode);
            print('$currencyCode is selected as favorite.');
          }
        });
      },
    );
  }
}
