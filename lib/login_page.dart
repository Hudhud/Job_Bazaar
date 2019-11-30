import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_bazaar/auth.dart';
import 'package:job_bazaar/signup_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;

  final _resetPassFormKey = GlobalKey<FormState>();
  String _resetPassEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                    onSaved: (value) => _email = value,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: "Email Address")),
                SizedBox(height: 20.0),
                Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: RichText(
                          text: TextSpan(
                              text: 'Forgot password?',
                              style: TextStyle(
                                  color: Colors.blueAccent, fontSize: 16),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _buildMailSendDialog(context);
                                }),
                        ))),
                TextFormField(
                    onSaved: (value) => _password = value,
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Password")),
                SizedBox(height: 20.0),
                RaisedButton(
                  child: Text("Login"),
                  onPressed: () async {
                    final form = _formKey.currentState;
                    form.save();

                    if (form.validate()) {
                      try {
                        FirebaseUser result =
                            await Provider.of<AuthService>(context)
                                .loginUser(email: _email, password: _password);
                        print(result);
                      } on AuthException catch (error) {
                        return _buildErrorDialog(context, error.message);
                      } on Exception catch (error) {
                        return _buildErrorDialog(context, error.toString());
                      }
                    }
                  },
                ),
                Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Sign up',
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontSize: 16),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignupPage()),
                                      );
                                    })
                            ]),
                      ),
                    ))
              ],
            ),
          )),
    );
  }

  Future _buildErrorDialog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Error Message'),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }

  Future _buildMailSendDialog(BuildContext context) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Mail send'),
          content: Form(
            key: _resetPassFormKey,
            child: TextFormField(
                onSaved: (value) => _resetPassEmail = value,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email Address")),
          ),
          actions: <Widget>[
            FlatButton(
                child: Text('Send'),
                onPressed: () async {
                  final form = _resetPassFormKey.currentState;
                  form.save();

                  if (form.validate()) {
                    try {
                      // send email
                      await Provider.of<AuthService>(context)
                          .sendPasswordResetEmail(email: _resetPassEmail);
                    } on AuthException catch (error) {
                      return _buildErrorDialog(context, error.message);
                    } on Exception catch (error) {
                      return _buildErrorDialog(context, error.toString());
                    }
                  }

                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}
