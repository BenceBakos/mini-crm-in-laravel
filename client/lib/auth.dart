part of "main.dart";

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _login(context) async {
    if (_formKey.currentState!.validate()) {

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        title: Text("Admin login"),
      ),


      body: Form(
          key: _formKey,
          child: ListView(children: [
            Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: _userController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "User"),
                )),
            Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Password"),
                )),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CupertinoButton(
                          child: Row(children: const <Widget>[
                            Icon(Icons.cancel),
                            Text("Cancel")
                          ]),
                          onPressed: () => Navigator.pop(context)),
                      CupertinoButton(
                          child: Row(children: const <Widget>[
                            Icon(Icons.login),
                            Text("Login")
                          ]),
                          onPressed: () => _login(context))
                    ]))
          ])),
    );
  }
}
