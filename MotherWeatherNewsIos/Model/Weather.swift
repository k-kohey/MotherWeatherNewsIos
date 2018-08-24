import Foundation

struct Result: Codable {
    let data: Weather?
    let error: String?
}

struct Weather: Codable {
    let weather: Int
    let temperature: Int
    let weather_rates: [Int]
    let condition: String
    let advice: String

    var type: WeatherType? {
        return WeatherType(rawValue: self.weather)
    }
}
