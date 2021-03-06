# Flutter-Nutrition-Application ( WIP )

### ~~Exam Week, Taking a Break....~~
### Recently found out about Flutter Create, currently going to take a break from this nutrition app to work on a small app for that competition. The Git Repo for that project will be made public once the competition ends.

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
    - ~~Setup Recipe data (No easily avaliable information, working on this)~~
        - ~~Parsing the data now to accurately display nutritition information (done in python, not included in repo)~~
        - ~~Parsed data, but I have realized that Cloud Firestore might be a better option that a RTDB at this moment, am converting...~~
        - ~~Converted to cloud firestore, but am having some issues searching substrings. Have found some solutions, but I may have to upgrade my Cloud Firestore plan ($$$) to add the functionality~~.
- ~~Allow search features to query nutrient data from firebase~~
    - ~~Allow users to search by food type~~
    - ~~Allow users to search by food name~~
- ~~Allow search features to query recipe data from firebase~~
    - ~~Allow users to search by recipe type~~
    - ~~Allow users to search by recipe name~~
    - ~~Allow users to search by ingredient(s)~~
- ~~Find or write a ML model, or find an easy way to map the nutrient values to the recipe ingredient values to identify similarity of words for recipie / nutrient db links~~
- ~~Add profile page, holding user information and saved nutrient lists / favorited recipes~~
- ~~Allow users to save lists of nutrients and/ favorite recipes~~
- ~~Allow users to build a profile and share their recipes and nutrition lists~~
- Privacy Policy
- ~~First Name Register Field~~
- "Hello User" Splash Screen for returning users
- ~~"Welcome User" Splash Screen for new users~~
- ~~Login Button for users who got logged out but already have an account~~
- ~~Hero buttons, 3/4ths image 1/4 text on item selection~~
- ~~Clean up recipes and nutrition for better user experience~~
- ~~Create User Profile Page~~
- ~~Create Dashboard~~
- ~~Redesign Details UI for nutrients~~
- ~~Design Details UI for recipes~~z
- ~~*IMPORTANT* Reconfigure database with new data + preformatting~~
- ~~Reconfigure Database to support Material Search~~
- ~~Attempt to support recipe(s) with estimated nutrient values~~
- Add advanced data security
- ~~Add Custom User Recipes~~
- ~~Add 'delayed update' for user items to reduce DB calls~~
- ~~Convert DB from Grams to appropiate unit(s) of measure~~
- ~~Multiply DB 'calorie' data by 1000 to represent proper information~~
- Experiment with SliverAppBar and transparent blur effects for background
- Find out AppBar height add appropiate padding in stack
