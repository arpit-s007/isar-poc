import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:isar_db_test/product_db_model.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationSupportDirectory();
  if (dir.existsSync()) {
    final isar = await Isar.open([ProductDbModelSchema], directory: dir.path);
    runApp(MyApp(isar: isar,));
  }
  
}

class MyApp extends StatelessWidget {
  final Isar isar;
  MyApp({super.key, required this.isar});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', isar: isar,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Isar isar;
  MyHomePage({super.key, required this.title, required this.isar});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  TextEditingController textController = TextEditingController();

  String productName = "";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    getFakeProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 30,
            ),

            TextField(
              controller: textController,
            ),

            SizedBox(
              height: 50,
            ),

            ElevatedButton(
              onPressed: () {
                fetchFakeProduct(textController.text);
              }, 
              child: Text("Fetch Record"),
              ),
              productName!= "" ? Text(productName) : const SizedBox(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future getFakeProducts() async{
    var productList = convertJsonToList(await rootBundle.loadString('assets/products-1.json'));

    await widget.isar.writeTxn(() async {
      await widget.isar.clear();
    });

    await widget.isar.writeTxn(() async {
      await widget.isar.productDbModels.importJson(productList);

      productList = convertJsonToList(await rootBundle.loadString('assets/products-2.json'));
      await widget.isar.productDbModels.importJson(productList);

      productList = convertJsonToList(await rootBundle.loadString('assets/products-3.json'));
      await widget.isar.productDbModels.importJson(productList);

      productList = convertJsonToList(await rootBundle.loadString('assets/products-4.json'));
      await widget.isar.productDbModels.importJson(productList);

      productList = convertJsonToList(await rootBundle.loadString('assets/products-5.json'));
      await widget.isar.productDbModels.importJson(productList);

      productList = convertJsonToList(await rootBundle.loadString('assets/products-6.json'));
      await widget.isar.productDbModels.importJson(productList);

      productList = convertJsonToList(await rootBundle.loadString('assets/products-7.json'));
      await widget.isar.productDbModels.importJson(productList);

      productList = convertJsonToList(await rootBundle.loadString('assets/products-8.json'));
      await widget.isar.productDbModels.importJson(productList);

      productList = convertJsonToList(await rootBundle.loadString('assets/products-9.json'));
      await widget.isar.productDbModels.importJson(productList);

      productList = convertJsonToList(await rootBundle.loadString('assets/products-10.json'));
      await widget.isar.productDbModels.importJson(productList);
    });
    }


    List<Map<String, dynamic>> convertJsonToList(jsonData) {
      // Decode the JSON string
      final decodedData = jsonDecode(jsonData) as List;

      // Cast each element to a Map<String, dynamic>
      return decodedData.cast<Map<String, dynamic>>();
    }

    Future fetchFakeProduct(productId) async{
      final stopwatch = Stopwatch();
      stopwatch.start();
      final product = await widget.isar.productDbModels.get(int.parse(productId));
      stopwatch.stop();

      Duration elapsed = stopwatch.elapsed;

      print(elapsed);

      setState(() {
        productName = product?.name ?? '';
      });
    }
}
