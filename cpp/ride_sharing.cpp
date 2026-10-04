#include <iomanip>
#include <iostream>
#include <memory>
#include <sstream>
#include <string>
#include <vector>

using namespace std;

// ============================================================
// Base Class: Ride
// Demonstrates encapsulation and provides the base interface
// for polymorphism.
// ============================================================

class Ride {
private:
  int rideID;
  string pickupLocation;
  string dropoffLocation;
  double distance;

protected:
  double getDistance() const { return distance; }

public:
  Ride(int id, const string &pickup, const string &dropoff, double miles)
      : rideID(id), pickupLocation(pickup), dropoffLocation(dropoff),
        distance(miles) {}

  virtual ~Ride() = default;

  int getRideID() const { return rideID; }

  virtual double fare() const = 0;

  virtual string rideType() const = 0;

  virtual string rideDetails() const {
    ostringstream output;

    output << fixed << setprecision(2);
    output << "Ride ID: " << rideID << " | Type: " << rideType()
           << " | Pickup: " << pickupLocation
           << " | Dropoff: " << dropoffLocation << " | Distance: " << distance
           << " miles"
           << " | Fare: $" << fare();

    return output.str();
  }
};

// ============================================================
// Derived Class: StandardRide
// ============================================================

class StandardRide : public Ride {
public:
  StandardRide(int id, const string &pickup, const string &dropoff,
               double miles)
      : Ride(id, pickup, dropoff, miles) {}

  double fare() const override {
    const double baseFare = 2.50;
    const double perMileRate = 1.50;

    return baseFare + (getDistance() * perMileRate);
  }

  string rideType() const override { return "Standard"; }
};

// ============================================================
// Derived Class: PremiumRide
// ============================================================

class PremiumRide : public Ride {
public:
  PremiumRide(int id, const string &pickup, const string &dropoff, double miles)
      : Ride(id, pickup, dropoff, miles) {}

  double fare() const override {
    const double baseFare = 5.00;
    const double perMileRate = 2.75;

    return baseFare + (getDistance() * perMileRate);
  }

  string rideType() const override { return "Premium"; }
};

// ============================================================
// Driver Class
// Demonstrates encapsulation and object relationships.
// ============================================================

class Driver {
private:
  int driverID;
  string name;
  double rating;
  vector<shared_ptr<Ride>> assignedRides;

public:
  Driver(int id, const string &driverName, double driverRating)
      : driverID(id), name(driverName), rating(driverRating) {}

  void addRide(const shared_ptr<Ride> &ride) { assignedRides.push_back(ride); }

  string getDriverInfo() const {
    ostringstream output;

    output << fixed << setprecision(1);
    output << "Driver ID: " << driverID << " | Name: " << name
           << " | Rating: " << rating
           << " | Assigned Rides: " << assignedRides.size();

    return output.str();
  }
};

// ============================================================
// Rider Class
// Demonstrates encapsulation and object relationships.
// ============================================================

class Rider {
private:
  int riderID;
  string name;
  vector<shared_ptr<Ride>> requestedRides;

public:
  Rider(int id, const string &riderName) : riderID(id), name(riderName) {}

  void requestRide(const shared_ptr<Ride> &ride) {
    requestedRides.push_back(ride);
  }

  string getRiderInfo() const {
    ostringstream output;

    output << "Rider ID: " << riderID << " | Name: " << name
           << " | Requested Rides: " << requestedRides.size();

    return output.str();
  }

  void viewRides() const {
    for (const auto &ride : requestedRides) {
      cout << "  - " << ride->rideDetails() << '\n';
    }
  }
};

// ============================================================
// Main Program
// ============================================================

int main() {
  cout << "=== Ride Sharing System ===\n\n";

  // Create different types of rides.
  auto ride1 = make_shared<StandardRide>(101, "RTP", "Downtown Raleigh", 12.0);

  auto ride2 = make_shared<PremiumRide>(102, "Cary", "RDU Airport", 8.0);

  auto ride3 = make_shared<StandardRide>(103, "Morrisville",
                                         "Raleigh Union Station", 10.0);

  auto ride4 =
      make_shared<PremiumRide>(104, "Raleigh", "Research Triangle Park", 15.0);

  // Store different derived types in one collection.
  // This demonstrates runtime polymorphism.
  vector<shared_ptr<Ride>> rides = {ride1, ride2, ride3, ride4};

  cout << "Polymorphic Ride List:\n";

  for (const auto &ride : rides) {
    cout << ride->rideDetails() << '\n';
  }

  cout << '\n';

  // Create a driver and assign rides.
  Driver driver1(501, "Alex Johnson", 4.8);

  driver1.addRide(ride1);
  driver1.addRide(ride2);

  cout << "Driver Information:\n";
  cout << driver1.getDriverInfo() << "\n\n";

  // Create a rider and request rides.
  Rider rider1(301, "Sam Smith");

  rider1.requestRide(ride1);
  rider1.requestRide(ride3);

  cout << "Rider Information:\n";
  cout << rider1.getRiderInfo() << "\n\n";

  cout << "Rider Ride History:\n";
  rider1.viewRides();

  cout << "\nProgram completed successfully.\n";

  return 0;
}