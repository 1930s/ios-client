//
// TradeserverAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class TradeserverAPI {
    /**
     Init data for trade server wrapper
     
     - parameter tradeServerId: (query)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiTradeserverInitDataGet(tradeServerId: UUID, completion: @escaping ((_ data: TradeServerViewModel?,_ error: Error?) -> Void)) {
        apiTradeserverInitDataGetWithRequestBuilder(tradeServerId: tradeServerId).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Init data for trade server wrapper
     - GET /api/tradeserver/initData
     - examples: [{contentType=application/json, example={
  "tradeAccounts" : [ {
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "login" : 6
  }, {
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "login" : 6
  } ],
  "participantRequest" : [ {
    "name" : "name",
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "avatar" : "avatar",
    "ethAddress" : "ethAddress",
    "email" : "email"
  }, {
    "name" : "name",
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "avatar" : "avatar",
    "ethAddress" : "ethAddress",
    "email" : "email"
  } ],
  "tournament" : {
    "isEnabled" : true,
    "dateTo" : "2000-01-23T04:56:07.000+00:00",
    "description" : "description",
    "id" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "registerDateFrom" : "2000-01-23T04:56:07.000+00:00",
    "title" : "title",
    "dateFrom" : "2000-01-23T04:56:07.000+00:00",
    "registerDateTo" : "2000-01-23T04:56:07.000+00:00",
    "startDeposit" : 0.8008281904610115
  }
}}]
     
     - parameter tradeServerId: (query)  

     - returns: RequestBuilder<TradeServerViewModel> 
     */
    open class func apiTradeserverInitDataGetWithRequestBuilder(tradeServerId: UUID) -> RequestBuilder<TradeServerViewModel> {
        let path = "/api/tradeserver/initData"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "tradeServerId": tradeServerId
        ])
        

        let requestBuilder: RequestBuilder<TradeServerViewModel>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     New trade event
     
     - parameter trade: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiTradeserverNewTradePost(trade: NewTrade? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        apiTradeserverNewTradePostWithRequestBuilder(trade: trade).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     New trade event
     - POST /api/tradeserver/newTrade
     
     - parameter trade: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func apiTradeserverNewTradePostWithRequestBuilder(trade: NewTrade? = nil) -> RequestBuilder<Void> {
        let path = "/api/tradeserver/newTrade"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: trade)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Store trade account
     
     - parameter accounts: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func apiTradeserverTradeAccountCreatedPost(accounts: [AccountCreated]? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        apiTradeserverTradeAccountCreatedPostWithRequestBuilder(accounts: accounts).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     Store trade account
     - POST /api/tradeserver/tradeAccountCreated
     
     - parameter accounts: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func apiTradeserverTradeAccountCreatedPostWithRequestBuilder(accounts: [AccountCreated]? = nil) -> RequestBuilder<Void> {
        let path = "/api/tradeserver/tradeAccountCreated"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: accounts)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
