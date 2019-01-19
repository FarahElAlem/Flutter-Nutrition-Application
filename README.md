# Flutter-Nutrition-Application ( WIP )


## Notable Links:
- [Flutter Information](https://flutter.io/docs)
- [Flutter Documentation](https://docs.flutter.io/index.html)
- [Firebase Console](https://console.firebase.google.com/u/0/)
- [Firebase Documentation](https://firebase.google.com/)

## Version Information:
- **Flutter:** v. 1.1.6 
- **Dart:** v. 2.1.1
- **Android API Platform:** v. 27
- **Java:** v. 1.8.0_152 

## Coding Standards:
- Functions:
    - If possible, prefer lower-upper camel case on function naming.

- Classes:
    - All lowercase file names.
    - Uppercase CamelCase Formatting.  
      Example: ```class MyClass```
    - Flutter Widget State Hierarchy (Top to Bottom):
        - Variables
        - Constructor Functions
        - Utility Functions
        - @override Flutter Functions  
       Example 
       ```
       class MyClass extends StatelessWidget {
                    int _currentIndex = 0;  
                    Widget myWidget;    
                    MyClass(this.myWidget);
                    
                    void doStuff(Widget widget) {
                        this.myWidget = widget;
                    }
                    
                    @override
                    Widget build (BuildContext context) {
                        return new MaterialApp();
                    }
           }
       ```

- Variables:
    - Variables behave in a lower-upper camel case format similar to functions.


## Git ( For Collaborators )
- Make your own branch named "dev-*name*".
- Once your are done with a task, submit a pull request to the **dev** branch for review.

## TODO
- ~~Setup 4 placeholder pages~~
- ~~Setup Firebase DB~~
    - ~~Setup Nutrient data~~
    - Setup Recipe data (No easily avaliable information, working on this)
- ~~Allow search features to query nutrient data from firebase~~
    - ~~Allow users to search by food type~~
    - ~~Allow users to search by food name~~
- Allow search features to query recipe data from firebase
    - Allow users to search by recipe type
    - Allow users to search by recipe name
    - Allow users to search by ingredient(s)
- Find or write a ML model to identify similarity of words for recipie / nutrient db links (more on this later)
- Allow nutrient information to be displayed on recipe (python data cleaning)
- Add profile page, holding user informatio and search features
- Allow users to save lists of nutrients and/ favorite recipies
- Allow users to build a profile and share their recipies and nutrition lists
