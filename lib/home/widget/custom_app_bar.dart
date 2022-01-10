import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar  extends StatelessWidget with PreferredSizeWidget{
  const CustomAppBar({
    Key? key}):  super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
                child: Image.asset(
                  'assets/logo.png',
                  height: 50,
                )),
            Expanded(
                flex: 2,
                child: Text(
                  'Dating',
                  style: GoogleFonts.reenieBeanie(
                    fontSize: 18,
                    color: Color(0xFF282E4A),
                    fontWeight: FontWeight.bold,
                  ),
                ))
          ],
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.message ,color: Theme.of(context).primaryColor,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.person ,color: Theme.of(context).primaryColor,)),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
