//
//  ETNetworkingManager+Extension.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/13.
//  Copyright © 2018年 BF. All rights reserved.
//

import Foundation
import AFNetworking

// MARK: - ETNetworkingManager的扩展，负责处理专门的接口
extension ETNetworkingManager {
    /// 根据用户名和密码登录
    ///
    /// - Parameters:
    ///   - userName: 用户名
    ///   - password: 密码
    ///   - completion: 完成回调(用户名和密码是否正确，访问网络是否成功)
    func login(userName: String, password: String, completion: @escaping (Bool, Bool) -> ()) {
        let urlString = "http://baoxiu.jvtc.jx.cn/ydgw/userlogin_checkUser.htm?username=\(userName)&password=\(password)"
        print(urlString)
        guard let url = URL(string: urlString)  else {
            completion(false, false)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let response = (response as? HTTPURLResponse) {
                if response.statusCode == 500 {
                    print("状态码500")
                    DispatchQueue.main.async {
                        completion(false, true)
                    }
                    return
                }
            }
            
            if error != nil {
                print("访问网络出错")
                DispatchQueue.main.async {
                    completion(false, true)
                }
                return
            }
            
            guard let data = data,
                let result = String(data: data, encoding: String.Encoding.utf8) else {
                    DispatchQueue.main.async {
                        completion(false, true)
                    }
                    return
            }
            
            let range = (result as NSString).range(of: "\r\n")
            let isSucceedStr = (result as NSString).substring(to: range.location)
            let isLoginSucceed = Int(isSucceedStr) == 0 ? false : true
            
            DispatchQueue.main.async {
                completion(isLoginSucceed, true)
            }
        }.resume()
        
       
    }
    
    // FIXME: 这个接口可能会有点问题
    /// 获取所有通知数据
    ///
    /// - Parameter completion: 完成回调(字典数组：数组里面有很多字典，请求网络是否成功)
    func notices(completion: @escaping (Any?, Bool) -> ()) {
        let urlString = "http://baoxiu.jvtc.jx.cn/ydgw/notice_ajaxnoticelist.htm"
        
        GET(urlString: urlString) { (responseObject, isSucceed) in
            completion(responseObject, isSucceed)
        }
        
    }
    
    /// 根据指定id获取详细的通知
    ///
    /// - Parameters:
    ///   - noticeID: id
    ///   - completion: 完成回调(返回字典，请求网络是否成功)
    func detailNotice(noticeID: Int, completion: @escaping (Any?, Bool) -> ()) {
        let urlString = "http://baoxiu.jvtc.jx.cn/ydgw/notice_ajaxnotice.htm?noticeid=\(noticeID)"
        
        GET(urlString: urlString) { (responseObject, isSucceed) in
            completion(responseObject, isSucceed)
        }
    }
    
    /// 根据用户id获取个人周记数据
    ///
    /// - Parameters:
    ///   - userID: 用户id
    ///   - completion: 完成回调(返回的是字典数组：数组里有很多字典，请求网络是否成功)
    func personalWeeknote(userID: String, completion: @escaping (Any?, Bool) -> ()) {
        if userID.count == 0 {
            completion(nil, false)
            return
        }
        
        let urlString = "http://baoxiu.jvtc.jx.cn/ydgw/weeknote_ajaxweeknoteByUser.htm?userid=\(userID)"
        
        GET(urlString: urlString) { (responseObjcet, isSucceed) in
            completion(responseObjcet, isSucceed)
        }
    }
    
    ///  根据周记id获取具体周记数据
    ///
    /// - Parameters:
    ///   - weeknoteID: 周记id
    ///   - completion: 完成回调：(返回一个字典，请求网络是否成功)
    func specificWeeknote(weeknoteID: Int, completion: @escaping (Any?, Bool) -> ()) {
        let urlString = "http://baoxiu.jvtc.jx.cn/ydgw/ydgw/weeknote_ajaxWeekNoteInfo.htm?weeknoteid=\(weeknoteID)"
        
        GET(urlString: urlString) { (responseObjcet, isSucceed) in
            completion(responseObjcet, isSucceed)
        }
    }
    
    /// 获取招聘信息列表
    ///
    /// - Parameter completion: 完成回调(字典数组：数组里面有很多字典， 请求网络是否成功)
    func jobInfos(completion: @escaping (Any?, Bool) -> ()) {
        let urlString = "http://baoxiu.jvtc.jx.cn/ydgw/job_ajaxjoblist.htm"
        
        GET(urlString: urlString) { (responseObject, isSucceed) in
            completion(responseObject, isSucceed)
        }
    }
    
    /// 根据招聘信息id获取详细的招聘信息
    ///
    /// - Parameters:
    ///   - jobID: 招聘信息id
    ///   - completion: 完成回调(返回的是一个字典，是否成功)
    func specificJobInfo(jobID: Int, completion: @escaping (Any?, Bool) -> ()) {
        let urlString = "http://baoxiu.jvtc.jx.cn/ydgw/job_ajaxJobInfo.htm?jobid=\(jobID)"
        
        GET(urlString: urlString) { (responseObjcet, isSucceed) in
            completion(responseObjcet, isSucceed)
        }
    }
}
