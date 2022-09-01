part of "main.dart";

class CompaniesView extends StatefulWidget {
  const CompaniesView({Key? key, required this.authenticated})
      : super(key: key);

  final bool authenticated;

  @override
  State<CompaniesView> createState() => _CompaniesViewState();
}

class _CompaniesViewState extends State<CompaniesView> {
  List companies = [];
  List<bool> selected = [];

  void initState() {
    super.initState();

    _updateCompanyList();
  }

  void _updateCompanyList() {
    Dio().get(API_BASE + "company").then((r) {
      setState(() {
        companies = r.data;
        if (companies.length != selected.length) {
          selected =
              List<bool>.generate(companies.length, (int index) => false);
        }
      });
    });
  }

  void _delete() async {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please confirm'),
            content: const Text("Are you sure to remove selected companies?"),
            actions: [
              TextButton(
                  onPressed: () {
                    _delete_selected_compaines();
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

  void _delete_selected_compaines() async {
    int i = 0;

    List<String> company_names_with_error = [];

    for (var item in selected) {
      if (item) {
        var company = companies[i];
        try {
          await Dio().delete(API_BASE + "company/" + company["id"].toString());
        } on DioError catch (e) {
          var statusCode = e.response?.statusCode;
          if (statusCode is int && statusCode == 405) {
            company_names_with_error.add(company['name']);
          }
        }
      }
      i++;
    }

    //show toast with error
    if (company_names_with_error.length != 0) {
      String error_message =
          "Please remove every employee from the following companies befor removing the company itself:  " +
              company_names_with_error.join(", ");

      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: const Text('Unable to remove some selected companies'),
              content: Text(error_message),
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
    //update company list
    _updateCompanyList();
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

      _updateCompanyList();
    });
  }


  void _edit(index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditCompanyView(
                  company_id: companies[index]['id'],
                ))).then((value) => _updateCompanyList());
  }

  void _add() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditCompanyView(
                  company_id: 0,
                ))).then((value) => _updateCompanyList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Companies"),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Logo',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Website',
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
                        'Number of employee',
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
                      companies.length,
                      (index) => DataRow(
                            cells: <DataCell>[
                              DataCell(Container(
                                  width: 60,
                                  child: Image.network(companies[index]['logo']))),
                              DataCell(Container(
                                  width: 120,
                                  child: Text(companies[index]['name']))),
                              DataCell(Container(
                                  width: 120,
                                  child: Text(companies[index]['website']))),
                              DataCell(Container(
                                  width: 120,
                                  child: Text(companies[index]['email']))),
                              DataCell(Container(
                                  width: 30,
                                  child: Text(companies[index]
                                          ['employees_count']
                                      .toString()))),
                              DataCell(Container(
                                width: 120,
                                child: Row(children: [
                                  IconButton(
                                      tooltip: "Edit company data",
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