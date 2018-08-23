import Foundation

struct Result: Codable {
    let data: Weather?
    let error: String?
}

struct Weather: Codable {
    let weather: Int

    var type: WeatherType? {
        return WeatherType(rawValue: self.weather)
    }
}
