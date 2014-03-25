##PeopleSorts
PeopleSorts is a ruby (verion 1.9.3) application that parses delimiter-seperated records. Various queries can then be performed against the data to sort it by birth, lastname, and gender. 

As much as possible I have tried to follow Sandi Metz's rules of modularity, among them, trying to write single-responsibility methods of 5 lines or less.

An OO approach was used, objects include:
* Person: A collection of data points. 
* PeopleFinder: An extension of Person that functions as a database.
* DSV: A custom parser similar to the CSV library.
* ViewControl: For rendering objects.

Sample files provided with this challenge were used as the basis for some simple tests.

To run the program, on the command line run:
```
ruby peoplesorts.rb ['tests'] [filepaths]
```
By default it will load the three comma, pipe and space delimited files provided with the challenge.

Given more time I would refactor the unit tests and focus on making the process of loading and passing data to the Person class less brittle.



Original Challenge Description
================================
Write a Ruby program to first assemble a single set of records by parsing data from 3 different file formats and then display these records sorted in 3 different ways.

###Guidelines

We hope that this exercise will allow us to evaluate your skills as a developer. The qualities that we pay special attention to are:

    - Simplicity/elegance of design
    - Adherence to good software engineering principles
    - Maintainability (clean, easy to understand code)
    - Effective use of the standard library
    - Use of unit tests

###Input Data

A record consists of the following 5 fields: last name, first name, gender, date of birth and favorite color. You will be given 3 files, each containing records stored in a different format.

* The pipe-delimited file lists each record as follows:  
  LastName | FirstName | MiddleInitial | Gender | FavoriteColor | DateOfBirth
* The comma-delimited file looks like this:  
  LastName, FirstName, Gender, FavoriteColor, DateOfBirth
* The space-delimited file looks like this:  
  LastName FirstName MiddleInitial Gender DateOfBirth FavoriteColor

You may assume that the delimiters (commas, pipes and spaces) do not appear anywhere in the data values themselves. Write a Ruby program to read in records from these files and combine them into a single set of records.

###Display Requirements
* Create and display 3 different views of the recordset (see sample/expected-output.txt):

    - Output 1 – sorted by gender (females before males) then by last name ascending.
    - Output 2 – sorted by birth date, ascending.
    - Output 3 – sorted by last name, descending.

* Ensure that fields are displayed in the following order: last name, first name, gender, date of birth, favorite color.
* Display dates in the format M/D/YYYY.