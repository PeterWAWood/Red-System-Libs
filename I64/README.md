# I64 - Basic 64-bit Integer Arithmetic

I wrote this library to be able to handle aritmetic on 64-bit integers returned from external source such as Window's APIs. It is an interim library as I expect that Red/System 2 will have built in support for 64-bit integers.It provides basic addition, subtraction, multiplication and division and not much else. It uses simple algorithms and hasn't been optimised but it is sufficient for my current needs.

##  The int64! structure - PWAW-I64-int64!

This is a structure containing two members which are both of the integer! type. One is called most-sig, the other least-sig. 

Declaring and initialising an int64! 
```
  my-int64: declare PWAW-I64-int64!
  my-int64/most-sig: 0
  my-int64/least-sig: FFFFFFFFh
```
## Available Defines and Variables

The library includes a number of helpful defines and a couple of useful variables.

### Function Return Status Codes

The library uses the following function return status codes which are integers:
```
#define	PWAW-I64-OKAY              0	                
#define PWAW-I64-OVERFLOW          1
#define PWAW-I64-INVALID-ARG       2					
#define PWAW-I64-EXCESSIVE-SHIFT   3
#define PWAW-I64-ZERO-DIVIDE       4
```

### PWAW-I64-zero

An int64! initialised to zero.

### PWAW-I64-one

An int64! initialised to one.

### PWAW-I64-copy(a b)

A macro which copies the value of one int64! to another.

### PWAW-I64-equal?(a b)

A macro which tests if two int64!s are equal. It will evelaute to true if they are and false if they are not.

### PWAW-I64-nagative?(a)

A macro which checks if an int64! is negative.


### PWAW-I64-positive?

A macro which checks if an int64! is positive.

### PWAW-I64-zero?

A macro which checks if an int64! is zero.

### PWAW-I64-zero-int64(a)

A macro which sets the value of an int64! to zero.

## Functions

The library includes the following public functions and a handful of supporting functions

### PWAW-I64-add a b c

This function adds a to b and places the result into c. All three are int64!s. The function returns one of the Function Return Status Codes.

### PWAW-I64-div a b c d

This function divides a by b, places the result into c, and the remainder into d. All three are int64!s. The function returns one of the Function Return Status Codes.

### PWAW-I64-sub a b c

This function subtracts b from a and places the result into c. All three are int64!s. The function returns one of the Function Return Status Codes.

### PwAW-I64-greater? a b

This functions returns true if a is greater than b, otherwise it returns false.

### PWAW-I64-mul a b c

This function multiplies a and b and places the result into c. All three are int64!s. The function returns one of the Function Return Status Codes.
