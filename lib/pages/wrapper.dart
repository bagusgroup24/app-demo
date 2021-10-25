part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    auth.User firebaseUser = Provider.of<auth.User>(context);

    if (firebaseUser == null) {
      return Scaffold(
        body: Login(),
      );
    } else {
      return Scaffold(
        body: Home(),
      );
    }
  }
}
