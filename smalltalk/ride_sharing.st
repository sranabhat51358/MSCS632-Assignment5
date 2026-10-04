| createClass |

(Smalltalk hasClassNamed: #NonInteractiveTranscript)
    ifTrue: [ (Smalltalk at: #NonInteractiveTranscript) stdout install ].

createClass := [ :superClass :name :ivars :pkg |
    | builder slots |
    (superClass respondsTo: #<<)
        ifTrue: [
            builder := superClass << name.
            builder package: pkg.
            ivars ifNotEmpty: [
                slots := ivars collect: [ :each |
                    (each respondsTo: #asSlot) ifTrue: [ each asSlot ] ifFalse: [ each ]
                ].
                [ builder slots: slots ] on: Error do: [
                    [ builder slots: ivars ] on: Error do: [ ]
                ]
            ].
            (builder respondsTo: #install)
                ifTrue: [ builder install ]
                ifFalse: [ builder build ]
        ]
        ifFalse: [
            superClass
                subclass: name
                instanceVariableNames: (ivars joinUsing: ' ')
                classVariableNames: ''
                package: pkg
        ]
].

createClass value: Object value: #Ride value: #(rideID pickupLocation dropoffLocation distance) value: 'RideSharing'.
createClass value: (Smalltalk at: #Ride) value: #StandardRide value: #() value: 'RideSharing'.
createClass value: (Smalltalk at: #Ride) value: #PremiumRide value: #() value: 'RideSharing'.
createClass value: Object value: #Driver value: #(driverID name rating assignedRides) value: 'RideSharing'.
createClass value: Object value: #Rider value: #(riderID name requestedRides) value: 'RideSharing'.
createClass value: Object value: #RideSharingDemo value: #() value: 'RideSharing'.

(Smalltalk at: #Ride) compile: 'initializeID: id pickup: pickup dropoff: dropoff distance: rideDistance
    rideID := id.
    pickupLocation := pickup.
    dropoffLocation := dropoff.
    distance := rideDistance.'.

(Smalltalk at: #Ride) compile: 'rideID
    ^ rideID.'.

(Smalltalk at: #Ride) compile: 'distance
    ^ distance.'.

(Smalltalk at: #Ride) compile: 'fare
    self subclassResponsibility.'.

(Smalltalk at: #Ride) compile: 'rideType
    self subclassResponsibility.'.

(Smalltalk at: #Ride) compile: 'rideDetails
    ^ ''Ride ID: '', rideID asString,
      '' | Type: '', self rideType,
      '' | Pickup: '', pickupLocation,
      '' | Dropoff: '', dropoffLocation,
      '' | Distance: '', distance asString,
      '' miles | Fare: $'', self fare printString.'.

(Smalltalk at: #StandardRide) compile: 'fare
    | baseFare perMileRate |
    baseFare := 2.50.
    perMileRate := 1.50.
    ^ baseFare + (distance * perMileRate).'.

(Smalltalk at: #StandardRide) compile: 'rideType
    ^ ''Standard''.'.

(Smalltalk at: #PremiumRide) compile: 'fare
    | baseFare perMileRate |
    baseFare := 5.00.
    perMileRate := 2.75.
    ^ baseFare + (distance * perMileRate).'.

(Smalltalk at: #PremiumRide) compile: 'rideType
    ^ ''Premium''.'.

(Smalltalk at: #Driver) compile: 'initializeID: id name: driverName rating: driverRating
    driverID := id.
    name := driverName.
    rating := driverRating.
    assignedRides := OrderedCollection new.'.

(Smalltalk at: #Driver) compile: 'addRide: aRide
    assignedRides add: aRide.'.

(Smalltalk at: #Driver) compile: 'getDriverInfo
    ^ ''Driver ID: '', driverID asString,
      '' | Name: '', name,
      '' | Rating: '', rating printString,
      '' | Assigned Rides: '', assignedRides size asString.'.

(Smalltalk at: #Rider) compile: 'initializeID: id name: riderName
    riderID := id.
    name := riderName.
    requestedRides := OrderedCollection new.'.

(Smalltalk at: #Rider) compile: 'requestRide: aRide
    requestedRides add: aRide.'.

(Smalltalk at: #Rider) compile: 'getRiderInfo
    ^ ''Rider ID: '', riderID asString,
      '' | Name: '', name,
      '' | Requested Rides: '', requestedRides size asString.'.

(Smalltalk at: #Rider) compile: 'viewRides
    requestedRides do: [ :ride |
        Transcript show: ''  - ''; show: ride rideDetails; cr.
    ].'.

(Smalltalk at: #RideSharingDemo) class compile: 'run
    | rides driver rider print |
    print := [ :str |
        Transcript show: str; cr.
    ].

    print value: ''=== Ride Sharing System ===''.
    print value: ''''.

    rides := OrderedCollection new.
    rides add: ((Smalltalk at: #StandardRide) new
        initializeID: 101 pickup: ''RTP'' dropoff: ''Downtown Raleigh'' distance: 12.0).
    rides add: ((Smalltalk at: #PremiumRide) new
        initializeID: 102 pickup: ''Cary'' dropoff: ''RDU Airport'' distance: 8.0).
    rides add: ((Smalltalk at: #StandardRide) new
        initializeID: 103 pickup: ''Morrisville'' dropoff: ''Raleigh Union Station'' distance: 10.0).
    rides add: ((Smalltalk at: #PremiumRide) new
        initializeID: 104 pickup: ''Raleigh'' dropoff: ''Research Triangle Park'' distance: 15.0).

    print value: ''Polymorphic Ride List:''.
    rides do: [ :ride |
        print value: ride rideDetails
    ].
    print value: ''''.

    driver := (Smalltalk at: #Driver) new initializeID: 501 name: ''Alex Johnson'' rating: 4.8.
    driver addRide: rides first.
    driver addRide: rides second.

    print value: ''Driver Information:''.
    print value: driver getDriverInfo.
    print value: ''''.

    rider := (Smalltalk at: #Rider) new initializeID: 301 name: ''Sam Smith''.
    rider requestRide: rides first.
    rider requestRide: (rides at: 3).

    print value: ''Rider Information:''.
    print value: rider getRiderInfo.
    print value: ''''.

    print value: ''Rider Ride History:''.
    rider viewRides.
    print value: ''''.

    print value: ''Program completed successfully.''.
    Transcript flush.'.

(Smalltalk at: #RideSharingDemo) run.