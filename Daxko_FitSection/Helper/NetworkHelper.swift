//
//  NetworkHelper.swift
//  Daxko_FitSection
//
//  Created by Sajal Gupta on 15/11/2019.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//


//NetworkHelper
//import UIKit
//import Alamofire
//import SwiftyJSON
//
//class RequestRetryHandler: RequestRetrier {
//    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
//        let errorCode = (error as NSError).code
//        if (errorCode == -1005 || errorCode == -1004 || errorCode == -1202 || errorCode == -1200 || errorCode == 53 || errorCode == 100 || errorCode == 54) && request.retryCount == 0 {
//            completion(true, 0)
//        }
//        completion(false, 0)
//    }
//}
//
//class NetworkHelper {
//
//    typealias NetworkCompletitionHndler = (JSON?, Error?) -> ()
//
//    static let sessionManager: SessionManager = {
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = 120
//        let sessionManager = SessionManager(configuration: configuration)
//        sessionManager.retrier = RequestRetryHandler()
//        return sessionManager
//    }()
//
//    static func request(method: HTTPMethod, url: String, param: [String: Any], _ controller:UIViewController?, completionHandler: @escaping NetworkCompletitionHndler) {
//        let task = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
//        sessionManager.request(url, method : method, parameters : param,  encoding: JSONEncoding.default, headers: UserManager.headerItem).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                if json["statusCode"].stringValue != "2XX"{
//                    if json["statusCode"].stringValue == "401" {
//                        let error = NSError.init(domain: json["errorMessage"].stringValue, code: 401)
//                        completionHandler(nil,error)
//                        UserManager.logout(isDisable: false)
//                    }else if json["statusCode"].stringValue == "404" {
//                        let error = NSError.init(domain: json["errorMessage"].stringValue, code: 404)
//                        completionHandler(nil,error)
//                    }else if json["statusCode"].stringValue == "426" {
//                        let error = NSError.init(domain: json["errorMessage"].stringValue, code: 426)
//                        if let controller = controller{
//                            OtherHelper.buttonDialog("new_version_available", json["updateInfoText"].stringValue, controller, "Update", false, completionHandler: {
//                                UIApplication.shared.openURL(URL.init(string: AppConstant.appStoreUrl)!)
//                            })
//                        }
//                        completionHandler(nil,error)
//                    }else{
//                        if let controller = controller {
//                            OtherHelper.simpleDialog("Error", json["errorMessage"].stringValue, controller)
//                        }
//                        if json["statusCode"].stringValue == "5XX" {
//                            let error = NSError.init(domain: method.rawValue, code: 500, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                            completionHandler(nil,error)
//                        }else {
//                            let error = NSError.init(domain: method.rawValue, code: 400, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                            completionHandler(nil, error)
//                        }
//                    }
//                }else{
//                    handleHeader(headers: response.response?.allHeaderFields, controller: controller)
//                    completionHandler(json, nil)
//                }
//            case .failure(let error):
//                handleError(error: error, type: method.rawValue, param: param, url: url, response: response, completionHandler: completionHandler, controller: controller)
//            }
//            UIApplication.shared.endBackgroundTask(task)
//        }
//    }
//
//    static func post(url: String, param: [String: Any], _ controller:UIViewController?, completionHandler: @escaping NetworkCompletitionHndler) {
//        let task = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
//        sessionManager.request(url, method : .post, parameters : param,  encoding: JSONEncoding.default, headers: UserManager.headerItem).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                if json["statusCode"].stringValue != "2XX"{
//                    if json["statusCode"].stringValue == "401" {
//                        let error = NSError.init(domain: "POST", code: 401, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                        completionHandler(nil,error)
//                        UserManager.logout(isDisable: false)
//                    }else if json["statusCode"].stringValue == "404" {
//                        let error = NSError.init(domain: "POST", code: 404, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                        completionHandler(nil,error)
//                    }else if json["statusCode"].stringValue == "426" {
//                        let error = NSError.init(domain: "POST", code: 426, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                        if let controller = controller{
//                            OtherHelper.buttonDialog("new_version_available", json["updateInfoText"].stringValue, controller, "Update", false, completionHandler: {
//                                UIApplication.shared.openURL(URL.init(string: AppConstant.appStoreUrl)!)
//                            })
//                        }
//                        completionHandler(nil,error)
//                    }else{
//                        if let controller = controller {
//                            OtherHelper.simpleDialog("Error", json["errorMessage"].stringValue, controller)
//                        }
//                        if json["statusCode"].stringValue == "5XX" {
//                            let error = NSError.init(domain: "POST", code: 500, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                            completionHandler(nil,error)
//                        }else {
//                            let error = NSError.init(domain: "POST", code: 400, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                            completionHandler(nil, error)
//                        }
//                    }
//                }else{
//                    if url == Path.loginURL {
//                        if let authToken = response.response?.allHeaderFields[UserManager.authTokenKey] as? String {
//                            UserManager.setAuthToken(token: authToken)
//                        }else if let authToken = response.response?.allHeaderFields["x-auth"] as? String {
//                            UserManager.setAuthToken(token: authToken)
//                        }
//                        if let resource = response.response?.allHeaderFields[UserManager.resourceToken] as? String {
//                            UserManager.setResource(resource: resource)
//                        }else if let resource = response.response?.allHeaderFields["RESOURCE"] as? String {
//                            UserManager.setResource(resource: resource)
//                        }
//                    }
//                    handleHeader(headers: response.response?.allHeaderFields, controller: controller)
//                    completionHandler(json, nil)
//                }
//            case .failure(let error):
//                handleError(error: error, type: "POST", param: param, url: url, response: response, completionHandler: completionHandler, controller: controller)
//            }
//            UIApplication.shared.endBackgroundTask(task)
//        }
//    }
//
//
//    static func get(url: String, param: [String: Any], _ controller:UIViewController?, completionHandler: @escaping NetworkCompletitionHndler) {
//        let task = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
//        sessionManager.request(url, method : .get, parameters : param, headers: UserManager.headerItem).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                if json["statusCode"].stringValue != "2XX"{
//                    if json["statusCode"].stringValue == "401" {
//                        let error = NSError.init(domain: "GET", code: 401, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                        completionHandler(nil,error)
//                        UserManager.logout(isDisable: false)
//                    }else if json["statusCode"].stringValue == "404" {
//                        let error = NSError.init(domain: "GET", code: 404, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                        completionHandler(nil,error)
//                    }else if json["statusCode"].stringValue == "426" {
//                        let error = NSError.init(domain: "GET", code: 426, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                        if let controller = controller{
//                            OtherHelper.buttonDialog("new_version_available", json["updateInfoText"].stringValue, controller, "Update", false, completionHandler: {
//                                UIApplication.shared.openURL(URL.init(string: AppConstant.appStoreUrl)!)
//                            })
//                        }
//                        completionHandler(nil,error)
//                    }else {
//                        if let controller = controller {
//                            OtherHelper.simpleDialog("Error", json["errorMessage"].stringValue, controller)
//                        }
//                        if json["statusCode"].stringValue == "5XX" {
//                            let error = NSError.init(domain: "GET", code: 500, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                            completionHandler(nil,error)
//                        }else {
//                            let error = NSError.init(domain: "GET", code: 400, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                            completionHandler(nil, error)
//                        }
//                    }
//                }else{
//                    handleHeader(headers: response.response?.allHeaderFields, controller: controller)
//                    completionHandler(json, nil)
//                }
//            case .failure(let error):
//                handleError(error: error, type: "GET", param: param, url: url, response: response, completionHandler: completionHandler, controller: controller)
//            }
//            UIApplication.shared.endBackgroundTask(task)
//        }
//    }
//
//    static func put(url: String, param: [String: Any], _ controller:UIViewController?, completionHandler: @escaping NetworkCompletitionHndler) {
//        let task = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
//        sessionManager.request(url, method : .put, parameters : param,  encoding: JSONEncoding.default, headers: UserManager.headerItem).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                if json["statusCode"].stringValue != "2XX"{
//                    if json["statusCode"].stringValue == "401" {
//                        let error = NSError.init(domain: "PUT", code: 401, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                        completionHandler(nil,error)
//                        UserManager.logout(isDisable: false)
//                    }else if json["statusCode"].stringValue == "404" {
//                        let error = NSError.init(domain: "PUT", code: 404, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                        completionHandler(nil,error)
//                    }else if json["statusCode"].stringValue == "426" {
//                        let error = NSError.init(domain: "PUT", code: 426, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                        if let controller = controller{
//                            OtherHelper.buttonDialog("new_version_available", json["updateInfoText"].stringValue, controller, "Update", false, completionHandler: {
//                                UIApplication.shared.openURL(URL.init(string: AppConstant.appStoreUrl)!)
//                            })
//                        }
//                        completionHandler(nil,error)
//                    }else{
//                        if let controller = controller {
//                            OtherHelper.simpleDialog("Error", json["errorMessage"].stringValue, controller)
//                        }
//                        if json["statusCode"].stringValue == "5XX" {
//                            let error = NSError.init(domain: "PUT", code: 500, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                            completionHandler(nil,error)
//                        }else {
//                            let error = NSError.init(domain: "PUT", code: 400, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                            completionHandler(nil, error)
//                        }
//                    }
//                }else{
//                    handleHeader(headers: response.response?.allHeaderFields, controller: controller)
//                    completionHandler(json, nil)
//                }
//            case .failure(let error):
//                handleError(error: error, type: "PUT", param: param, url: url, response: response, completionHandler: completionHandler, controller: controller)
//            }
//            UIApplication.shared.endBackgroundTask(task)
//        }
//    }
//
//    static func patch(url: String, param: [String: Any], _ controller:UIViewController?, completionHandler: @escaping NetworkCompletitionHndler) {
//        let task = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
//        sessionManager.request(url, method : .patch, parameters : param,  encoding: JSONEncoding.default, headers: UserManager.headerItem).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                if json["statusCode"].stringValue != "2XX"{
//                    if json["statusCode"].stringValue == "401" {
//                        let error = NSError.init(domain: "PATCH", code: 401, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                        completionHandler(nil,error)
//                        UserManager.logout(isDisable: false)
//                    }else if json["statusCode"].stringValue == "404" {
//                        let error = NSError.init(domain: "PATCH", code: 404, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                        completionHandler(nil,error)
//                    }else if json["statusCode"].stringValue == "426" {
//                        let error = NSError.init(domain: "PATCH", code: 426, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                        if let controller = controller{
//                            OtherHelper.buttonDialog("new_version_available", json["updateInfoText"].stringValue, controller, "Update", false, completionHandler: {
//                                UIApplication.shared.openURL(URL.init(string: AppConstant.appStoreUrl)!)
//                            })
//                        }
//                        completionHandler(nil,error)
//                    }else{
//                        if let controller = controller {
//                            OtherHelper.simpleDialog("Error", json["errorMessage"].stringValue, controller)
//                        }
//                        if json["statusCode"].stringValue == "5XX" {
//                            let error = NSError.init(domain: "PATCH", code: 500, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                            completionHandler(nil,error)
//                        }else {
//                            let error = NSError.init(domain: "PATCH", code: 400, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                            completionHandler(nil, error)
//                        }
//                    }
//                }else{
//                    handleHeader(headers: response.response?.allHeaderFields, controller: controller)
//                    completionHandler(json, nil)
//                }
//            case .failure(let error):
//                handleError(error: error, type: "PATCH", param: param, url: url, response: response, completionHandler: completionHandler, controller: controller)
//            }
//            UIApplication.shared.endBackgroundTask(task)
//        }
//    }
//
//    static func delete(url: String, param: [String: Any], _ controller:UIViewController?, completionHandler: @escaping NetworkCompletitionHndler) {
//        let task = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
//        sessionManager.request(url, method : .delete, parameters : param, headers: UserManager.headerItem).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                if json["statusCode"].stringValue != "2XX"{
//                    if json["statusCode"].stringValue == "401" {
//                        let error = NSError.init(domain: "DELETE", code: 401, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                        completionHandler(nil,error)
//                        UserManager.logout(isDisable: false)
//                    }else if json["statusCode"].stringValue == "404" {
//                        let error = NSError.init(domain: "DELETE", code: 404, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                        completionHandler(nil,error)
//                    }else if json["statusCode"].stringValue == "426" {
//                        let error = NSError.init(domain: "DELETE", code: 426, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                        if let controller = controller{
//                            OtherHelper.buttonDialog("new_version_available", json["updateInfoText"].stringValue, controller, "Update", false, completionHandler: {
//                                UIApplication.shared.openURL(URL.init(string: AppConstant.appStoreUrl)!)
//                            })
//                        }
//                        completionHandler(nil,error)
//                    }else{
//                        if let controller = controller {
//                            OtherHelper.simpleDialog("Error", json["errorMessage"].stringValue, controller)
//                        }
//                        if json["statusCode"].stringValue == "5XX" {
//                            let error = NSError.init(domain: "DELETE", code: 500, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                            completionHandler(nil,error)
//                        }else {
//                            let error = NSError.init(domain: "DELETE", code: 400, userInfo: [NSLocalizedDescriptionKey: json["errorMessage"].stringValue])
//                            completionHandler(nil, error)
//                        }
//                    }
//                }else{
//                    handleHeader(headers: response.response?.allHeaderFields, controller: controller)
//                    completionHandler(json, nil)
//                }
//            case .failure(let error):
//                handleError(error: error, type: "DELETE", param: param, url: url, response: response, completionHandler: completionHandler, controller: controller)
//            }
//            UIApplication.shared.endBackgroundTask(task)
//        }
//    }
//
//    //    static func upload(url: String, param: [String: Any], _ controller:UIViewController?, _ media: Any, completionHandler: @escaping (JSON?, Error?) -> ()) {
//    //        var json: JSON!
//    //        var headers:[String:String] = [:]
//    //        headers[UserManager.authTokenKey] = UserManager.getAuthToken()
//    //        headers["appVersion"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
//    //        Alamofire.request(url, method : .post, parameters : param,  encoding: JSONEncoding.default, headers: headers).responseJSON { response in
//    //            switch response.result {
//    //            case .success(let value):
//    //                json = JSON(value)
//    //                if json["statusCode"].stringValue != "2XX"{
//    //                    if json["statusCode"].stringValue == "401" {
//    //                        let error = NSError.init(domain: json["errorMessage"].stringValue, code: 401)
//    //                        completionHandler(nil,error)
//    //                        UserManager.logout(isDisable: false)
//    //                    }else if json["statusCode"].stringValue == "404" {
//    //                        let error = NSError.init(domain: json["errorMessage"].stringValue, code: 404)
//    //                        completionHandler(nil,error)
//    //                    }else if json["statusCode"].stringValue == "426" {
//    //                        let error = NSError.init(domain: json["errorMessage"].stringValue, code: 426)
//    //                            if let controller = controller{
//    //                                OtherHelper.buttonDialog("new_version_available", json["updateInfoText"].stringValue, controller, "Update", false, completionHandler: {
//    //                                    UIApplication.shared.openURL(URL.init(string: AppConstant.appStoreUrl)!)
//    //                                })
//    //                            }
//    //                        completionHandler(nil,error)
//    //                        }else{
//    //                        if let controller = controller {
//    //                            OtherHelper.simpleDialog("Error", json["errorMessage"].stringValue, controller)
//    //                        }
//    //                    if json["statusCode"].stringValue == "4XX"{
//    //                        let error = NSError.init(domain: json["errorMessage"].stringValue, code: 400)
//    //                        completionHandler(nil,error)
//    //                    }else{
//    //                        let error = NSError.init(domain: json["errorMessage"].stringValue, code: 500)
//    //                        completionHandler(nil,error)
//    //                    }
//    //                    }
//    //                }else{
//    //                    if let updateInfoText = response.response?.allHeaderFields["updateInfoText"] as? String {
//    //                        if let controller = controller{
//    //                            OtherHelper.buttonDialog("new_version_available", updateInfoText, controller, "Update", true, completionHandler: {
//    //                                UIApplication.shared.openURL(URL.init(string: AppConstant.appStoreUrl)!)
//    //                            })
//    //                        }
//    //                    }
//    //                    completionHandler(json, nil)
//    //                }
//    //            case .failure(let error):
//    //                if let controller = controller {
//    //                    OtherHelper.simpleDialog("Network_Error", error.localizedDescription, controller)
//    //                }
//    //                completionHandler(nil, error)
//    //            }
//    //        }
//    //    }
//
//    static func stopAllSessions() {
//        sessionManager.session.getAllTasks { tasks in
//            tasks.forEach { if $0.originalRequest?.url?.lastPathComponent == "typeahed" || $0.originalRequest?.url?.lastPathComponent == "myRelative" || $0.originalRequest?.url?.lastPathComponent == "search-media-inboards" { $0.cancel() }}
//        }
//    }
//
//    static func handleError(error: Error, type: String, param: [String: Any], url: String, response: DataResponse<Any>, completionHandler: NetworkCompletitionHndler, controller:UIViewController?) {
//        func logError(showError: Bool) {
//            if showError {
//                showErrorDialog(errorMessage: error.localizedDescription)
//            }
//        }
//
//        func showErrorDialog(errorMessage: String) {
//            if let controller = controller {
//                OtherHelper.simpleDialog("Network_Error", errorMessage, controller)
//            }
//        }
//
//        let errorToSend: Error
//        switch (error as NSError).code {
//        case -999:
//            errorToSend = error
//            break
//        case -1009:
//            errorToSend = error
//            showErrorDialog(errorMessage: error.localizedDescription)
//        case 4:
//            if let data = response.data, let originalResponse = String.init(data: data, encoding: .utf8), !originalResponse.contains(" bill") && !originalResponse.contains(" payment") && !originalResponse.contains(" internet") {
//                logError(showError: false)
//                showErrorDialog(errorMessage: "Something went wrong. Check your connection and try again.")
//                errorToSend = NSError(domain: (error as NSError).domain, code: 4, userInfo: [NSLocalizedDescriptionKey: "Something went wrong. Check your connection and try again."])
//            }else {
//                showErrorDialog(errorMessage: "Something went wrong. Check your connection and try again!")
//                errorToSend = NSError(domain: (error as NSError).domain, code: 4, userInfo: [NSLocalizedDescriptionKey: "Something went wrong. Check your connection and try again!"])
//            }
//        default:
//            errorToSend = error
//            logError(showError: true)
//        }
//        completionHandler(nil, errorToSend)
//    }
//
//    static func handleHeader(headers: [AnyHashable: Any]?, controller: UIViewController?) {
//        func showError(updateInfoText: String) {
//            if let controller = controller{
//                OtherHelper.buttonDialog("new_version_available", updateInfoText, controller, "Update", true, completionHandler: {
//                    UIApplication.shared.openURL(URL.init(string: AppConstant.appStoreUrl)!)
//                })
//            }
//        }
//        if let updateInfoText = headers?["updateInfoText"] as? String {
//            showError(updateInfoText: updateInfoText)
//        }else if let updateInfoText = headers?["updateinfotext"] as? String {
//            showError(updateInfoText: updateInfoText)
//        }
//    }
//
//    static func request<T: Decodable>(method: HTTPMethod, url: String, param: [String: Any], parameterEncoding: ParameterEncoding? = nil, responseType: T.Type, _ controller:UIViewController?, completionHandler: @escaping (Swift.Result<T, Error>) -> ()) {
//        let task = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
//        let encoding: ParameterEncoding
//        if let parameterEncoding = parameterEncoding { encoding = parameterEncoding }
//        else {
//            if method == .patch || method == .put || method == .post { encoding = JSONEncoding.default }
//            else { encoding = URLEncoding.default }
//        }
//        func handleError(error: Error, response: DataResponse<Data>) {
//            func logError(showError: Bool) {
//                if showError {
//                    showErrorDialog(errorMessage: error.localizedDescription)
//                }
//            }
//            func showErrorDialog(errorMessage: String) {
//                if let controller = controller {
//                    OtherHelper.simpleDialog("Network_Error", errorMessage, controller)
//                }
//            }
//            let errorToSend: Error
//            switch (error as NSError).code {
//            case -999:
//                errorToSend = error
//                break
//            case -1009:
//                errorToSend = error
//                showErrorDialog(errorMessage: error.localizedDescription)
//            case 4, NSFormattingError:
//                let errorMessage: String
//                if let data = response.data, let originalResponse = String.init(data: data, encoding: .utf8), !originalResponse.contains(" bill") && !originalResponse.contains(" payment") && !originalResponse.contains(" internet") {
//                    logError(showError: false)
//                    errorMessage = "Something went wrong. Check your connection and try again."
//                }else {
//                    errorMessage = "Something went wrong. Check your connection and try again!"
//                }
//                showErrorDialog(errorMessage:errorMessage)
//                errorToSend = NSError(domain: (error as NSError).domain, code: 4, userInfo: [NSLocalizedDescriptionKey: errorMessage])
//            default:
//                errorToSend = error
//                logError(showError: true)
//            }
//            completionHandler(.failure(errorToSend))
//        }
//        sessionManager.request(url, method : method, parameters : param, encoding: encoding, headers: UserManager.headerItem).responseData { response in
//            switch response.result {
//            case .success(let value):
//                do {
//                    let model = try JSONDecoder().decode(APIResponse<T>.self, from: value)
//                    if model.statusCode != "2XX"{
//                        let errorMessage = model.errorMessage ?? ""
//                        if model.statusCode == "401" {
//                            let error = NSError(domain: method.rawValue, code: 401, userInfo: [NSLocalizedDescriptionKey: errorMessage])
//                            completionHandler(.failure(error))
//                            UserManager.logout(isDisable: false)
//                        }else if model.statusCode == "404" {
//                            let error = NSError(domain: method.rawValue, code: 404, userInfo: [NSLocalizedDescriptionKey: errorMessage])
//                            completionHandler(.failure(error))
//                        }else if model.statusCode == "426" {
//                            let error = NSError(domain: method.rawValue, code: 426, userInfo: [NSLocalizedDescriptionKey: errorMessage])
//                            if let controller = controller{
//                                OtherHelper.buttonDialog("new_version_available", model.updateInfoText ?? "", controller, "Update", false, completionHandler: {
//                                    UIApplication.shared.openURL(URL.init(string: AppConstant.appStoreUrl)!)
//                                })
//                            }
//                            completionHandler(.failure(error))
//                        }else {
//                            if let controller = controller {
//                                OtherHelper.simpleDialog("Error", errorMessage, controller)
//                            }
//                            if model.statusCode == "5XX" {
//                                let error = NSError.init(domain: method.rawValue, code: 500, userInfo: [NSLocalizedDescriptionKey: errorMessage])
//                                completionHandler(.failure(error))
//                            }else {
//                                let error = NSError.init(domain: method.rawValue, code: 400, userInfo: [NSLocalizedDescriptionKey: errorMessage])
//                                completionHandler(.failure(error))
//                            }
//                        }
//                    }else {
//                        handleHeader(headers: response.response?.allHeaderFields, controller: controller)
//                        if let data = model.data { completionHandler(.success(data)) }
//                        else { handleError(error: NSError(domain: "No Data", code: NSFormattingError), response: response) }
//                    }
//                }catch let error {
//                    handleError(error: error, response: response)
//                }
//            case .failure(let error):
//                handleError(error: error, response: response)
//            }
//            UIApplication.shared.endBackgroundTask(task)
//        }
//    }
//}
//
//
