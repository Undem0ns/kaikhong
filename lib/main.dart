import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kaikhong/add-item.dart';
import 'package:kaikhong/customer.dart';
import 'package:kaikhong/customerModel.dart';
import 'package:kaikhong/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Style().primaryColor,
          floatingActionButtonTheme: FloatingActionButtonThemeData(),
        ),
        home: FutureBuilder(
          future: fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('Error ${snapshot.error.toString()}');
              return Text('Something wrong');
            } else if (snapshot.hasData) {
              return MyHomePage(title: 'Flutter Demo Home Page');
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseReference dbRefcustomerm =
      FirebaseDatabase.instance.reference().child('customer');
  DatabaseReference dbRefnocustomer =
      FirebaseDatabase.instance.reference().child('no customer');
  CustomerModel model;

  String data;
  List<Widget> cardWidget = [];
  List<Custommer> customerList = [];
  @override
  void initState() {
    super.initState();
    readData();
  }

  Future readData() async {
    cardWidget = [];
    customerList = [];
    dbRefnocustomer.once().then((value) {
      for (var i = 0; i < value.value; i++) {
        dbRefcustomerm.child('customer$i').once().then((value) {
          if (value.value != null) {
            Custommer custommer = Custommer.fromMap(value.value);
            customerList.add(custommer);
            setState(() {
              cardWidget.insert(0, (createWidget(custommer, 100)));
              print(custommer.no);
            });
          }
        });
      }
    });
  }

  Widget createWidget(Custommer custommer, double screenw) {
    return buildCard(
      screenw,
      name: custommer.name,
      itemNumber: custommer.itemNumber.toString(),
      price: custommer.price,
      paid: custommer.paid ? 'จ่ายแล้ว' : 'ยังไม่จ่าย',
      id: custommer.no,
    );
  }

  Future refresh() async {
    await Future.delayed(Duration(seconds: 2));
    readData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Container(
          decoration: Style().decoration(),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      color: Colors.lightGreen,
                      child: Center(
                        child: SizedBox(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Style().textH1('รวม'),
                              showTotalItem(customerList),
                              showTotalPrice(customerList),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Style().textH1('รายการขาย'),
                    buildCard(100),
                    Card(
                      child: Column(
                        children: cardWidget,
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
              heroTag: 1,
              onPressed: () {
                readData();
              },
              child: Icon(
                Icons.refresh,
              )),
          FloatingActionButton(
            heroTag: 2,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddItem()));
            },
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }

  GestureDetector buildCard(
    double screenWidth, {
    int id = -1,
    String name = 'ชื่อ',
    String itemNumber = 'จำนวน',
    String price = 'ราคา',
    String paid = 'จ่าย',
  }) {
    return GestureDetector(
      onTap: () => print(id),
      child: Card(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                height: 50,
                width: 100,
                child: Center(child: Text(name == null ? '' : name)),
              ),
              SizedBox(
                height: 50,
                width: 100,
                child: Center(child: Text(itemNumber)),
              ),
              SizedBox(
                height: 50,
                width: 100,
                child: Center(child: Text(price == null ? '' : price)),
              ),
              SizedBox(
                height: 50,
                width: 100,
                child: Center(child: Text(paid)),
              ),
              SizedBox(
                height: 50,
                width: 100,
                child: GestureDetector(
                  onTap: () => deleteFromDB(id),
                  child: Center(
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  deleteFromDB(int id) {
    dbRefcustomerm.child('customer$id').remove();
    print('Deleted customer$id from DB');
    setState(() {
      readData();
    });
  }

  Widget showTotalPrice(List<Custommer> custommerList) {
    double totalPrice = 0;
    if (custommerList != null) {
      for (var customer in custommerList) {
        totalPrice +=
            double.parse(customer.price == null ? '0' : customer.price);
      }
      return Style().textH1('$totalPrice บาท');
    } else {
      return Style().textH1('0 บาท');
    }
  }

  Widget showTotalItem(List<Custommer> custommerList) {
    int totalItem = 0;
    for (var customer in custommerList) {
      totalItem += customer.itemNumber;
    }
    return Style().textH1('$totalItem ห่อ');
  }
}
