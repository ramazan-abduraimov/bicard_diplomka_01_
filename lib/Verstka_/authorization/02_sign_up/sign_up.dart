  import 'package:bicard_diplomka_01_/Verstka_/authorization/02_sign_up/FillYourProfile.dart';
import 'package:bicard_diplomka_01_/Verstka_/authorization/04_sign_in/sign_in.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("asset/images/Vector.png"),
                  SizedBox(
                    height: 15,
                  ),
                  Text("HealthPal",style: TextStyle(fontSize: 20),),
                  SizedBox(
                    height: 15  ,
                  ),
                  Text("Cоздать аккаунт",style: TextStyle(fontSize: 25),),
                  SizedBox(
                    height: 10  ,
                  ),
                  Text("Мы здесь, чтобы помочь вам!",style: TextStyle(fontSize: 15,color: Color.fromRGBO( 107, 114, 128, 1)),),
                  SizedBox(height: 25,),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        prefixIcon: Icon(Icons.verified_user),
                        labelText: "Ваше имя"),
                  ),
                  SizedBox(height: 25,),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: "Электронной почты"),
                  ),
                  SizedBox(height: 25,),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: "Пароль"),
                    obscureText: true,
                  ), SizedBox(height: 30,),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(28, 42, 58, 1),
                        ),
                        foregroundColor:
                        MaterialStateProperty.all(Colors.white),
                        minimumSize: MaterialStateProperty.all(Size(350, 50)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => FillYourProfile(),
                        ));
                      },
                      child: Text(
                        "Cоздать аккаунт",
                        style: TextStyle(fontSize: 18),
                      )),
                  SizedBox(height: 10,),
                  Text("or"),
                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: Colors.black,width: 0.5),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("asset/images/Google - Original.png"),
                          Text("   Продолжайте работать с Google")
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: Colors.black,width: 0.5),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("asset/images/_Facebook.png"),
                          Text("    Продолжайте с Facebook")
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("У вас есть учетная запись? "),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignIn()));
                          },
                          child: Text("Bойти"))
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
