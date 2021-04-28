import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaikhong/style/style.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  DatabaseReference dbRefnocustomer =
      FirebaseDatabase.instance.reference().child('no customer');
  DatabaseReference dbRefcustomer;
  String transportType = 'ไม่ระบุ';
  String paidType = 'ไม่ระบุ';
  int itemNumber = 1;
  bool paid = true;
  String name, detail;
  String price;
  int noCustomer;

  @override
  void initState() {
    dbRefnocustomer.once().then((value) {
      dbRefcustomer = FirebaseDatabase.instance
          .reference()
          .child('customer')
          .child('customer${value.value}');
      setState(() {
        noCustomer = value.value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: Style().decoration(),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Style().textH1('ข้อมูลลูกค้า'),
                TextField(
                  style: TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    labelText: 'ชื่อ',
                    icon: Icon(Icons.person_pin),
                  ),
                  onChanged: (value) {
                    setState(() {
                      name = value.trim();
                    });
                  },
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: screenWidth * 0.33,
                      child: Center(
                        child: RadioListTile(
                          value: 'นัดรับ',
                          groupValue: transportType,
                          title: Style().textH3('นัดรับ'),
                          onChanged: (value) {
                            setState(() {
                              transportType = value;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: screenWidth * 0.33,
                      child: Center(
                        child: RadioListTile(
                          value: 'ส่ง Flash',
                          groupValue: transportType,
                          title: Style().textH3('ส่ง Flash'),
                          onChanged: (value) {
                            setState(() {
                              transportType = value;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: screenWidth * 0.33,
                      child: Center(
                        child: RadioListTile(
                          value: 'อื่นๆ',
                          groupValue: transportType,
                          title: Style().textH3('อื่นๆ'),
                          onChanged: (value) {
                            setState(() {
                              transportType = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                TextField(
                  style: TextStyle(fontSize: 24),
                  decoration: InputDecoration(
                    labelText: 'รายละเอียด',
                    icon: Icon(Icons.location_on),
                  ),
                  onChanged: (value) {
                    setState(() {
                      detail = value.trim();
                    });
                  },
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: screenWidth * 0.25,
                      child: Center(child: Style().textH2('จำนวน')),
                    ),
                    SizedBox(
                      height: 100,
                      width: screenWidth * 0.25,
                      child: Center(child: Style().textH2('$itemNumber  ห่อ')),
                    ),
                    Container(
                      width: screenWidth * 0.25,
                      child: ElevatedButton(
                        child: Style().textH1('+'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.greenAccent),
                        ),
                        onPressed: () {
                          setState(() {
                            itemNumber++;
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            itemNumber += 10;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.25,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent),
                        ),
                        child: Style().textH1('-'),
                        onPressed: () {
                          setState(() {
                            itemNumber--;
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            itemNumber -= 10;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.33,
                      child: Center(child: Style().textH2('ราคา')),
                    ),
                    SizedBox(
                      width: screenWidth * 0.33,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          setState(() {
                            price = value;
                          });
                          print(price);
                        },
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.33,
                      child: Center(child: Style().textH2('บาท')),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: screenWidth * 0.5,
                      child: Center(
                        child: RadioListTile(
                          value: 'จ่ายเงินสด',
                          groupValue: paidType,
                          title: Style().textH3('จ่ายเงินสด'),
                          onChanged: (value) {
                            setState(() {
                              paidType = value;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: screenWidth * 0.5,
                      child: Center(
                        child: RadioListTile(
                          value: 'โอน',
                          groupValue: paidType,
                          title: Style().textH3('โอน'),
                          onChanged: (value) {
                            setState(() {
                              paidType = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: screenWidth * 0.5,
                      child: Center(
                        child: CheckboxListTile(
                          title: Text('ขายปลีก'),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: paid,
                          onChanged: (bool value) {
                            setState(() {
                              paid = value;
                            });
                          },
                          activeColor: Colors.green,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: screenWidth * 0.5,
                      child: Center(
                        child: CheckboxListTile(
                          title: Text('ขายส่ง'),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: !paid,
                          onChanged: (bool value) {
                            setState(() {
                              paid = !value;
                            });
                          },
                          activeColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.greenAccent),
                    ),
                    child: Style().textH2('บันทึกรายการ'),
                    onPressed: () {
                      setState(() {});
                      dbRefnocustomer.set(++noCustomer);
                      dbRefcustomer.child('no').set(noCustomer - 1);
                      dbRefcustomer.child('name').set(name);
                      dbRefcustomer.child('transportType').set(transportType);
                      dbRefcustomer.child('detial').set(detail);
                      dbRefcustomer.child('itemNumber').set(itemNumber);
                      dbRefcustomer.child('price').set(price);
                      dbRefcustomer.child('paidType').set(paidType);
                      dbRefcustomer.child('paid').set(paid);

                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
