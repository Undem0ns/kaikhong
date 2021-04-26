import 'package:flutter/material.dart';
import 'package:kaikhong/style.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  int transportType = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Style().textH1('ข้อมูลลูกค้า'),
              TextField(
                style: TextStyle(fontSize: 24),
                decoration: InputDecoration(
                  labelText: 'ชื่อ',
                  icon: Icon(Icons.people),
                ),
              ),
              Center(
                child: GestureDetector(
                  child: Card(
                    child: Center(
                      child: RadioListTile(
                        value: 1,
                        groupValue: transportType,
                        title: Text(
                          'นัดรับ',
                          style: TextStyle(fontSize: 18),
                        ),
                        onChanged: (newvalue) {
                          setState(() {
                            transportType = newvalue;
                          });
                        },
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      transportType = 1;
                    });
                  },
                ),
              ),
              Center(
                child: GestureDetector(
                  child: Card(
                    child: Center(
                      child: RadioListTile(
                        value: 0,
                        groupValue: transportType,
                        title: Text(
                          'ส่ง Flash',
                          style: TextStyle(fontSize: 18),
                        ),
                        onChanged: (newvalue) {
                          setState(() {
                            transportType = newvalue;
                          });
                        },
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      transportType = 0;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
