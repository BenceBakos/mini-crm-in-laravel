part of "main.dart";

class EditEmployeeView extends StatefulWidget {
  const EditEmployeeView({Key? key, required this.employee_id})
      : super(key: key);

  final int employee_id;

  @override
  State<EditEmployeeView> createState() => _EditEmployeeViewState();
}

class _EditEmployeeViewState extends State<EditEmployeeView> {
  final _formKey = GlobalKey<FormState>();

  Map employee = {};
  List _companyList = [];
  String dropdownSelectedCompany = "";
  int selectedCompanyId = 1;

  void _cancelEdit(context) {
    Navigator.pop(context, false);
  }

  void _saveEmployee(context) async {
    if (_formKey.currentState!.validate()) {
      if (widget.employee_id != 0) {
        //edit existing one

        await Api.updateEmployee(widget.employee_id, {
          "first_name": _firstNameController.text,
          "last_name": _lastNameController.text,
          "company_id": selectedCompanyId.toString(),
          "email": _emailController.text,
          "phone": _phoneController.text,
        }).catchError((e) {
          var statusCode = e.response?.statusCode;
          if (statusCode is int && (statusCode > 299 || statusCode < 200)) {
            String statusCodeString = statusCode.toString();
            showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  return AlertDialog(
                    title: const Text("Operation failed"),
                    content: Text(
                        "Unable to edit employee! (Status code:$statusCodeString)"),
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
        });
      } else {
        //create new one

        await Api.createEmployee({
          "first_name": _firstNameController.text,
          "last_name": _lastNameController.text,
          "company_id": selectedCompanyId.toString(),
          "email": _emailController.text,
          "phone": _phoneController.text,
        }).catchError((e) {
          showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  title: const Text("Operation failed"),
                  content: const Text("Unable to create new employee!"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Ok"))
                  ],
                );
              });
        });
      }

      Navigator.pop(context);
    }
  }

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  _updateEmployeeData() {
    Api.getEmployee(widget.employee_id).then((r) {

      setState(() {
        employee = r.data;
        selectedCompanyId = employee['company_id'];
      });
    });
  }

  _updateCompanyList() {
    Api.getCompanies().then((r) {

      setState(() {
        _companyList = r.data;
        dropdownSelectedCompany = _getCurrentDropdownCompany();

        if (employee.isEmpty) {
          selectedCompanyId = _companyList[0]['id'];
        }
      });
    });
  }

  void initState() {
    super.initState();
    if (widget.employee_id != 0) {
      _updateEmployeeData();
    }
    _updateCompanyList();
  }

  String _companyToDropdownString(Map company) {
    return "#" + company['id'].toString() + " " + company['name'];
  }

  String _getCurrentDropdownCompany() {
    if (employee.length == 0) {
      return _companyToDropdownString(_companyList[0]);
    } else {
      return _companyToDropdownString(_companyList
          .firstWhere((company) => company['id'] == employee['company_id']));
    }
  }

  List<String> _getDropDownCompanies() {
    return _companyList
        .map((company) => _companyToDropdownString(company))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.employee_id != 0 && employee.isNotEmpty) {
      _firstNameController.text = employee['first_name'];
      _lastNameController.text = employee['last_name'];
      _emailController.text = employee['email'];
      _phoneController.text = employee['phone'];
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Edit employee'),
        ),
        body: Form(
            key: _formKey,
            child: ListView(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    }),
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "First Name"),
                  )),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    }),
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Last Name"),
                  )),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: DropdownButtonFormField<String>(
                    value: dropdownSelectedCompany,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.blue),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownSelectedCompany = value!;

                        selectedCompanyId = int.parse(dropdownSelectedCompany
                            .split(" ")[0]
                            .replaceAll("#", ""));
                      });
                    },
                    items: _getDropDownCompanies()
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Website"),
                  )),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _phoneController,
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
                                onPressed: () => _saveEmployee(context)))
                      ])),
            ])));
  }
}
