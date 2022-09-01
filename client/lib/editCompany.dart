part of "main.dart";

class EditCompanyView extends StatefulWidget {
  const EditCompanyView({Key? key, required this.company_id}) : super(key: key);

  final int company_id;

  @override
  State<EditCompanyView> createState() => _EditCompanyViewState();
}

class _EditCompanyViewState extends State<EditCompanyView> {
  final _formKey = GlobalKey<FormState>();

  Map company = {};

  void _cancelEdit(context) {
    Navigator.pop(context, false);
  }

  void _saveCompany(context) async {
    if (_formKey.currentState!.validate()) {
      if (widget.company_id != 0) {
        //edit existing one

        try {
          await Dio().put(API_BASE + "company/"+ widget.company_id.toString(), data: {
            "name": _nameController.text,
            "email": _emailController.text,
            "website": _websiteController.text,
            "logo": _logoController.text,
          });
        } on DioError catch (e) {
          var statusCode = e.response?.statusCode;
          if (statusCode is int && (statusCode > 299 || statusCode < 200)) {
            String statusCodeString = statusCode.toString();
            showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  return AlertDialog(
                    title: const Text("Operation failed"),
                    content: Text(
                        "Unable to edit company! (Status code:$statusCodeString)"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Ok"))
                    ],
                  );
                });
          }
        }
      } else {
        //create new one

        try {
          await Dio().post(API_BASE + "company", queryParameters: {
            "name": _nameController.text,
            "email": _emailController.text,
            "website": _websiteController.text,
            "logo": _logoController.text,
          });
        } on DioError catch (e) {
          showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  title: const Text("Operation failed"),
                  content: const Text("Unable to create new company!"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Ok"))
                  ],
                );
              });
        }
      }

      Navigator.pop(context);
    }
  }

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();
  final _logoController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  _updateCompanyData() {
    Dio().get(API_BASE + "company/" + widget.company_id.toString()).then((r) {
      setState(() {
        company = r.data;
      });
    });
  }

  void initState() {
    super.initState();
    if (widget.company_id != 0) {
      _updateCompanyData();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.company_id != 0 && company.length != 0) {
      _nameController.text = company['name'];
      _emailController.text = company['email'];
      _websiteController.text = company['website'];
      _logoController.text = company['logo'];
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit project"),
        ),
        body: Form(
            key: _formKey,
            child: ListView(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter company name';
                      }
                      return null;
                    }),
                    controller: _nameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Name"),
                  )),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Email"),
                  )),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _websiteController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Website"),
                  )),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _logoController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Logo"),
                  )),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                            child: CupertinoButton(
                                child: Row(children: const <Widget>[
                                  Icon(Icons.cancel),
                                  Text("Cancel")
                                ]),
                                onPressed: () => _cancelEdit(context))),
                        const Spacer(),
                        Expanded(
                            child: CupertinoButton(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const <Widget>[
                                      Icon(Icons.save),
                                      Text("Save")
                                    ]),
                                onPressed: () => _saveCompany(context)))
                      ])),
            ])));
  }
}
