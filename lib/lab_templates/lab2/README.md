# Lab2

## Classes

Create a Dart class named Book with the following specifications:

Properties: title (String), author (String), and numberOfPages (int).
A constructor that initializes all the properties.
A method named bookDetails that prints a string containing all the properties.

Show call of method

## Inheritance

Create a class named FictionBook that inherits from the Book class created in Task 1. Add a new property named genre (String) and override the bookDetails method to include the genre in the output.


## Mixins

Create a mixin named JsonSerializable with a method toJson which returns a Map representation of the class. Apply this mixin to the Book class so that calling toJson on a Book instance returns a Map with keys title, author, and numberOfPages.

## Function

Write a Dart function named calculateArea that takes two named parameters length and width (both of type double) and an optional parameter shape of type String with a default value of "rectangle". The function should return the area as a double. If shape is "circle", use length as the radius to calculate the area of the circle (use 3.14 as the value of pi).

## Null-safety

Create a Dart class named User with the following properties:

name (String): Required parameter.
age (int?): Nullable parameter.
email (String?): Nullable parameter.
The class should have a constructor that initializes all the properties.

Additionally, create a method named printUserDetails that prints the user details in the following format:

Name: [user name]
Age: [user age]
Email: [user email]

If the age or email is null, it should print "N/A" instead of the actual value.
