import 'package:books_app/models/category.dart';
import 'package:flutter/cupertino.dart';

class Categories with ChangeNotifier {
  List<Category> categoriesList = [
    Category(
        categoryTitle: 'Application \n Development',
        categoryLink: 'application development',
        iconLink: 'images/appDev.png'),
    Category(
        categoryTitle: 'Artificial \n Intelligence',
        categoryLink: 'artificial intelligence',
        iconLink: 'images/AI.png'),
    Category(
        categoryTitle: 'Computer \n Architecture',
        categoryLink: 'computer architecture',
        iconLink: 'images/compArch.png'),
    Category(
        categoryTitle: 'Compiler \n Design',
        categoryLink: 'compiler design',
        iconLink: 'images/compiler.png'),
    Category(
        categoryTitle: 'Computer \n Networks',
        categoryLink: 'computer networks',
        iconLink: 'images/networking.png'),
    Category(
        categoryTitle: 'Data Structures \n & Algorithms',
        categoryLink: 'data structures',
        iconLink: 'images/algorithm.png'),
    Category(
        categoryTitle: 'DBMS',
        categoryLink: 'dbms',
        iconLink: 'images/database.png'),
    Category(
        categoryTitle: 'Digital \n Design',
        categoryLink: 'digital design',
        iconLink: 'images/digitalDesign.png'),
    Category(
        categoryTitle: 'Distributed \n Systems',
        categoryLink: 'distributed systems',
        iconLink: 'images/Distributed.png'),
    Category(
        categoryTitle: 'Electrical & \n Electronics',
        categoryLink: 'electrical & electronics',
        iconLink: 'images/electrical.png'),
    Category(
        categoryTitle: 'Operating \n Systems',
        categoryLink: 'Operating Systems',
        iconLink: 'images/OS.png'),
    Category(
        categoryTitle: 'Programming \n Languages',
        categoryLink: 'Programming Languages',
        iconLink: 'images/ProgLang.png'),
    Category(
        categoryTitle: 'Software \n Engineering',
        categoryLink: 'software engineering',
        iconLink: 'images/SoftwareEng.png'),
    Category(
        categoryTitle: 'Others',
        categoryLink: 'others',
        iconLink: 'images/Others.png'),
  ];
}
