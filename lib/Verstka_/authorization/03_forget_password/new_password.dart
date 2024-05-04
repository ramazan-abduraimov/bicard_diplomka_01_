import 'package:bicard_diplomka_01_/Verstka_/authorization/04_sign_in/sign_in.dart';
import 'package:flutter/material.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
                  SizedBox(height: 25,),
                  Image.asset("asset/images/Vector.png"),
                  SizedBox(
                    height: 16,
                  ),
                  Text("HealthPal",style: TextStyle(fontSize: 20),),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Создайте новый пароль ",style: TextStyle(fontSize: 25),),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text("Ваш новый пароль должен отличаться от ранее использованного ",style: TextStyle(fontSize: 15,color: Color.fromRGBO( 107, 114, 128, 1)),
                      textAlign: TextAlign.center, // Align text to center
                    ),
                  ),
                  SizedBox(
                    height: 29,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Пароль "),
                  ),
                  SizedBox(
                    height: 29,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        prefixIcon: Icon(Icons.lock_rounded),
                        labelText: "Подтвердите пароль  "),
                  ),
                  SizedBox(
                    height: 29,
                  ),
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
                          builder: (BuildContext context) => SignIn(),
                        ));
                      },
                      child: Text(
                        "Cброс пароля",
                        style: TextStyle(fontSize: 18),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
