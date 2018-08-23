import Foundation
import Alamofire
import RxSwift

enum EndPoint: String {
    case weather = "weather"

    func url() -> String {
        return "https://motherweathernews.mybluemix.net/api/v1/\(self.rawValue)"
    }
}

class API {
    static func request(to endpoint: EndPoint,
                                   method: HTTPMethod = .get,
                                   parameters: Parameters? = nil,
                                   encoding: ParameterEncoding = JSONEncoding.default) -> Single<Result> {
        return Single.create { singleEvent in
            let request = Alamofire.request(endpoint.url(),
                                            method: method,
                                            parameters: parameters,
                                            encoding: encoding)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        print("\(String(data: response.data!, encoding: .utf8))")
                        guard let json = response.data else {return}
                        let result = self.decode(to: json)
                        singleEvent(.success(result!))
                    case .failure(let error):
                        print(error)
                        singleEvent(.error(error))
                    }
            }
            return Disposables.create { request.cancel() }
        }
    }

    private static func decode(to json: Data) -> Result?{
        do {
            return try JSONDecoder().decode(Result.self, from: json)
        } catch {
            print(error)
            return nil
        }
    }
}
