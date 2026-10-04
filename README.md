# MSCS632 - Assignment 5: Ride Sharing System

A class-based Ride Sharing System implemented in two languages: **C++** and **Smalltalk** (Pharo). The project demonstrates three core Object-Oriented Programming (OOP) principles: **Encapsulation**, **Inheritance**, and **Polymorphism**.

---

## OOP Concepts Demonstrated

1. **Encapsulation**:
   - **C++**: Attributes (`rideID`, `pickupLocation`, `dropoffLocation`, `distance`, `assignedRides`, `requestedRides`) are declared `private`. Internal collections are mutated exclusively via public methods (`addRide()`, `requestRide()`, `getDriverInfo()`, `getRiderInfo()`).
   - **Smalltalk**: All instance variables are private by language design and only accessible/mutable via defined methods (`addRide:`, `requestRide:`, `getDriverInfo`, `getRiderInfo`).

2. **Inheritance**:
   - **C++**: `StandardRide` and `PremiumRide` inherit from the base abstract class `Ride`.
   - **Smalltalk**: `StandardRide` and `PremiumRide` are subclasses of `Ride`.

3. **Polymorphism**:
   - **C++**: Base class `Ride` declares pure virtual methods `fare()` and `rideType()`. A heterogeneous collection `vector<shared_ptr<Ride>>` invokes `rideDetails()` and `fare()` polymorphically at runtime.
   - **Smalltalk**: `StandardRide` and `PremiumRide` override `fare` and `rideType`. An `OrderedCollection` of rides dynamically responds to `fare` and `rideDetails` via message dispatch.

---

## How to Run

### 1. C++ Implementation

```bash
cd cpp
g++ -std=c++17 ride_sharing.cpp -o ride_sharing
./ride_sharing
```

### 2. Smalltalk Implementation (Pharo)

From the project root:

```bash
/Applications/PharoLauncher.app/Contents/MacOS/Pharo --headless Pharo.image st smalltalk/ride_sharing.st --quit
```

Or open `Pharo.image` in the Pharo GUI, open **Playground**, and evaluate:

```smalltalk
'smalltalk/ride_sharing.st' asFileReference fileIn.
```
