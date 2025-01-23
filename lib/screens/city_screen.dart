import 'package:clima/utilities/navigation.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String? cityName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: AbsorbPointer(
        absorbing: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/city_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            constraints: const BoxConstraints.expand(),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigation.back(context: context);
                        },
                        style: kButtonStyle,
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 25.0,
                          color: kIconColor,
                        ),
                      ),
                    ),
                    // const SizedBox(height: 50.0),
                    Container(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: TextField(
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        decoration: kTextFieldInputDecoration,
                        onChanged: (value) {
                          cityName = value;
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigation.back(context: context, result: cityName);
                      },
                      style: kButtonStyle,
                      child: const Text(
                        'Get Weather',
                        style: kButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
