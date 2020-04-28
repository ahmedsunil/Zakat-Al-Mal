import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Zakat Al-Mal',
    home: ZAMForm(),
    theme: ThemeData(
      primaryColor: Colors.teal,
      accentColor: Colors.tealAccent,
      buttonTheme: ButtonThemeData(
        height: 45,
        minWidth: 100,
        buttonColor: Colors.teal,
        textTheme: ButtonTextTheme.primary,
      ),
    ),
  ) //Material App
  );
}

class ZAMForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ZAMFormState();
  }
}


class _ZAMFormState extends State<ZAMForm> {
  var _formKey = GlobalKey<FormState>();

  // to give padding
  final double _minimumPadding = 5.0; //to add padding through the whole app

  //to calculate and display result
  TextEditingController savingsController = TextEditingController();
  TextEditingController nisabController = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text('Zakat Al-Mal', textAlign: TextAlign.center,),

          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                      Navigator
                          .push(context,
                          MaterialPageRoute(
                            builder: (context) => About()
                          )
                      );
                  },
                  child: Icon(
                      Icons.info_outline
                  ),
                )
            ),
          ],
      ),

      body: Form(
        key: _formKey,

        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 3),
            child: ListView(
              children: <Widget>[
                //Image of the Application
                getImageAsset(),

                Padding(
                  padding: EdgeInsets.all(_minimumPadding),
                  child: Text(
                    '" And establish prayer and give zakah and bow with those who bow [in worship and obedience] "',
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),

                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding * 5, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: savingsController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter the amount in your savings';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Savings',
                          hintText:
                              'Enter the Amount you have in savings in MVR',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0))),
                    )),

                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding * 3, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: nisabController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter the nisab value';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Nisab',
                          hintText:
                              'Enter the Nisab Amount (Refer MIRA website)',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0))),
                    )),

                Padding(
                    padding: EdgeInsets.only(
                        bottom: _minimumPadding, top: _minimumPadding * 2),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            child: Text(
                              'Calculate',
                              textScaleFactor: 1.1,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  this.displayResult = _calculateTotal();
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    )),

                Padding(
                  padding: EdgeInsets.only(
                      bottom: _minimumPadding, top: _minimumPadding * 3),
                  child: Text(
                    'You have to pay',
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      bottom: _minimumPadding, top: _minimumPadding * 6),
                  child: Text(
                    this.displayResult,
                    style: TextStyle(
                        color: Colors.teal[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                    textAlign: TextAlign.center,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      bottom: _minimumPadding, top: _minimumPadding * 8),
                  child: Text(
                    'Developed with Love',
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.normal,
                        fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/zaka-logo.png');
    Image image = Image(
      image: assetImage,
      width: 150.0,
      height: 150.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  String _calculateTotal() {
      double savings = double.parse(savingsController.text);
      double nisab = double.parse(nisabController.text);

      if (savings >= nisab) {
        double totalAmountPayable = savings * 2.5 / 100;
        String result = 'MVR $totalAmountPayable';
        return result;
      } else {
        String result = '0';
        return result;
      }
  }
}


//About Page
class About extends StatelessWidget {
  final double _minimumPadding = 5.0; //to add padding through the whole app

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About')),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(_minimumPadding * 4),
            child: Text(
              'About the App',
              style: TextStyle(
                  color: Colors.teal[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
              textAlign: TextAlign.center,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(_minimumPadding * 4),
            child: Text(
              'This Application is Developed for Mobile Application Development Module which is a part of Bachelors in IT Program held by Clique College',
              style: TextStyle(
                  color: Colors.teal[400],
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(_minimumPadding * 4),
            child: Text(
              'Who can receive my zakat?',
              style: TextStyle(
                  color: Colors.teal[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(_minimumPadding * 4),
            child: Text(
              'To be eligible to receive zakat, the recipient must be poor and or needy. A poor person is someone whose property, in excess of his basic requirements, does not reach the nisab threshold. The recipient must not belong to your immediate family, your spouse, children, parents and grandparents cannot receive your zakat. Other relatives, however, can receive your zakat. The recipient must not be a Hashimi, a descendant of the Prophet (peace be upon him)',
              style: TextStyle(
                  color: Colors.teal[400],
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          ListTile(
            title: Text('Meet the Team',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.teal[400],
                  fontWeight: FontWeight.normal,
                  fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
          ListTile(
            leading: Icon(Icons.developer_mode),
            title: Text('Hassan Ismail'),
          ),
          ListTile(
            leading: Icon(Icons.developer_mode),
            title: Text('Ali Nabeeh'),
          ),
          ListTile(
            leading: Icon(Icons.developer_mode),
            title: Text('Azmyn'),
          ),
          ListTile(
            leading: Icon(Icons.developer_mode),
            title: Text('Ahmed Sunil'),
          ),
        ],
      ),
    );
  }
}