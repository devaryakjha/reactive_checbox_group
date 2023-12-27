import 'package:flutter/material.dart';
import 'package:reactive_checbox_group/reactive_checbox_group.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'React Checkbox Group Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ReactiveForm(
        formGroup: FormGroup({
          'hobbies': FormControl<List<String>>(
            value: ['Reading'],
            validators: [Validators.required, Validators.minLength(1)],
          ),
        }),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle('Default Behavior'),
            ReactiveCheckboxGroupListTile<String>(
              controlAffinity: ListTileControlAffinity.leading,
              formControlName: 'hobbies',
              titleBuilder: (context, value) => Text(value),
              options: const ['Reading', 'Running', 'Traveling'],
              minimumOptions: 1,
            ),
            _buildTitle('Customize the list'),
            ListTileTheme(
              horizontalTitleGap: 0,
              child: ReactiveCheckboxGroupListTile<String>(
                controlAffinity: ListTileControlAffinity.leading,
                formControlName: 'hobbies',
                titleBuilder: (context, value) => Text(
                  value,
                  style: const TextStyle(fontSize: 12),
                ),
                options: const ['Reading', 'Running', 'Traveling'],
                listBuilder: (context, values) {
                  return Row(
                    children: values
                        .map(
                          (e) => Expanded(
                            child: e,
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
            _buildTitle('With Minimum Options Number'),
            ReactiveCheckboxGroupListTile<String>(
              controlAffinity: ListTileControlAffinity.leading,
              formControlName: 'hobbies',
              titleBuilder: (context, value) => Text(value),
              options: const ['Reading', 'Running', 'Traveling'],
              minimumOptions: 1,
            ),
          ],
        ),
      ),
    );
  }
}
