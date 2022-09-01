part of "main.dart";

class EmployeesView extends StatefulWidget {
  const EmployeesView({Key? key, required this.authenticated})
      : super(key: key);

  final bool authenticated;

  @override
  State<EmployeesView> createState() => _EmployeesViewState();
}

class _EmployeesViewState extends State<EmployeesView> {
  List employees_all = [];
  List employees = [];
  List<bool> selected = [];

  String dropdownSelectedCompany = "";
  int selectedCompanyId = 0;
  List _companyList = [];

  void initState() {
    super.initState();

    _updateEmployeesList();

    Dio().get(API_BASE + "company/").then((r) {
      setState(() {
        _companyList = r.data;
        dropdownSelectedCompany = ALL_TEXT;
      });
    });
  }

  String _companyToDropdownString(Map company) {
    return "#" + company['id'].toString() + " " + company['name'];
  }

  List<String> _getDropDownCompanies() {
    List<String> res = _companyList
        .map((company) => _companyToDropdownString(company))
        .toList();

    if (res.length != 0) {
      res.insert(0, ALL_TEXT);
    }

    return res;
  }

  void _updateEmployeesList() async {
    var employees_from_api = await Dio().get(API_BASE + "employee");
    var companies_from_api = await Dio().get(API_BASE + "company");

    List employee_list = employees_from_api.data;
    List company_list = companies_from_api.data;

    employee_list = employee_list.map((el) {
      el['company_name'] = company_list.firstWhere((company_el) {
        return company_el['id'] == el['company_id'];
      })['name'];
      return el;
    }).toList();

    setState(() {
      employees = employee_list;
      employees_all = json.decode(json.encode(employee_list));
      if (employees.length != selected.length) {
        selected = List<bool>.generate(employees.length, (int index) => false);
      }
    });
  }

  void _delete() async {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please confirm'),
            content: const Text("Are you sure to remove selected employees?"),
            actions: [
              TextButton(
                  onPressed: () {
                    _delete_selected_employees();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No"))
            ],
          );
        });
  }

  void _delete_selected_employees() async {
    int i = 0;

    for (var item in selected) {
      if (item) {
        var employee = employees[i];
        await Dio().delete(API_BASE + "employee/" + employee["id"].toString());
      }
      i++;
    }

    selectedCompanyId = 0;
    dropdownSelectedCompany = ALL_TEXT;
    //update company list
    _updateEmployeesList();


  }

  bool _isSelectedExists() {
    for (var itemSelected in selected) {
      if (itemSelected) return true;
    }

    return false;
  }

  void _selectedItem(isSelected, index) {
    setState(() {
      selected[index] = isSelected!;

    });
  }

  void _edit(index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditEmployeeView(
                  employee_id: employees[index]['id'],
                ))).then((value) => _updateEmployeesList());
  }

  void _add() {
    //todo
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditEmployeeView(
                  employee_id: 0,
                ))).then((value) => _updateEmployeesList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employees"),
      ),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.all(30),
          child: Center(
              child: DropdownButton<String>(
            value: dropdownSelectedCompany,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.blue),
            onChanged: (String? value) {
              setState(() {
                employees = json.decode(json.encode(employees_all));
                dropdownSelectedCompany = value!;

                if (dropdownSelectedCompany == ALL_TEXT) {
                  selectedCompanyId = 0;
                } else {
                  selectedCompanyId = int.parse(dropdownSelectedCompany
                      .split(" ")[0]
                      .replaceAll("#", ""));
                }
                //update datatable
                employees.retainWhere((employee) {
                  if (selectedCompanyId == 0) return true;
                  return employee['company_id'] == selectedCompanyId;
                });
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
        ),
        Expanded(
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'First Name',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Last Name',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Company',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Email',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Phone',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Actions',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                      rows: List<DataRow>.generate(
                          employees.length,
                          (index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(Container(
                                      width: 60,
                                      child: Text(
                                          employees[index]['first_name']))),
                                  DataCell(Container(
                                      width: 60,
                                      child:
                                          Text(employees[index]['last_name']))),
                                  DataCell(Container(
                                      width: 120,
                                      child: Text(
                                          employees[index]['company_name']))),
                                  DataCell(Container(
                                      width: 120,
                                      child: Text(employees[index]['email']))),
                                  DataCell(Container(
                                      width: 100,
                                      child: Text(employees[index]['phone']
                                          .toString()))),
                                  DataCell(Container(
                                    width: 120,
                                    child: Row(children: [
                                      IconButton(
                                          tooltip: "Edit employee data",
                                          onPressed: widget.authenticated
                                              ? () => _edit(index)
                                              : null,
                                          icon: Icon(Icons.edit)),
                                    ]),
                                  ))
                                ],
                                selected: selected[index],
                                onSelectChanged: (isSelected) =>
                                    _selectedItem(isSelected, index),
                              ))))),
        )
      ]),
      floatingActionButton: widget.authenticated
          ? Wrap(
              //will break to another line on overflow
              direction: Axis.vertical, //use vertical to show  on vertical axis
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(10),
                    child: FloatingActionButton(
                      heroTag: "delete",
                      onPressed: _isSelectedExists() ? _delete : null,
                      backgroundColor: Colors.red,
                      child: Icon(Icons.delete),
                    )),

                Container(
                    margin: EdgeInsets.all(10),
                    child: FloatingActionButton(
                      heroTag: "add",
                      onPressed: () {
                        _add();
                      },
                      backgroundColor: Colors.deepPurpleAccent,
                      child: Icon(Icons.add),
                    )),
                // Add more buttons here
              ],
            )
          : null,
    );
  }
}
