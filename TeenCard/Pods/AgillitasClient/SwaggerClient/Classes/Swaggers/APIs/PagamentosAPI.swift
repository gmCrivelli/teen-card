//
// PagamentosAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Alamofire



open class PagamentosAPI: APIBase {
    /**
     Pagamento de boletos.
     
     - parameter boleto: (body) Objeto de requisição 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func pagamentosPost(boleto: Pagamento, completion: @escaping ((_ error: Error?) -> Void)) {
        pagamentosPostWithRequestBuilder(boleto: boleto).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     Pagamento de boletos.
     - POST /pagamentos
     - <p>Permite o pagamento de boletos.</p>
     
     - parameter boleto: (body) Objeto de requisição 

     - returns: RequestBuilder<Void> 
     */
    open class func pagamentosPostWithRequestBuilder(boleto: Pagamento) -> RequestBuilder<Void> {
        let path = "/pagamentos"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = boleto.encodeToJSON() as? [String:AnyObject]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

}
