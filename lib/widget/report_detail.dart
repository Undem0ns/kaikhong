import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaikhong/widget/add_sale_order.dart';
import 'package:kaikhong/customer.dart';
import 'package:kaikhong/style/style.dart';

class ReportDetailPage extends StatefulWidget {
  ReportDetailPage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ReportDetailPage> {
  DatabaseReference dbRefcustomerm =
      FirebaseDatabase.instance.reference().child('customer');
  DatabaseReference dbRefnocustomer =
      FirebaseDatabase.instance.reference().child('no customer');

  DatabaseReference dbRefReportDetail =
      FirebaseDatabase.instance.reference().child('report detail');

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
      paidType: custommer.paidType,
      id: custommer.no,
      transportType: custommer.transportType,
      paid: custommer.paid ? 'ขายปลีก' : 'ขายส่ง',
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
    String paidType = 'จ่าย',
    String paid = 'ขาย',
    String transportType = 'ส่ง',
  }) {
    return GestureDetector(
      onTap: () {},
      //   _showDialog(context);
      // },
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
                child: Center(child: Text(paidType)),
              ),
              SizedBox(
                height: 50,
                width: 100,
                child: Center(child: Text(paid)),
              ),
              SizedBox(
                height: 50,
                width: 100,
                child: Center(child: Text(transportType)),
              ),
              SizedBox(
                height: 50,
                width: 100,
                child: GestureDetector(
                  onTap: () {
                    _showDialog(
                      context,
                      id: id,
                    );
                  },
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

  void _showDialog(BuildContext context, {int id}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("ลบรายการ?"),
          content: Text("ต้องการลบรายการนี้ใช่หรือไม่"),
          actions: <Widget>[
            ElevatedButton(
              child: Text("ลบ"),
              onPressed: () {
                deleteFromDB(id);
                Navigator.of(context).pop();
              },
            ),
            CupertinoButton(
              child: Text("ยกเลิก"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
