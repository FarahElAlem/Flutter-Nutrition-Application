# Flutter-Nutrition-Application


## Notable Links:
- [Flutter Information](https://flutter.io/docs)
- [Flutter Documentation](https://docs.flutter.io/index.html)
- [Firebase Console](https://console.firebase.google.com/u/0/)
- [Firebase Documentation](https://firebase.google.com/)

## Version Information:
- **Flutter:** v. 1.1.6 
- **Dart:** v. 2.1.1
- **Android API Platform:** v. 27
- **Java:** v. 1.8.0_152 (Note included w/ Android API 27 Platform)

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
       ```class MyClass extends StatelessWidget{
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
    - 'Private' variables are preceded by an _ (since private variables arn't really a thing).  
       Example: `int _currentIndex = 0;`
    - Variables behave in a lower-upper camel case format similar to functions.


## Git
- Make your own branch named "dev-*name*".
- Once your are done with a task, submit a pull request to the **dev** branch for review.
