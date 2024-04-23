import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FillYourProfile extends StatelessWidget {
  const FillYourProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 199, 210, 216),
        title: Text("Fill Your Profile",
            style: TextStyle(color: Color.fromARGB(153, 0, 0, 0))),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
                radius: 70.0, // Радиус аватарки
                backgroundColor: Colors.white, // Цвет фона
                backgroundImage: AssetImage('asset/images/profile-circle.png'),
                child: Padding(
                  padding: const EdgeInsets.only(left: 90, top: 90),
                  child: TextButton(
                    onPressed: () {},
                    child: Image.asset('asset/images/pen_icon.png'),
                  ),
                ) // Изображение аватарки
                ),
            Expanded(
                child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(48, 10, 47, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        labelText: "Имя"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(48, 10, 47, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        labelText: "Фамилия"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(48, 10, 47, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        labelText: "Электронной почты"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(48, 10, 47, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        labelText: "Дата рождения"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(48, 10, 47, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        labelText: "Пол"),
                  ),
                ),
              ],
            )),
            ElevatedButton(onPressed: () {}, child: Text("Save")),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
