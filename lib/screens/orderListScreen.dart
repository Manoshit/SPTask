import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orderProvider.dart';

class orderListScreen extends StatelessWidget {
  static const routeName = '/orderListScreen';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Pull Down'),
        ),
        body: RefreshIndicator(
          onRefresh: () => ordersData.getOrderList(context),
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Center(
                            child: Text(
                          'Order No ${index + 1}',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        )),
                      ),
                      Row(
                        children: <Widget>[
                          Text('Payment Status'),
                          SizedBox(
                            width: 20,
                          ),
                          Text(ordersData.getOrders[index]['payment_received']
                              .toString()),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Order Status'),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                              ordersData.getOrders[index]['status'].toString()),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Table Number'),
                          SizedBox(
                            width: 20,
                          ),
                          Text(ordersData.getOrders[index]['table_number']
                              .toString()),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Total Amount'),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Rs" +
                              ordersData.getOrders[index]['total_amount']
                                      ['\$numberDecimal']
                                  .toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: ordersData.getOrders.length,
          ),
        ));
  }
}
