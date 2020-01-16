import UIKit


//: ## 1. Create custom types to represent an Airport Departures display
//: ![Airport Departures](matthew-smith-5934-unsplash.jpg)
//: Look at data from [Departures at JFK Airport in NYC](https://www.airport-jfk.com/departures.php) for reference.
//:
//: a. Use an `enum` type for the FlightStatus (En Route, Scheduled, Canceled, Delayed, etc.)
//:
//: b. Use a struct to represent an `Airport` (Destination or Arrival)
//:
//: c. Use a struct to represent a `Flight`.
//:
//: d. Use a `Date?` for the departure time since it may be canceled.
//:
//: e. Use a `String?` for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time)
//:
//: f. Use a class to represent a `DepartureBoard` with a list of departure flights, and the current airport
typealias SquareFeet = Int
let code = Int.random(in: 1000 ... 9999)


//3c
enum FlightStatus : String {
    case enRoute = "enRoute"
    case scheduled = "scheduled"
    case delayed = "delayed"
    case cancelled = "cancelled"
}

enum Zone {
    case destination
    case arrival
}

struct Flight {
    var flightCode = code
    var departureTime: String?
    var arrivalTime: String
    var terminal: String?
    var status : FlightStatus
    var destination: String
}



struct Airport {
    var name: String
    var address: String
    var zone : Zone
    var numberOfGates: Int
    var area : SquareFeet
}
class DepartureBoard {
    
    var flights : [Flight]
    var airport : Airport
    
    init(flights: [Flight],airport: Airport) {
        self.flights = flights
        self.airport = airport
    }
    
    
}


//: ## 2. Create 3 flights and add them to a departure board
//: a. For the departure time, use `Date()` for the current time
//:
//: b. Use the Array `append()` method to add `Flight`'s
//:
//: c. Make one of the flights `.canceled` with a `nil` departure time
//:
//: d. Make one of the flights have a `nil` terminal because it has not been decided yet.
//:
//: e. Stretch: Look at the API for [`DateComponents`](https://developer.apple.com/documentation/foundation/datecomponents?language=objc) for creating a specific time
let randomMonth = Int.random(in: 1...12)
let randomDate = Int.random(in: 1...31)

// DateComponents API
//:   Date Components API

// Date Components API

let calendar = Calendar(identifier: .gregorian)
guard let arrivalTime1 = calendar.date(from: DateComponents(year: 2020, month: randomMonth, day: randomDate,hour: Int.random(in: 0...24),minute:Int.random(in: 0...60) )) else { fatalError("Airplane is lost !")  }

guard let arrivalTime2 = calendar.date(from: DateComponents(year: 2020, month: randomMonth, day: randomDate,hour: Int.random(in: 0...24),minute:Int.random(in: 0...60) )) else { fatalError("Airplane is lost !")  }

guard let arrivalTime3 = calendar.date(from: DateComponents(year: 2020, month: randomMonth, day: randomDate,hour: Int.random(in: 0...24),minute:Int.random(in: 0...60))) else { fatalError("Airplane is lost !")  }

 let currentDate = Date()

//Date Formatter

let formatter = DateFormatter()
formatter.dateFormat = "hh:mm"

let timeString1 = formatter.string(from: arrivalTime1)
let timeString2 = formatter.string(from: arrivalTime2)
let timeString3 = formatter.string(from: arrivalTime3)





var flight1 = Flight(flightCode: code, departureTime: "\(currentDate )" , arrivalTime: timeString1 , terminal: "A"  , status: .scheduled,destination: "London" )

var flight2 = Flight(flightCode: code, departureTime: "\(currentDate)", arrivalTime: timeString2 , terminal: nil, status: .enRoute,destination: "San Francisco"  )
var flight3 = Flight(flightCode: code, departureTime: nil, arrivalTime: timeString3, terminal: "C"   , status: .cancelled,destination: "Boston" )



var flights = [Flight]()
flights.append(flight1)
flights.append(flight2)
flights.append(flight3)


let currentAirport = Airport(name: "JFK", address: "1 Hacker Way", zone: .destination, numberOfGates: 350, area: 80000)
let departureBoard = DepartureBoard(flights: flights, airport:currentAirport )

//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function

//3a & 3b & 4a,4b,4c
func  printDepartures(_ departureBoard: DepartureBoard) {
    for flight in departureBoard.flights {
       print(flight.status.rawValue)
     
        var firstString = ""
        var secondString = ""
        
        if let newTime = flight.departureTime  {
            firstString = newTime
        }
        if let newTerminal = flight.terminal {
            secondString = newTerminal
        }
        print("Destination:\(flight.destination), flight number: \(flight.flightCode)  Departure Time:  \(firstString), Status: \(flight.status), Terminal: \(secondString)")
 
    }
     
    }

//3d
printDepartures(departureBoard)


//: ## 4. Make a second function to print print an empty string if the `departureTime` is nil
//: a. Createa new `printDepartures2(departureBoard:)` or modify the previous function
//:
//: b. Use optional binding to unwrap any optional values, use string interpolation to turn a non-optional date into a String
//:
//: c. Call the new or udpated function. It should not print `Optional(2019-05-30 17:09:20 +0000)` for departureTime or for the Terminal.
//:
//: d. Stretch: Format the time string so it displays only the time using a [`DateFormatter`](https://developer.apple.com/documentation/foundation/dateformatter) look at the `dateStyle` (none), `timeStyle` (short) and the `string(from:)` method
//:
//: e. Your output should look like:
//:
//:     Destination: Los Angeles Airline: Delta Air Lines Flight: KL 6966 Departure Time:  Terminal: 4 Status: Canceled
//:     Destination: Rochester Airline: Jet Blue Airways Flight: B6 586 Departure Time: 1:26 PM Terminal:  Status: Scheduled
//:     Destination: Boston Airline: KLM Flight: KL 6966 Departure Time: 1:26 PM Terminal: 4 Status: Scheduled
// Above


//: ## 5. Add an instance method to your `DepatureBoard` class (above) that can send an alert message to all passengers about their upcoming flight. Loop through the flights and use a `switch` on the flight status variable.
//: a. If the flight is canceled print out: "We're sorry your flight to \(city) was canceled, here is a $500 voucher"
//:
//: b. If the flight is scheduled print out: "Your flight to \(city) is scheduled to depart at \(time) from terminal: \(terminal)"
//:
//: c. If their flight is boarding print out: "Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon."
//:
//: d. If the `departureTime` or `terminal` are optional, use "TBD" instead of a blank String
//:
//: e. If you have any other cases to handle please print out appropriate messages
//:
//: d. Call the `alertPassengers()` function on your `DepartureBoard` object below
//:
//: f. Stretch: Display a custom message if the `terminal` is `nil`, tell the traveler to see the nearest information desk for more details.
extension DepartureBoard {
    func sendAlert() {
        for flight in flights {
            if flight.terminal != nil {
                switch flight.status {
                case .cancelled:
                    print("We're sorry your flight to \(flight.destination) was canceled, here is a $500 voucher")
                case .scheduled:
                    guard let newTime = flight.departureTime  else { return  }
                    print("Your flight to \(flight.destination) is scheduled to depart at \(newTime)) from terminal: \(flight.terminal ?? "TBD")")
                case .enRoute:
                    print("Your flight is boarding, please head to terminal: \(flight.terminal ?? "TBD") immediately. The doors are closing soon.")
                case .delayed:
                    print("Your flight is delayed, please head to terminal : \(flight.terminal ?? "TBD") and wait one hour.Sorry for the inconvenience.")
                }
            }
            else {
                print("Here is there custom message for you : ...")
            }
        }
    }
}
departureBoard.sendAlert()


//: ## 6. Create a free-standing function to calculate your total airfair for checked bags and destination
//: Use the method signature, and return the airfare as a `Double`
//:
//:     func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
//:     }
//:
//: a. Each bag costs $25
//:
//: b. Each mile costs $0.10
//:
//: c. Multiply the ticket cost by the number of travelers
//:
//: d. Call the function with a variety of inputs (2 bags, 2000 miles, 3 travelers = $750)
//:
//: e. Make sure to cast the numbers to the appropriate types so you calculate the correct airfare
//:
//: f. Stretch: Use a [`NumberFormatter`](https://developer.apple.com/documentation/foundation/numberformatter) with the `currencyStyle` to format the amount in US dollars.
let currencyFormatter = NumberFormatter()

func calculateAirfare(checkedBags: Int,distance: Int, travelers: Int) -> String {
   
    let priceForBags = checkedBags * 25
    let priceForDistance = Double(distance) * 0.10
    let totalPrices = (Double(priceForBags) + priceForDistance) * Double(travelers)
    
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = Locale.current
    
    guard  let priceUSD = currencyFormatter.string(from: NSNumber(value:totalPrices)) else { fatalError() }
    print(priceUSD)
    return priceUSD
    
}


calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)
calculateAirfare(checkedBags: 3, distance: 1000, travelers: 2)
calculateAirfare(checkedBags: 4, distance: 3000, travelers: 5)


