import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';

part 'auth.dart';
part 'companies.dart';
part 'editCompany.dart';
part 'employees.dart';
part 'editEmployee.dart';


const String API_BASE = "http://localhost:8000/api/";
const String COMPANY_LOGO_BASE = "http://localhost:8001/company_logos/";
const String ALL_TEXT = "-- ALL --";

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          const MyHomePage(title: 'Mini CRM with laravel n dirty lil flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _authenticated = false;

  void _login() {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AuthenticationView()))
        .then((value) {
      setState(() {
        _authenticated = value;
      });
    });
  }

  void _logout() {
    setState(() {
      _authenticated = false;
    });
  }

  void _company(context, authenticated) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CompaniesView(authenticated: authenticated)));
  }

    void _employee(context, authenticated) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EmployeesView(authenticated: authenticated)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(5),
              child: CupertinoButton(
                onPressed: _authenticated ? _logout : _login,
                child: Row(children: <Widget>[
                  const Icon(Icons.login),
                  _authenticated
                      ? const Text("Log out")
                      : const Text("Admin login")
                ]),
              )),
          Padding(
              padding: const EdgeInsets.all(5),
              child: CupertinoButton(
                onPressed: () => _company(context, _authenticated),
                child: Row(children: const <Widget>[
                  Icon(Icons.book),
                  Text("Companies")
                ]),
              )),
          Padding(
              padding: const EdgeInsets.all(5),
              child: CupertinoButton(
                onPressed: () => _employee(context, _authenticated),
                child: Row(children: const <Widget>[
                  Icon(Icons.person),
                  Text("Employees")
                ]),
              )),
        ],
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(20),
                child: CupertinoButton(
                  onPressed: _authenticated ? _logout : _login,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.login),
                        _authenticated
                            ? const Text("Log out")
                            : const Text("Admin login")
                      ]),
                )),
            Padding(
                padding: const EdgeInsets.all(20),
                child: CupertinoButton(
                  onPressed: () => _company(context, _authenticated),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.book),
                        Text("Companies")
                      ]),
                )),
            Padding(
                padding: const EdgeInsets.all(20),
                child: CupertinoButton(
                  onPressed: () => _employee(context, _authenticated),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.person),
                        Text("Employees")
                      ]),
                )),
          ],
        ),
      ),
    );
  }
}
