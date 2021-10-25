part of 'pages.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget nav() {
      return AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Login',
          style: whiteText,
        ),
      );
    }

    return Scaffold(
      appBar: nav(),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  'register here ...',
                  style: blackText.copyWith(
                    fontWeight: bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    'Login',
                    style: whiteText.copyWith(
                      fontWeight: bold,
                    ),
                  ),
                  onPressed: () async {
                    await AuthServices.login(
                      emailController.text,
                      passwordController.text,
                    );
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
