//: Playground - noun: a place where people can play

import Foundation

let sampleDataAddress = "https://jsonplaceholder.typicode.com/users"
let url = URL(string: sampleDataAddress)!
let jsonData = try! Data(contentsOf: url)

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Company
    
    struct Address: Codable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: Coordinates
        
        struct Coordinates: Codable {
            let lat: Double
            let lng: Double
            
            init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                let latString = try values.decode(String.self, forKey: .lat)
                let lngString = try values.decode(String.self, forKey: .lng)
                lat = Double(latString) ?? 0
                lng = Double(lngString) ?? 0
            }
        }
    }
    
    struct Company: Codable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
}

let jsonDecoder = JSONDecoder()
var users = [User]()
do {
    let users = try jsonDecoder.decode([User].self,
                                       from: jsonData)
    
    //users.count
    //dump(users.first)
    
    //print(users.first!.username)
    //print(users.first!.company)
    
    //let names = users[0].address
    //print(names)
    for eachId in users{
        if eachId.id == 2{
            print(eachId.name)
        }
    }
    
    for eachAddress in users{
        print(eachAddress.address)
    }

    
}
catch {
    print(error)
}
