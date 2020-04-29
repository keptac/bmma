import 'package:bmma/inventory/productlist.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'db/category.dart';
import 'registerproduct.dart';
import 'product_categories.dart';
import 'package:intl/intl.dart';

enum Page { dashboard, manage }

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.orange;
  MaterialColor notActive = Colors.grey;
  double _sellsValue = 0.0;
  int categories = 0;
  int products = 0;
  int sells = 0;
  TextEditingController categoryController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  CategoryService _categoryService = CategoryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(243, 235, 248, 1),
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.dashboard);
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color: _selectedPage == Page.dashboard
                            ? active
                            : notActive,
                      ),
                      label: Text(
                        'Dashboard',
                        style: TextStyle(color: Colors.white),
                      ))),
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.manage);
                      },
                      icon: Icon(
                        Icons.sort,
                        color:
                            _selectedPage == Page.manage ? active : notActive,
                      ),
                      label: Text(
                        'Manage',
                        style: TextStyle(color: Colors.white),
                      ))),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.blue[900],
        ),
        body: _loadScreen());
  }

  Widget _loadScreen() {
    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.jpg'),
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromRGBO(0, 0, 50, 0.9),
                              Color.fromRGBO(0, 0, 50, 0.7),
                            ]),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      right: 20,
                      child: Center(
                        child: Text(
                          'INVENTORY',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 20,
                      right: 20,
                      child: Center(
                        child: Text(
                          'Revenue Sells: \$ $_sellsValue',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 15,
                      bottom: 10,
                      child: Text(
                        DateFormat('dd-MM-yyyy')
                            .format(
                              DateTime.now(),
                            )
                            .toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin:EdgeInsets.only(left:10.0, right:10.0),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Card(
                        elevation: 10,
                        child: Wrap(
                          children: <Widget>[
                            ListTile(
                                title: FlatButton.icon(
                                    onPressed: null,
                                    icon: Icon(Icons.category),
                                    label: Text("Category")),
                                subtitle: Text(
                                  '$categories',
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(color: active, fontSize: 60.0),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductCategories()));
                                }),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Card(
                        elevation: 10,
                        child: ListTile(
                            title: FlatButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.track_changes),
                                label: Text("Products")),
                            subtitle: Text(
                              '$products',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 60.0),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ProductList()));
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Card(
                        elevation: 10,
                        child: ListTile(
                            title: FlatButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.tag_faces),
                                label: Text("Sold")),
                            subtitle: Text(
                              '$sells',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: active, fontSize: 60.0),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add product"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => HomeMaterial()));
              },
            ),
            Divider(),
            ListTile(
                leading: Icon(Icons.change_history),
                title: Text("Products list"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ProductList()));
                }),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text("Add category"),
              onTap: () {
                _categoryAlert();
              },
            ),
            Divider(),
            ListTile(
                leading: Icon(Icons.category),
                title: Text("Category list"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ProductCategories()));
                }),
            Divider(),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  void _categoryAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: TextFormField(
          controller: categoryController,
          validator: (value) {
            if (value.isEmpty) {
              return 'category cannot be empty';
            }
          },
          decoration: InputDecoration(hintText: "add category"),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              if (categoryController.text != null) {
                _categoryService.createCategory(categoryController.text);
              }
              Fluttertoast.showToast(msg: 'category created');
              Navigator.pop(context);
            },
            child: Text('ADD')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CANCEL')),
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }
}
