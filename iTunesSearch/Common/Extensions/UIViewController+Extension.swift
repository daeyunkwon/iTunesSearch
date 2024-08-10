//
//  UIViewController+Extension.swift
//  iTunesSearch
//
//  Created by 권대윤 on 8/10/24.
//

import UIKit

extension UIViewController {
    
    func showNetworkResponseFailAlert(errorType: iTunesAPIError) {
        var message: String
        
        switch errorType {
        case .notConnectedInternet:
            message = "네트워크에 연결되어 있지 않습니다. 연결 상태를 확인해주세요."
            
        case .invalidURL, .unknownRespose, .noData, .decodingError:
            message = "검색 결과를 불러오는데 실패하였습니다. 네트워크 연결 상태를 확인 후 다시 시도해 주세요."
            
        case .statusError(let codeNumber):
            switch codeNumber {
            case 400...499:
                message = "서버에 잘못된 요청으로 인해 검색 결과를 불러오는데 실패하였습니다. 네트워크 연결 상태를 확인 후 다시 시도해 주세요."
            case 500...:
                message = "서버에 문제가 발생하여 검색 결과를 불러오는데 실패하였습니다. 문제가 계속 될 경우 관리자에게 문의해주세요."
            default:
                message = "검색 결과를 불러오는데 실패하였습니다. 네트워크 연결 상태를 확인 후 다시 시도해 주세요."
            }
        }
        
        let alert = UIAlertController(title: "시스템 알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
