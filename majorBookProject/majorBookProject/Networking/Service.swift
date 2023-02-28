//
//  Service.swift
//  majorBookProject
//
//  Created by 김민정 on 2023/02/24.
//

import Foundation
import UIKit
import Alamofire

class Service {
    
    static let header: HTTPHeaders = ["Content-Type": "application/json"]
    
    static func getSubjects(data:postSubject, completion: @escaping ()->Void) {
        
        var urlComponent = URLComponents(string:"https://book-service.inuappcenter.kr/subjects")!
        let departmentQuery = URLQueryItem(name: "department", value:data.department)
        let nameQuery = URLQueryItem(name:"name",value:data.name)
        let professorQuery = URLQueryItem(name: "professor", value: data.professor)
        urlComponent.queryItems?.append(departmentQuery)
        urlComponent.queryItems?.append(nameQuery)
        urlComponent.queryItems?.append(professorQuery)
        
        let request = AF.request(urlComponent,
                                     method: .get,
                                     parameters: data,
        headers: header)

        request.responseDecodable(of:[Subject].self) {
            dataResponse in

            switch dataResponse.result {

            case .success(let data):
                print("post 성공")
                print(data)
                completion()
            case .failure(let error):
                print("실패")
                print(error)
                completion()

            }
        }
        
    }
    
}
