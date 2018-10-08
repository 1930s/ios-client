//
// NotificationsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class NotificationsAPI {
    /**
     User notifications
     
     - parameter authorization: (header) JWT access token 
     - parameter skip: (query)  (optional)
     - parameter take: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10NotificationsGet(authorization: String, skip: Int? = nil, take: Int? = nil, completion: @escaping ((_ data: NotificationList?,_ error: Error?) -> Void)) {
        v10NotificationsGetWithRequestBuilder(authorization: authorization, skip: skip, take: take).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     User notifications
     - GET /v1.0/notifications
     - examples: [{contentType=application/json, example={
  "total" : 0,
  "notifications" : [ {
    "date" : "2000-01-23T04:56:07.000+00:00",
    "logo" : "logo",
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "text" : "text",
    "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "type" : "PlatformNewsAndUpdates",
    "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "url" : "url",
    "isUnread" : true
  }, {
    "date" : "2000-01-23T04:56:07.000+00:00",
    "logo" : "logo",
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "text" : "text",
    "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "type" : "PlatformNewsAndUpdates",
    "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "url" : "url",
    "isUnread" : true
  } ]
}}]
     
     - parameter authorization: (header) JWT access token 
     - parameter skip: (query)  (optional)
     - parameter take: (query)  (optional)

     - returns: RequestBuilder<NotificationList> 
     */
    open class func v10NotificationsGetWithRequestBuilder(authorization: String, skip: Int? = nil, take: Int? = nil) -> RequestBuilder<NotificationList> {
        let path = "/v1.0/notifications"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "skip": skip?.encodeToJSON(), 
            "take": take?.encodeToJSON()
        ])
        
        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<NotificationList>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

    /**
     Unread notifications count
     
     - parameter authorization: (header) JWT access token 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10NotificationsNewGet(authorization: String, completion: @escaping ((_ data: Int?,_ error: Error?) -> Void)) {
        v10NotificationsNewGetWithRequestBuilder(authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Unread notifications count
     - GET /v1.0/notifications/new
     - examples: [{contentType=application/json, example=0}]
     
     - parameter authorization: (header) JWT access token 

     - returns: RequestBuilder<Int> 
     */
    open class func v10NotificationsNewGetWithRequestBuilder(authorization: String) -> RequestBuilder<Int> {
        let path = "/v1.0/notifications/new"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)

        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Int>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

    /**
     * enum for parameter type
     */
    public enum ModelType_v10NotificationsSettingsAddPost: String { 
        case platformNewsAndUpdates = "PlatformNewsAndUpdates"
        case platformEmergency = "PlatformEmergency"
        case platformOther = "PlatformOther"
        case profileUpdated = "ProfileUpdated"
        case profilePwdUpdated = "ProfilePwdUpdated"
        case profileVerification = "ProfileVerification"
        case profile2FA = "Profile2FA"
        case profileSecurity = "ProfileSecurity"
        case programNewsAndUpdates = "ProgramNewsAndUpdates"
        case programEndOfPeriod = "ProgramEndOfPeriod"
        case programCondition = "ProgramCondition"
        case managerNewProgram = "ManagerNewProgram"
    }

    /**
     * enum for parameter conditionType
     */
    public enum ConditionType_v10NotificationsSettingsAddPost: String { 
        case empty = "Empty"
        case profit = "Profit"
        case level = "Level"
    }

    /**
     Add new setting
     
     - parameter authorization: (header) JWT access token 
     - parameter programId: (query)  (optional)
     - parameter managerId: (query)  (optional)
     - parameter type: (query)  (optional)
     - parameter conditionType: (query)  (optional)
     - parameter conditionAmount: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10NotificationsSettingsAddPost(authorization: String, programId: UUID? = nil, managerId: UUID? = nil, type: ModelType_v10NotificationsSettingsAddPost? = nil, conditionType: ConditionType_v10NotificationsSettingsAddPost? = nil, conditionAmount: Double? = nil, completion: @escaping ((_ data: UUID?,_ error: Error?) -> Void)) {
        v10NotificationsSettingsAddPostWithRequestBuilder(authorization: authorization, programId: programId, managerId: managerId, type: type, conditionType: conditionType, conditionAmount: conditionAmount).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Add new setting
     - POST /v1.0/notifications/settings/add
     - examples: [{contentType=application/json, example="046b6c7f-0b8a-43b9-b35d-6489e6daee91"}]
     
     - parameter authorization: (header) JWT access token 
     - parameter programId: (query)  (optional)
     - parameter managerId: (query)  (optional)
     - parameter type: (query)  (optional)
     - parameter conditionType: (query)  (optional)
     - parameter conditionAmount: (query)  (optional)

     - returns: RequestBuilder<UUID> 
     */
    open class func v10NotificationsSettingsAddPostWithRequestBuilder(authorization: String, programId: UUID? = nil, managerId: UUID? = nil, type: ModelType_v10NotificationsSettingsAddPost? = nil, conditionType: ConditionType_v10NotificationsSettingsAddPost? = nil, conditionAmount: Double? = nil) -> RequestBuilder<UUID> {
        let path = "/v1.0/notifications/settings/add"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "ProgramId": programId, 
            "ManagerId": managerId, 
            "Type": type?.rawValue, 
            "ConditionType": conditionType?.rawValue, 
            "ConditionAmount": conditionAmount
        ])
        
        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<UUID>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

    /**
     Enable/disable setting
     
     - parameter id: (path)  
     - parameter enable: (path)  
     - parameter authorization: (header) JWT access token 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10NotificationsSettingsByIdByEnablePost(id: UUID, enable: Bool, authorization: String, completion: @escaping ((_ data: UUID?,_ error: Error?) -> Void)) {
        v10NotificationsSettingsByIdByEnablePostWithRequestBuilder(id: id, enable: enable, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Enable/disable setting
     - POST /v1.0/notifications/settings/{id}/{enable}
     - examples: [{contentType=application/json, example="046b6c7f-0b8a-43b9-b35d-6489e6daee91"}]
     
     - parameter id: (path)  
     - parameter enable: (path)  
     - parameter authorization: (header) JWT access token 

     - returns: RequestBuilder<UUID> 
     */
    open class func v10NotificationsSettingsByIdByEnablePostWithRequestBuilder(id: UUID, enable: Bool, authorization: String) -> RequestBuilder<UUID> {
        var path = "/v1.0/notifications/settings/{id}/{enable}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{enable}", with: "\(enable)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)

        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<UUID>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

    /**
     User settings
     
     - parameter authorization: (header) JWT access token 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10NotificationsSettingsGet(authorization: String, completion: @escaping ((_ data: NotificationSettingList?,_ error: Error?) -> Void)) {
        v10NotificationsSettingsGetWithRequestBuilder(authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     User settings
     - GET /v1.0/notifications/settings
     - examples: [{contentType=application/json, example={
  "settingsProgram" : [ {
    "level" : 6,
    "logo" : "logo",
    "settingsGeneral" : [ {
      "isEnabled" : true,
      "conditionAmount" : 0.8008281904610115,
      "conditionType" : "Empty",
      "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "type" : "PlatformNewsAndUpdates",
      "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
    }, {
      "isEnabled" : true,
      "conditionAmount" : 0.8008281904610115,
      "conditionType" : "Empty",
      "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "type" : "PlatformNewsAndUpdates",
      "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
    } ],
    "title" : "title",
    "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "url" : "url",
    "settingsCustom" : [ {
      "isEnabled" : true,
      "conditionAmount" : 0.8008281904610115,
      "conditionType" : "Empty",
      "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "type" : "PlatformNewsAndUpdates",
      "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
    }, {
      "isEnabled" : true,
      "conditionAmount" : 0.8008281904610115,
      "conditionType" : "Empty",
      "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "type" : "PlatformNewsAndUpdates",
      "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
    } ]
  }, {
    "level" : 6,
    "logo" : "logo",
    "settingsGeneral" : [ {
      "isEnabled" : true,
      "conditionAmount" : 0.8008281904610115,
      "conditionType" : "Empty",
      "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "type" : "PlatformNewsAndUpdates",
      "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
    }, {
      "isEnabled" : true,
      "conditionAmount" : 0.8008281904610115,
      "conditionType" : "Empty",
      "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "type" : "PlatformNewsAndUpdates",
      "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
    } ],
    "title" : "title",
    "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "url" : "url",
    "settingsCustom" : [ {
      "isEnabled" : true,
      "conditionAmount" : 0.8008281904610115,
      "conditionType" : "Empty",
      "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "type" : "PlatformNewsAndUpdates",
      "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
    }, {
      "isEnabled" : true,
      "conditionAmount" : 0.8008281904610115,
      "conditionType" : "Empty",
      "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "type" : "PlatformNewsAndUpdates",
      "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
    } ]
  } ],
  "settingsManager" : [ {
    "about" : "about",
    "settingsGeneral" : [ {
      "isEnabled" : true,
      "conditionAmount" : 0.8008281904610115,
      "conditionType" : "Empty",
      "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "type" : "PlatformNewsAndUpdates",
      "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
    }, {
      "isEnabled" : true,
      "conditionAmount" : 0.8008281904610115,
      "conditionType" : "Empty",
      "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "type" : "PlatformNewsAndUpdates",
      "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
    } ],
    "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "avatar" : "avatar",
    "url" : "url",
    "username" : "username"
  }, {
    "about" : "about",
    "settingsGeneral" : [ {
      "isEnabled" : true,
      "conditionAmount" : 0.8008281904610115,
      "conditionType" : "Empty",
      "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "type" : "PlatformNewsAndUpdates",
      "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
    }, {
      "isEnabled" : true,
      "conditionAmount" : 0.8008281904610115,
      "conditionType" : "Empty",
      "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
      "type" : "PlatformNewsAndUpdates",
      "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
    } ],
    "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "avatar" : "avatar",
    "url" : "url",
    "username" : "username"
  } ],
  "settingsGeneral" : [ {
    "isEnabled" : true,
    "conditionAmount" : 0.8008281904610115,
    "conditionType" : "Empty",
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "type" : "PlatformNewsAndUpdates",
    "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
  }, {
    "isEnabled" : true,
    "conditionAmount" : 0.8008281904610115,
    "conditionType" : "Empty",
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "type" : "PlatformNewsAndUpdates",
    "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
  } ]
}}]
     
     - parameter authorization: (header) JWT access token 

     - returns: RequestBuilder<NotificationSettingList> 
     */
    open class func v10NotificationsSettingsGetWithRequestBuilder(authorization: String) -> RequestBuilder<NotificationSettingList> {
        let path = "/v1.0/notifications/settings"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)

        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<NotificationSettingList>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

    /**
     User settings for manager
     
     - parameter id: (path)  
     - parameter authorization: (header) JWT access token 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10NotificationsSettingsManagersByIdGet(id: String, authorization: String, completion: @escaping ((_ data: ManagerNotificationSettingList?,_ error: Error?) -> Void)) {
        v10NotificationsSettingsManagersByIdGetWithRequestBuilder(id: id, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     User settings for manager
     - GET /v1.0/notifications/settings/managers/{id}
     - examples: [{contentType=application/json, example={
  "about" : "about",
  "settingsGeneral" : [ {
    "isEnabled" : true,
    "conditionAmount" : 0.8008281904610115,
    "conditionType" : "Empty",
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "type" : "PlatformNewsAndUpdates",
    "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
  }, {
    "isEnabled" : true,
    "conditionAmount" : 0.8008281904610115,
    "conditionType" : "Empty",
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "type" : "PlatformNewsAndUpdates",
    "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
  } ],
  "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "avatar" : "avatar",
  "url" : "url",
  "username" : "username"
}}]
     
     - parameter id: (path)  
     - parameter authorization: (header) JWT access token 

     - returns: RequestBuilder<ManagerNotificationSettingList> 
     */
    open class func v10NotificationsSettingsManagersByIdGetWithRequestBuilder(id: String, authorization: String) -> RequestBuilder<ManagerNotificationSettingList> {
        var path = "/v1.0/notifications/settings/managers/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)

        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<ManagerNotificationSettingList>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

    /**
     User settings for program
     
     - parameter id: (path)  
     - parameter authorization: (header) JWT access token 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10NotificationsSettingsProgramsByIdGet(id: String, authorization: String, completion: @escaping ((_ data: ProgramNotificationSettingList?,_ error: Error?) -> Void)) {
        v10NotificationsSettingsProgramsByIdGetWithRequestBuilder(id: id, authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     User settings for program
     - GET /v1.0/notifications/settings/programs/{id}
     - examples: [{contentType=application/json, example={
  "level" : 6,
  "logo" : "logo",
  "settingsGeneral" : [ {
    "isEnabled" : true,
    "conditionAmount" : 0.8008281904610115,
    "conditionType" : "Empty",
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "type" : "PlatformNewsAndUpdates",
    "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
  }, {
    "isEnabled" : true,
    "conditionAmount" : 0.8008281904610115,
    "conditionType" : "Empty",
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "type" : "PlatformNewsAndUpdates",
    "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
  } ],
  "title" : "title",
  "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "url" : "url",
  "settingsCustom" : [ {
    "isEnabled" : true,
    "conditionAmount" : 0.8008281904610115,
    "conditionType" : "Empty",
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "type" : "PlatformNewsAndUpdates",
    "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
  }, {
    "isEnabled" : true,
    "conditionAmount" : 0.8008281904610115,
    "conditionType" : "Empty",
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "managerId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "type" : "PlatformNewsAndUpdates",
    "programId" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91"
  } ]
}}]
     
     - parameter id: (path)  
     - parameter authorization: (header) JWT access token 

     - returns: RequestBuilder<ProgramNotificationSettingList> 
     */
    open class func v10NotificationsSettingsProgramsByIdGetWithRequestBuilder(id: String, authorization: String) -> RequestBuilder<ProgramNotificationSettingList> {
        var path = "/v1.0/notifications/settings/programs/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)

        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<ProgramNotificationSettingList>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

    /**
     Remove setting
     
     - parameter id: (path)  
     - parameter authorization: (header) JWT access token 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10NotificationsSettingsRemoveByIdPost(id: UUID, authorization: String, completion: @escaping ((_ error: Error?) -> Void)) {
        v10NotificationsSettingsRemoveByIdPostWithRequestBuilder(id: id, authorization: authorization).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     Remove setting
     - POST /v1.0/notifications/settings/remove/{id}
     
     - parameter id: (path)  
     - parameter authorization: (header) JWT access token 

     - returns: RequestBuilder<Void> 
     */
    open class func v10NotificationsSettingsRemoveByIdPostWithRequestBuilder(id: UUID, authorization: String) -> RequestBuilder<Void> {
        var path = "/v1.0/notifications/settings/remove/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)

        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

}
