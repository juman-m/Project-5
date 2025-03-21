// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cv/screens/auth_screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Response?> deleteEducation(BuildContext context, Map body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final url =
      Uri.parse("https://bacend-fshi.onrender.com/user/delete/education");
  final response = await delete(url,
      body: jsonEncode(body),
      headers: {"authorization": prefs.getString("token")!});
  print(response.body);
  try {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else if (jsonDecode(response.body)["msg"] ==
        "Token is expired or invalid") {
      prefs.remove("token");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const SigninScreen(),
          ),
          (route) => false);
      return null;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonDecode(response.body)["msg"])));
    }
  } catch (error) {
    print("Error: $error");
    return null;
  }
  return null;
}
