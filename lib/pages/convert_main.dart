// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test/pages/side_menu.dart';

class ConvertMain extends StatefulWidget {
  @override
  _ConvertMainState createState() => _ConvertMainState();
}

class _ConvertMainState extends State<ConvertMain> {
  double convertedAmount = 0.0;
  TextEditingController amountController = TextEditingController();
  String selectedCurrency = 'EUR'; // Default selected currency

  Map<String, double> currencyRates = {
    'THB': 0.0,
    'EUR': 0.0,
    'CAD': 0.0,
    'CHF': 0.0,
    'JPY': 0.0,
    'AED': 0.0,
    'GBP': 0.0,
    'HKD': 0.0,
    'SGD': 0.0,
    'CNY': 0.0,
  };

  Future<void> _fetchExchangeRates() async {
    try {
      final apiKey = '7c71b4c22bb04eb9b03ddfe7aacabcda';
      final response = await http.get(
          Uri.parse('https://open.er-api.com/v6/latest/USD?apikey=$apiKey'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          currencyRates = Map<String, double>.from(
            data['rates'].map((key, value) => MapEntry(key, value.toDouble())),
          );
        });
      } else {
        throw Exception(
            'Failed to load exchange rates: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching exchange rates: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchExchangeRates();
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
            'Currency Converter',
            style: TextStyle(
              color: Color(0xFFFEC4DD),
              fontSize: 20,
              fontFamily: 'Poppins', // Set fontFamily to 'Poppins'
              fontWeight: FontWeight.w700,
              height: 0.06,
            ),
          ),
        ),
      ),
      drawer: NavDrawer(),
      body: Center(
        // Wrap the Column with Center widget
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .center, // Align items to the center horizontally
            children: [
              SizedBox(height: 50),
              Text(
                'USD to ${selectedCurrency}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins', // Set fontFamily to 'Poppins'
                ),
                textAlign: TextAlign.center, // Align text to the center
              ),
              SizedBox(height: 50),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Amount in USD',
                ),
              ),
              SizedBox(height: 20),
              DropdownButton<String>(
                value: selectedCurrency,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCurrency = newValue!;
                  });
                },
                items: currencyRates.keys
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontFamily: 'Poppins', // Set fontFamily to 'Poppins'
                      ),
                    ),
                  );
                }).toList(),
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                    color: Colors.black, fontSize: 18, fontFamily: 'Poppins'),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                isExpanded: true,
                borderRadius: BorderRadius.circular(
                    10), // Set border radius for rounded corners
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  _convertCurrency();
                },
                child: Text('Convert',
                    style: TextStyle(
                        fontFamily: 'Poppins')), // Set fontFamily to 'Poppins'
              ),
              SizedBox(height: 50),
              Text(
                'Conversion Rate: 1 USD = ${currencyRates[selectedCurrency]!.toStringAsFixed(2)} ${selectedCurrency}',
                style: TextStyle(
                  fontFamily: 'Poppins', // Set fontFamily to 'Poppins'
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Converted Amount: ${convertedAmount.toStringAsFixed(2)} ${selectedCurrency}',
                style: TextStyle(
                  fontFamily: 'Poppins', // Set fontFamily to 'Poppins'
                ),
              ),
              SizedBox(height: 100),
              GestureDetector(
                onTap: () {
                  // Navigate to the desired page when the icon is tapped
                  Navigator.pushNamed(context, '/currency_center');
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Currency Center',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Icon(Icons.arrow_circle_right, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _convertCurrency() {
    double amount = double.tryParse(amountController.text) ?? 0.0;
    double selectedRate = currencyRates[selectedCurrency] ?? 0.0;
    setState(() {
      convertedAmount = amount * selectedRate;
    });
  }
}
