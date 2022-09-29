import 'package:apk/widgets/Transaction_list.dart';
import 'dart:io';
import './models/Transaction.dart';
import 'package:flutter/material.dart';
import './widgets/New_Transaction.dart';
import './widgets/chart.dart';

import 'package:flutter/cupertino.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp]
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          textTheme: ThemeData.light()
              .textTheme
              .copyWith(button: TextStyle(color: Colors.white))),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: "t1",
    //   title: 'tarkari',
    //   amount: 80.12,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "t2",
    //   title: 'Kirana',
    //   amount: 100.12,
    //   date: DateTime.now(),
    // )
  ];

  bool _showChart = false;



// All about adding listeners to the widgets
@override

void initState(){
  WidgetsBinding.instance .addObserver(this); 
  super.initState();

}
@override
  void didChangeAppLifecycleState(AppLifecycleState state){
    print(state);




  }

@override

dispose()
{
  super.dispose();
}

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txtitle, double txamount, DateTime pickedDate) {
    final _newTx = Transaction(
        id: pickedDate.toString(),
        title: txtitle,
        amount: txamount,
        date: pickedDate);

    setState(() {
      _userTransactions.add(_newTx);
    });
  }

  void _startNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bcntx) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransation(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery,AppBar appBar,txListWidget) {
    return [Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Show Chart"),
        Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            })
      ],
    ),
      _showChart == true
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions))
          : txListWidget,
    ];
  }

  List<Widget> _buildPortraitContent(MediaQueryData mediaQuery, AppBar appBar,txListWidget) {
    return [
      Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: Chart(_recentTransactions)),
      txListWidget,
    ];
  }


  Widget _navigationBar()
  {
    return CupertinoNavigationBar(
        middle: const Text('Personal Expenses'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: Icon(CupertinoIcons.add),
              onTap: () => _startNewTransaction(context),
            ),
          ],
        )); 
  }


  Widget _appBar()
  {
    return AppBar(
      title: const Text('Flutter App'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startNewTransaction(context),
        ),
      ],
    );

  }

  @override
  Widget build(BuildContext context) {
    print("build of Main");
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final mediaQuery = MediaQuery.of(context);

    var platform = Platform;
    final navBar = _navigationBar();
    final appBar = AppBar();
    final txListWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: Transaction_List(_userTransactions, _deleteTransation));

    final pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (isLandScape) ..._buildLandscapeContent(mediaQuery,appBar,txListWidget),
            if (!isLandScape) ..._buildPortraitContent(mediaQuery, appBar,txListWidget),//spread operator
           
              
            Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startNewTransaction(context))
          ],
        ),
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: navBar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(appBar: appBar, body: pageBody);
  }
}
