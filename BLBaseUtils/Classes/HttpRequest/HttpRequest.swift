//
//  HttpRequest.swift
//  AiBeLove
//
//  Created by blyx on 2020/7/11.
//  Copyright © 2020 重庆彼恋有喜婚姻服务有限公司. All rights reserved.
//

import Foundation
import Alamofire

public enum MethodType {
    case get
    case post
}

public let ABLRespStatus_Success: Int = 200//成功
public let ABLRespStatus_NoMakeFriend: Int = 201//登录成功，没有开通交友
public let ABLRespStatus_NewUser: Int = 203//验证码登录， 成功，没有注册过，需要去注册页面完善信息
//let ABLRespStatus_WechatPay: Int = 202//请求成功,微信支付
public let ABLRespStatus_Error: Int = 500//失败

public let ABLRespKey_Code: String = "code"
public let ABLRespKey_Data: String = "data"
public let ABLRespKey_Msg: String = "msg"

public enum NetworkStatus: Int32 {
    case unknown          = -1//未知网络
    case notReachable     = 0//网络无连接
    case cellular         = 1//2，3，4G网络
    case wifi             = 2//wifi网络
}

public typealias ABLResponseBool = (_ response: Bool) -> Void
public typealias ABLResponseSuccess = (_ response: Data) -> Void
public typealias ABLResponseFailure = (_ error: String) -> Void
public typealias ABLNetworkStatus = (_ NetworkStatus: Int32) -> Void
public typealias ABLProgressBlock = (_ progress: Int64) -> Void

public class HttpRequest {
    //单例
    public class var share : HttpRequest {
        get {
            return HttpRequest()
        }
    }
    private var sessionManager: Session?
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        sessionManager = Session.init(configuration: configuration, delegate: SessionDelegate.init(), serverTrustManager: nil)
    }
    
    
    
    ///当前网络状态
    public var mNetworkStatus: NetworkStatus = NetworkStatus.wifi
    
    public func getWith(url: String,
                        params: [String: Any]?,
                        success: @escaping ABLResponseSuccess,
                        error: @escaping ABLResponseFailure) {
        
        
        manageGet(url: url, params: params, success: success, error: error)
    }
    
    private func manageGet(url: String,
                           params: [String: Any]?,
                           success: @escaping ABLResponseSuccess,
                           error: @escaping ABLResponseFailure) {
        
        do {
            
            
            let req = try URLRequest(url: url, method: .get)
            let request = try URLEncoding().encode(req , with: params)
            
            AF.request(request).responseJSON { (response) in
                switch response.result {
                case .success:
                    success(response.data!)
                case .failure:
                    error("请求失败")
                    debugPrint(response.response as Any)
                }
            }
        } catch _ as Error? {
            error("构建请求失败")
        }
        
//        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in
//                    switch response.result {
//                    case .success:
//                        success(response.data!)
//                    case .failure:
//                        error("请求失败")
//                        debugPrint(response.response as Any)
//                    }
//        }
    }
    
    public func postWith(url: String,
                         params: [String: Any]?,
                         success: @escaping ABLResponseSuccess,
                         error: @escaping ABLResponseFailure) {
        
        managePost(url: url, params: params, success: success, error: error)
    }
    
    private func managePost(url: String,
                            params: [String: Any]?,
                            success: @escaping ABLResponseSuccess,
                            error: @escaping ABLResponseFailure) {
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in
                    switch response.result {
                    case .success:
                    success(response.data!)
                    case .failure:
                        error("请求失败")
                        debugPrint(response.response as Any)
                    }
        }
    }
    

    //String(Date().timeIntervalSince1970) +
    /** 上传图片*/
    public func postImage(url: String, params: Parameters?, imgData: Data, progressBlock: @escaping ABLProgressBlock, success:@escaping ABLResponseSuccess, error: @escaping ABLResponseFailure){
//        var imgname = "file"
//        if url.contains(PathPersonal.uploadAuthImage.rawValue) {
//            imgname = "imgurl"
//        }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "file", fileName: "pic.jpg", mimeType: "image/jpeg")
            
        }, to: url, usingThreshold: MultipartFormData.encodingMemoryThreshold,method: .post, headers: nil, interceptor: nil, fileManager:.default)
            .uploadProgress {(progress) in
                
//                print("totalUnitCount:\(progress.totalUnitCount), completedUnitCount:\(progress.completedUnitCount)")
                
//                progressBlock(progress.totalUnitCount)
            }
            .responseJSON { (response) in
            switch response.result {
            case .success:
            success(response.data!)
            case .failure:
                error("请求失败")
                debugPrint(response.response as Any)
            }
        }
    }
    
    
}


// MARK: 网络状态相关
extension HttpRequest {
    ///监听网络状态
    public func detectNetwork(netWorkStatus: @escaping ABLNetworkStatus) {
        let reachability = NetworkReachabilityManager()
        reachability?.startListening(onUpdatePerforming: { [weak self] (status) in
            guard let weakSelf = self else { return }
            if reachability?.isReachable ?? false {
                switch status {
                case .notReachable:
                    weakSelf.mNetworkStatus = NetworkStatus.notReachable
                case .unknown:
                    weakSelf.mNetworkStatus = NetworkStatus.unknown
                case .reachable(.cellular):
                    weakSelf.mNetworkStatus = NetworkStatus.cellular
                case .reachable(.ethernetOrWiFi):
                    weakSelf.mNetworkStatus = NetworkStatus.wifi
                }
            } else {
                weakSelf.mNetworkStatus = NetworkStatus.notReachable
            }
            netWorkStatus(weakSelf.mNetworkStatus.rawValue)
        })
    }
    ///监听网络状态
    public func obtainDataFromLocalWhenNetworkUnconnected() {
        self.detectNetwork { (_) in
        }
    }
}

public class ABLFileConfig: NSObject {
    public var fileData : Data
    public var name : String
    public var fileName : String
    public var mimeType : String
    
    public override init() {
        fileData = Data()
        name = ""
        fileName = ""
        mimeType = ""
    }
    
    public func initFile(fileData : Data,name : String,fileName : String,mimeType : String) {
        self.fileData = fileData
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }
}





