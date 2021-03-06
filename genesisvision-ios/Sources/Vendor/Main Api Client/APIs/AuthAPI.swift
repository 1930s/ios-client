//
// AuthAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class AuthAPI {
    /**
     2FA confirm
     
     - parameter authorization: (header) JWT access token 
     - parameter model: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10Auth2faConfirmPost(authorization: String, model: TwoFactorAuthenticatorConfirm? = nil, completion: @escaping ((_ data: RecoveryCodesViewModel?,_ error: Error?) -> Void)) {
        v10Auth2faConfirmPostWithRequestBuilder(authorization: authorization, model: model).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     2FA confirm
     - POST /v1.0/auth/2fa/confirm
     - examples: [{contentType=application/json, example={
  "codes" : [ {
    "code" : "code",
    "isActive" : true
  }, {
    "code" : "code",
    "isActive" : true
  } ],
  "authToken" : "authToken"
}}]
     
     - parameter authorization: (header) JWT access token 
     - parameter model: (body)  (optional)

     - returns: RequestBuilder<RecoveryCodesViewModel> 
     */
    open class func v10Auth2faConfirmPostWithRequestBuilder(authorization: String, model: TwoFactorAuthenticatorConfirm? = nil) -> RequestBuilder<RecoveryCodesViewModel> {
        let path = "/v1.0/auth/2fa/confirm"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: model)

        let url = NSURLComponents(string: URLString)

        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<RecoveryCodesViewModel>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true, headers: headerParameters)
    }

    /**
     2FA create
     
     - parameter authorization: (header) JWT access token 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10Auth2faCreatePost(authorization: String, completion: @escaping ((_ data: TwoFactorAuthenticator?,_ error: Error?) -> Void)) {
        v10Auth2faCreatePostWithRequestBuilder(authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     2FA create
     - POST /v1.0/auth/2fa/create
     - examples: [{contentType=application/json, example={
  "sharedKey" : "sharedKey",
  "authenticatorUri" : "authenticatorUri"
}}]
     
     - parameter authorization: (header) JWT access token 

     - returns: RequestBuilder<TwoFactorAuthenticator> 
     */
    open class func v10Auth2faCreatePostWithRequestBuilder(authorization: String) -> RequestBuilder<TwoFactorAuthenticator> {
        let path = "/v1.0/auth/2fa/create"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)

        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<TwoFactorAuthenticator>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

    /**
     2FA disable
     
     - parameter authorization: (header) JWT access token 
     - parameter model: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10Auth2faDisablePost(authorization: String, model: TwoFactorCodeModel? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        v10Auth2faDisablePostWithRequestBuilder(authorization: authorization, model: model).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     2FA disable
     - POST /v1.0/auth/2fa/disable
     
     - parameter authorization: (header) JWT access token 
     - parameter model: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func v10Auth2faDisablePostWithRequestBuilder(authorization: String, model: TwoFactorCodeModel? = nil) -> RequestBuilder<Void> {
        let path = "/v1.0/auth/2fa/disable"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: model)

        let url = NSURLComponents(string: URLString)

        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true, headers: headerParameters)
    }

    /**
     2FA status
     
     - parameter authorization: (header) JWT access token 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10Auth2faGet(authorization: String, completion: @escaping ((_ data: TwoFactorStatus?,_ error: Error?) -> Void)) {
        v10Auth2faGetWithRequestBuilder(authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     2FA status
     - GET /v1.0/auth/2fa
     - examples: [{contentType=application/json, example={
  "twoFactorEnabled" : true
}}]
     
     - parameter authorization: (header) JWT access token 

     - returns: RequestBuilder<TwoFactorStatus> 
     */
    open class func v10Auth2faGetWithRequestBuilder(authorization: String) -> RequestBuilder<TwoFactorStatus> {
        let path = "/v1.0/auth/2fa"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)

        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<TwoFactorStatus>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

    /**
     2FA generate new recovery codes
     
     - parameter authorization: (header) JWT access token 
     - parameter model: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10Auth2faRecoverycodesNewPost(authorization: String, model: PasswordModel? = nil, completion: @escaping ((_ data: RecoveryCodesViewModel?,_ error: Error?) -> Void)) {
        v10Auth2faRecoverycodesNewPostWithRequestBuilder(authorization: authorization, model: model).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     2FA generate new recovery codes
     - POST /v1.0/auth/2fa/recoverycodes/new
     - examples: [{contentType=application/json, example={
  "codes" : [ {
    "code" : "code",
    "isActive" : true
  }, {
    "code" : "code",
    "isActive" : true
  } ],
  "authToken" : "authToken"
}}]
     
     - parameter authorization: (header) JWT access token 
     - parameter model: (body)  (optional)

     - returns: RequestBuilder<RecoveryCodesViewModel> 
     */
    open class func v10Auth2faRecoverycodesNewPostWithRequestBuilder(authorization: String, model: PasswordModel? = nil) -> RequestBuilder<RecoveryCodesViewModel> {
        let path = "/v1.0/auth/2fa/recoverycodes/new"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: model)

        let url = NSURLComponents(string: URLString)

        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<RecoveryCodesViewModel>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true, headers: headerParameters)
    }

    /**
     2FA recovery codes
     
     - parameter authorization: (header) JWT access token 
     - parameter model: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10Auth2faRecoverycodesPost(authorization: String, model: PasswordModel? = nil, completion: @escaping ((_ data: RecoveryCodesViewModel?,_ error: Error?) -> Void)) {
        v10Auth2faRecoverycodesPostWithRequestBuilder(authorization: authorization, model: model).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     2FA recovery codes
     - POST /v1.0/auth/2fa/recoverycodes
     - examples: [{contentType=application/json, example={
  "codes" : [ {
    "code" : "code",
    "isActive" : true
  }, {
    "code" : "code",
    "isActive" : true
  } ],
  "authToken" : "authToken"
}}]
     
     - parameter authorization: (header) JWT access token 
     - parameter model: (body)  (optional)

     - returns: RequestBuilder<RecoveryCodesViewModel> 
     */
    open class func v10Auth2faRecoverycodesPostWithRequestBuilder(authorization: String, model: PasswordModel? = nil) -> RequestBuilder<RecoveryCodesViewModel> {
        let path = "/v1.0/auth/2fa/recoverycodes"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: model)

        let url = NSURLComponents(string: URLString)

        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<RecoveryCodesViewModel>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true, headers: headerParameters)
    }

    /**
     Change password
     
     - parameter authorization: (header) JWT access token 
     - parameter model: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10AuthPasswordChangePost(authorization: String, model: ChangePasswordViewModel? = nil, completion: @escaping ((_ data: String?,_ error: Error?) -> Void)) {
        v10AuthPasswordChangePostWithRequestBuilder(authorization: authorization, model: model).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Change password
     - POST /v1.0/auth/password/change
     - examples: [{contentType=application/json, example=""}]
     
     - parameter authorization: (header) JWT access token 
     - parameter model: (body)  (optional)

     - returns: RequestBuilder<String> 
     */
    open class func v10AuthPasswordChangePostWithRequestBuilder(authorization: String, model: ChangePasswordViewModel? = nil) -> RequestBuilder<String> {
        let path = "/v1.0/auth/password/change"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: model)

        let url = NSURLComponents(string: URLString)

        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<String>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true, headers: headerParameters)
    }

    /**
     Forgot password for investor
     
     - parameter model: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10AuthPasswordForgotInvestorPost(model: ForgotPasswordViewModel? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        v10AuthPasswordForgotInvestorPostWithRequestBuilder(model: model).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     Forgot password for investor
     - POST /v1.0/auth/password/forgot/investor
     
     - parameter model: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func v10AuthPasswordForgotInvestorPostWithRequestBuilder(model: ForgotPasswordViewModel? = nil) -> RequestBuilder<Void> {
        let path = "/v1.0/auth/password/forgot/investor"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: model)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Forgot password for manager
     
     - parameter model: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10AuthPasswordForgotManagerPost(model: ForgotPasswordViewModel? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        v10AuthPasswordForgotManagerPostWithRequestBuilder(model: model).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     Forgot password for manager
     - POST /v1.0/auth/password/forgot/manager
     
     - parameter model: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func v10AuthPasswordForgotManagerPostWithRequestBuilder(model: ForgotPasswordViewModel? = nil) -> RequestBuilder<Void> {
        let path = "/v1.0/auth/password/forgot/manager"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: model)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Reset password
     
     - parameter model: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10AuthPasswordResetPost(model: ResetPasswordViewModel? = nil, completion: @escaping ((_ data: String?,_ error: Error?) -> Void)) {
        v10AuthPasswordResetPostWithRequestBuilder(model: model).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Reset password
     - POST /v1.0/auth/password/reset
     - examples: [{contentType=application/json, example=""}]
     
     - parameter model: (body)  (optional)

     - returns: RequestBuilder<String> 
     */
    open class func v10AuthPasswordResetPostWithRequestBuilder(model: ResetPasswordViewModel? = nil) -> RequestBuilder<String> {
        let path = "/v1.0/auth/password/reset"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: model)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<String>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Get phone number verification code
     
     - parameter authorization: (header) JWT access token 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10AuthPhoneCodePost(authorization: String, completion: @escaping ((_ data: Int?,_ error: Error?) -> Void)) {
        v10AuthPhoneCodePostWithRequestBuilder(authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Get phone number verification code
     - POST /v1.0/auth/phone/code
     - examples: [{contentType=application/json, example=0}]
     
     - parameter authorization: (header) JWT access token 

     - returns: RequestBuilder<Int> 
     */
    open class func v10AuthPhoneCodePostWithRequestBuilder(authorization: String) -> RequestBuilder<Int> {
        let path = "/v1.0/auth/phone/code"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)

        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Int>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

    /**
     Verify phone number
     
     - parameter authorization: (header) JWT access token 
     - parameter code: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10AuthPhoneVerifyPost(authorization: String, code: String? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        v10AuthPhoneVerifyPostWithRequestBuilder(authorization: authorization, code: code).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     Verify phone number
     - POST /v1.0/auth/phone/verify
     
     - parameter authorization: (header) JWT access token 
     - parameter code: (query)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func v10AuthPhoneVerifyPostWithRequestBuilder(authorization: String, code: String? = nil) -> RequestBuilder<Void> {
        let path = "/v1.0/auth/phone/verify"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "code": code
        ])
        
        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

    /**
     Resend Confirmation Link
     
     - parameter model: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10AuthResendconfirmationlinkPost(model: ResendConfirmationViewModel? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        v10AuthResendconfirmationlinkPostWithRequestBuilder(model: model).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     Resend Confirmation Link
     - POST /v1.0/auth/resendconfirmationlink
     
     - parameter model: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func v10AuthResendconfirmationlinkPostWithRequestBuilder(model: ResendConfirmationViewModel? = nil) -> RequestBuilder<Void> {
        let path = "/v1.0/auth/resendconfirmationlink"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: model)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Authorize
     
     - parameter model: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10AuthSigninInvestorPost(model: LoginViewModel? = nil, completion: @escaping ((_ data: String?,_ error: Error?) -> Void)) {
        v10AuthSigninInvestorPostWithRequestBuilder(model: model).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Authorize
     - POST /v1.0/auth/signin/investor
     - examples: [{contentType=application/json, example=""}]
     
     - parameter model: (body)  (optional)

     - returns: RequestBuilder<String> 
     */
    open class func v10AuthSigninInvestorPostWithRequestBuilder(model: LoginViewModel? = nil) -> RequestBuilder<String> {
        let path = "/v1.0/auth/signin/investor"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: model)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<String>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Authorize
     
     - parameter model: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10AuthSigninManagerPost(model: LoginViewModel? = nil, completion: @escaping ((_ data: String?,_ error: Error?) -> Void)) {
        v10AuthSigninManagerPostWithRequestBuilder(model: model).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Authorize
     - POST /v1.0/auth/signin/manager
     - examples: [{contentType=application/json, example=""}]
     
     - parameter model: (body)  (optional)

     - returns: RequestBuilder<String> 
     */
    open class func v10AuthSigninManagerPostWithRequestBuilder(model: LoginViewModel? = nil) -> RequestBuilder<String> {
        let path = "/v1.0/auth/signin/manager"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: model)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<String>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Confirm email after registration
     
     - parameter userId: (query)  (optional)
     - parameter code: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10AuthSignupConfirmPost(userId: String? = nil, code: String? = nil, completion: @escaping ((_ data: String?,_ error: Error?) -> Void)) {
        v10AuthSignupConfirmPostWithRequestBuilder(userId: userId, code: code).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Confirm email after registration
     - POST /v1.0/auth/signup/confirm
     - examples: [{contentType=application/json, example=""}]
     
     - parameter userId: (query)  (optional)
     - parameter code: (query)  (optional)

     - returns: RequestBuilder<String> 
     */
    open class func v10AuthSignupConfirmPostWithRequestBuilder(userId: String? = nil, code: String? = nil) -> RequestBuilder<String> {
        let path = "/v1.0/auth/signup/confirm"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "userId": userId, 
            "code": code
        ])
        

        let requestBuilder: RequestBuilder<String>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     New investor registration
     
     - parameter model: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10AuthSignupInvestorPost(model: RegisterInvestorViewModel? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        v10AuthSignupInvestorPostWithRequestBuilder(model: model).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     New investor registration
     - POST /v1.0/auth/signup/investor
     
     - parameter model: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func v10AuthSignupInvestorPostWithRequestBuilder(model: RegisterInvestorViewModel? = nil) -> RequestBuilder<Void> {
        let path = "/v1.0/auth/signup/investor"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: model)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     New manager registration
     
     - parameter model: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10AuthSignupManagerPost(model: RegisterManagerViewModel? = nil, completion: @escaping ((_ error: Error?) -> Void)) {
        v10AuthSignupManagerPostWithRequestBuilder(model: model).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     New manager registration
     - POST /v1.0/auth/signup/manager
     
     - parameter model: (body)  (optional)

     - returns: RequestBuilder<Void> 
     */
    open class func v10AuthSignupManagerPostWithRequestBuilder(model: RegisterManagerViewModel? = nil) -> RequestBuilder<Void> {
        let path = "/v1.0/auth/signup/manager"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: model)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Logout from another devices
     
     - parameter authorization: (header) JWT access token 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10AuthTokenDevicesLogoutPost(authorization: String, completion: @escaping ((_ data: String?,_ error: Error?) -> Void)) {
        v10AuthTokenDevicesLogoutPostWithRequestBuilder(authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Logout from another devices
     - POST /v1.0/auth/token/devices/logout
     - examples: [{contentType=application/json, example=""}]
     
     - parameter authorization: (header) JWT access token 

     - returns: RequestBuilder<String> 
     */
    open class func v10AuthTokenDevicesLogoutPostWithRequestBuilder(authorization: String) -> RequestBuilder<String> {
        let path = "/v1.0/auth/token/devices/logout"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)

        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<String>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

    /**
     Update auth token
     
     - parameter authorization: (header) JWT access token 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func v10AuthTokenUpdatePost(authorization: String, completion: @escaping ((_ data: String?,_ error: Error?) -> Void)) {
        v10AuthTokenUpdatePostWithRequestBuilder(authorization: authorization).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Update auth token
     - POST /v1.0/auth/token/update
     - examples: [{contentType=application/json, example=""}]
     
     - parameter authorization: (header) JWT access token 

     - returns: RequestBuilder<String> 
     */
    open class func v10AuthTokenUpdatePostWithRequestBuilder(authorization: String) -> RequestBuilder<String> {
        let path = "/v1.0/auth/token/update"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)

        let nillableHeaders: [String: Any?] = [
            "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<String>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }

}
