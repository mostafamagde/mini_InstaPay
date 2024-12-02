import 'package:flutter/material.dart';


 snackBar({required content,required context}){
    ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  content,
                  
                  ),
                backgroundColor: Colors.red,
              ),
            );
}