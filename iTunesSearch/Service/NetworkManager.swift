//
//  NetworkManager.swift
//  iTunesSearch
//
//  Created by 권대윤 on 8/10/24.
//

import Foundation

import RxSwift

//MARK: - iTunesAPIError

enum iTunesAPIError: Error {
    case notConnectedInternet
    case invalidURL
    case unknownRespose
    case statusError(codeNumber: Int)
    case noData
    case decodingError
}

extension iTunesAPIError {
    var errorDescription: String {
        switch self {
        case .notConnectedInternet:
            return "Error: 인터넷 연결 안됨"
        case .invalidURL:
            return "Error: 유효하지 않은 URL"
        case .unknownRespose:
            return "Error: 알 수 없는 응답"
        case .statusError(let codeNumber):
            return "Error: 응답 실패 상태코드:\(codeNumber)"
        case .noData:
            return "Error: 데이터 없음"
        case .decodingError:
            return "Error: 데이터 디코딩 실패"
        }
    }
}

//MARK: - NetworkManager

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() { }
    
    
    func fetchSoftwareData(searchKeyword: String) -> Observable<SoftwareResult> {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchKeyword)&country=KR&entity=software"
        
        let result = Observable<SoftwareResult>.create { observer in
            
            guard let url = URL(string: urlString) else {
                observer.onError(iTunesAPIError.invalidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    if (error! as NSError).code == NSURLErrorNotConnectedToInternet {
                        observer.onError(iTunesAPIError.notConnectedInternet)
                        return
                    }
                    observer.onError(iTunesAPIError.unknownRespose)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    let response = response as? HTTPURLResponse
                    observer.onError(iTunesAPIError.statusError(codeNumber: response?.statusCode ?? 0))
                    return
                }
                
                guard let safeData = data else {
                    observer.onError(iTunesAPIError.noData)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(SoftwareResult.self, from: safeData)
                    observer.onNext(result)
                    observer.onCompleted()
                } catch {
                    observer.onError(iTunesAPIError.decodingError)
                }
            }.resume()
            return Disposables.create()
        }
        return result
    }
}
