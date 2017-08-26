// Models.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

protocol JSONEncodable {
    func encodeToJSON() -> Any
}

public enum ErrorResponse : Error {
    case Error(Int, Data?, Error)
}

open class Response<T> {
    open let statusCode: Int
    open let header: [String: String]
    open let body: T?

    public init(statusCode: Int, header: [String: String], body: T?) {
        self.statusCode = statusCode
        self.header = header
        self.body = body
    }

    public convenience init(response: HTTPURLResponse, body: T?) {
        let rawHeader = response.allHeaderFields
        var header = [String:String]()
        for (key, value) in rawHeader {
            header[key as! String] = value as? String
        }
        self.init(statusCode: response.statusCode, header: header, body: body)
    }
}

private var once = Int()
class Decoders {
    static fileprivate var decoders = Dictionary<String, ((AnyObject) -> AnyObject)>()

    static func addDecoder<T>(clazz: T.Type, decoder: @escaping ((AnyObject) -> T)) {
        let key = "\(T.self)"
        decoders[key] = { decoder($0) as AnyObject }
    }

    static func decode<T>(clazz: [T].Type, source: AnyObject) -> [T] {
        let array = source as! [AnyObject]
        return array.map { Decoders.decode(clazz: T.self, source: $0) }
    }

    static func decode<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject) -> [Key:T] {
        let sourceDictionary = source as! [Key: AnyObject]
        var dictionary = [Key:T]()
        for (key, value) in sourceDictionary {
            dictionary[key] = Decoders.decode(clazz: T.self, source: value)
        }
        return dictionary
    }

    static func decode<T>(clazz: T.Type, source: AnyObject) -> T {
        initialize()
        if T.self is Int32.Type && source is NSNumber {
            return source.int32Value as! T;
        }
        if T.self is Int64.Type && source is NSNumber {
            return source.int64Value as! T;
        }
        if T.self is UUID.Type && source is String {
            return UUID(uuidString: source as! String) as! T
        }
        if source is T {
            return source as! T
        }
        if T.self is Data.Type && source is String {
            return Data(base64Encoded: source as! String) as! T
        }

        let key = "\(T.self)"
        if let decoder = decoders[key] {
           return decoder(source) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decodeOptional<T>(clazz: T.Type, source: AnyObject?) -> T? {
        if source is NSNull {
            return nil
        }
        return source.map { (source: AnyObject) -> T in
            Decoders.decode(clazz: clazz, source: source)
        }
    }

    static func decodeOptional<T>(clazz: [T].Type, source: AnyObject?) -> [T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    static func decodeOptional<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject?) -> [Key:T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [Key:T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    private static var __once: () = {
        let formatters = [
            "yyyy-MM-dd",
            "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss'Z'",
            "yyyy-MM-dd'T'HH:mm:ss.SSS"
        ].map { (format: String) -> DateFormatter in
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter
        }
        // Decoder for Date
        Decoders.addDecoder(clazz: Date.self) { (source: AnyObject) -> Date in
           if let sourceString = source as? String {
                for formatter in formatters {
                    if let date = formatter.date(from: sourceString) {
                        return date
                    }
                }
            }
            if let sourceInt = source as? Int {
                // treat as a java date
                return Date(timeIntervalSince1970: Double(sourceInt / 1000) )
            }
            fatalError("formatter failed to parse \(source)")
        } 

        // Decoder for [CadastroBenificiario]
        Decoders.addDecoder(clazz: [CadastroBenificiario].self) { (source: AnyObject) -> [CadastroBenificiario] in
            return Decoders.decode(clazz: [CadastroBenificiario].self, source: source)
        }
        // Decoder for CadastroBenificiario
        Decoders.addDecoder(clazz: CadastroBenificiario.self) { (source: AnyObject) -> CadastroBenificiario in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = CadastroBenificiario()
            instance.idCartao = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["idCartao"] as AnyObject?)
            instance.idCartaoDestino = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["idCartaoDestino"] as AnyObject?)
            instance.nome = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["nome"] as AnyObject?)
            instance.cpf = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["cpf"] as AnyObject?)
            return instance
        }


        // Decoder for [DetalhamentoExtrato]
        Decoders.addDecoder(clazz: [DetalhamentoExtrato].self) { (source: AnyObject) -> [DetalhamentoExtrato] in
            return Decoders.decode(clazz: [DetalhamentoExtrato].self, source: source)
        }
        // Decoder for DetalhamentoExtrato
        Decoders.addDecoder(clazz: DetalhamentoExtrato.self) { (source: AnyObject) -> DetalhamentoExtrato in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = DetalhamentoExtrato()
            instance.dataHora = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["dataHora"] as AnyObject?)
            instance.estabelecimento = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["estabelecimento"] as AnyObject?)
            instance.tipo = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["tipo"] as AnyObject?)
            instance.valor = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["valor"] as AnyObject?)
            return instance
        }


        // Decoder for [EnderecoPortador]
        Decoders.addDecoder(clazz: [EnderecoPortador].self) { (source: AnyObject) -> [EnderecoPortador] in
            return Decoders.decode(clazz: [EnderecoPortador].self, source: source)
        }
        // Decoder for EnderecoPortador
        Decoders.addDecoder(clazz: EnderecoPortador.self) { (source: AnyObject) -> EnderecoPortador in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = EnderecoPortador()
            instance.logradouro = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["logradouro"] as AnyObject?)
            instance.cidade = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["cidade"] as AnyObject?)
            instance.estado = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["estado"] as AnyObject?)
            instance.codigoPostal = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["codigoPostal"] as AnyObject?)
            return instance
        }


        // Decoder for [ExtratoResponse]
        Decoders.addDecoder(clazz: [ExtratoResponse].self) { (source: AnyObject) -> [ExtratoResponse] in
            return Decoders.decode(clazz: [ExtratoResponse].self, source: source)
        }
        // Decoder for ExtratoResponse
        Decoders.addDecoder(clazz: ExtratoResponse.self) { (source: AnyObject) -> ExtratoResponse in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = ExtratoResponse()
            instance.extrato = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["extrato"] as AnyObject?)
            return instance
        }


        // Decoder for [MsgErro]
        Decoders.addDecoder(clazz: [MsgErro].self) { (source: AnyObject) -> [MsgErro] in
            return Decoders.decode(clazz: [MsgErro].self, source: source)
        }
        // Decoder for MsgErro
        Decoders.addDecoder(clazz: MsgErro.self) { (source: AnyObject) -> MsgErro in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = MsgErro()
            instance.mensagem = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["mensagem"] as AnyObject?)
            return instance
        }


        // Decoder for [NovoCartao]
        Decoders.addDecoder(clazz: [NovoCartao].self) { (source: AnyObject) -> [NovoCartao] in
            return Decoders.decode(clazz: [NovoCartao].self, source: source)
        }
        // Decoder for NovoCartao
        Decoders.addDecoder(clazz: NovoCartao.self) { (source: AnyObject) -> NovoCartao in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = NovoCartao()
            instance.idCartao = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["idCartao"] as AnyObject?)
            instance.valor = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["valor"] as AnyObject?)
            instance.contrasenha = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["contrasenha"] as AnyObject?)
            instance.portador = Decoders.decodeOptional(clazz: NovoCartaoPortador.self, source: sourceDictionary["portador"] as AnyObject?)
            return instance
        }


        // Decoder for [NovoCartaoPortador]
        Decoders.addDecoder(clazz: [NovoCartaoPortador].self) { (source: AnyObject) -> [NovoCartaoPortador] in
            return Decoders.decode(clazz: [NovoCartaoPortador].self, source: source)
        }
        // Decoder for NovoCartaoPortador
        Decoders.addDecoder(clazz: NovoCartaoPortador.self) { (source: AnyObject) -> NovoCartaoPortador in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = NovoCartaoPortador()
            instance.nome = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["nome"] as AnyObject?)
            instance.sobrenome = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["sobrenome"] as AnyObject?)
            instance.dataNascimento = Decoders.decodeOptional(clazz: Date.self, source: sourceDictionary["dataNascimento"] as AnyObject?)
            instance.cpf = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["cpf"] as AnyObject?)
            instance.contato = Decoders.decodeOptional(clazz: NovoCartaoPortadorContato.self, source: sourceDictionary["contato"] as AnyObject?)
            instance.endereco = Decoders.decodeOptional(clazz: NovoCartaoPortadorEndereco.self, source: sourceDictionary["endereco"] as AnyObject?)
            return instance
        }


        // Decoder for [NovoCartaoPortadorContato]
        Decoders.addDecoder(clazz: [NovoCartaoPortadorContato].self) { (source: AnyObject) -> [NovoCartaoPortadorContato] in
            return Decoders.decode(clazz: [NovoCartaoPortadorContato].self, source: source)
        }
        // Decoder for NovoCartaoPortadorContato
        Decoders.addDecoder(clazz: NovoCartaoPortadorContato.self) { (source: AnyObject) -> NovoCartaoPortadorContato in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = NovoCartaoPortadorContato()
            instance.email = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["email"] as AnyObject?)
            instance.telResidencial = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["telResidencial"] as AnyObject?)
            instance.telCelular = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["telCelular"] as AnyObject?)
            return instance
        }


        // Decoder for [NovoCartaoPortadorEndereco]
        Decoders.addDecoder(clazz: [NovoCartaoPortadorEndereco].self) { (source: AnyObject) -> [NovoCartaoPortadorEndereco] in
            return Decoders.decode(clazz: [NovoCartaoPortadorEndereco].self, source: source)
        }
        // Decoder for NovoCartaoPortadorEndereco
        Decoders.addDecoder(clazz: NovoCartaoPortadorEndereco.self) { (source: AnyObject) -> NovoCartaoPortadorEndereco in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = NovoCartaoPortadorEndereco()
            instance.logradouro = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["logradouro"] as AnyObject?)
            instance.complemento = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["complemento"] as AnyObject?)
            instance.cidade = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["cidade"] as AnyObject?)
            instance.estado = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["estado"] as AnyObject?)
            instance.pais = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["pais"] as AnyObject?)
            instance.codigoPostal = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["codigoPostal"] as AnyObject?)
            return instance
        }


        // Decoder for [Pagamento]
        Decoders.addDecoder(clazz: [Pagamento].self) { (source: AnyObject) -> [Pagamento] in
            return Decoders.decode(clazz: [Pagamento].self, source: source)
        }
        // Decoder for Pagamento
        Decoders.addDecoder(clazz: Pagamento.self) { (source: AnyObject) -> Pagamento in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = Pagamento()
            instance.pagamento = Decoders.decodeOptional(clazz: SetPagamento.self, source: sourceDictionary["pagamento"] as AnyObject?)
            return instance
        }


        // Decoder for [Portador]
        Decoders.addDecoder(clazz: [Portador].self) { (source: AnyObject) -> [Portador] in
            return Decoders.decode(clazz: [Portador].self, source: source)
        }
        // Decoder for Portador
        Decoders.addDecoder(clazz: Portador.self) { (source: AnyObject) -> Portador in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = Portador()
            instance.nome = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["nome"] as AnyObject?)
            instance.email = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["email"] as AnyObject?)
            instance.celular = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["celular"] as AnyObject?)
            instance.endereco = Decoders.decodeOptional(clazz: EnderecoPortador.self, source: sourceDictionary["endereco"] as AnyObject?)
            return instance
        }


        // Decoder for [PortadorResponse]
        Decoders.addDecoder(clazz: [PortadorResponse].self) { (source: AnyObject) -> [PortadorResponse] in
            return Decoders.decode(clazz: [PortadorResponse].self, source: source)
        }
        // Decoder for PortadorResponse
        Decoders.addDecoder(clazz: PortadorResponse.self) { (source: AnyObject) -> PortadorResponse in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = PortadorResponse()
            instance.portador = Decoders.decodeOptional(clazz: Portador.self, source: sourceDictionary["portador"] as AnyObject?)
            return instance
        }


        // Decoder for [Saldo]
        Decoders.addDecoder(clazz: [Saldo].self) { (source: AnyObject) -> [Saldo] in
            return Decoders.decode(clazz: [Saldo].self, source: source)
        }
        // Decoder for Saldo
        Decoders.addDecoder(clazz: Saldo.self) { (source: AnyObject) -> Saldo in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = Saldo()
            instance.saldo = Decoders.decodeOptional(clazz: Valor.self, source: sourceDictionary["saldo"] as AnyObject?)
            return instance
        }


        // Decoder for [SetCardStatus]
        Decoders.addDecoder(clazz: [SetCardStatus].self) { (source: AnyObject) -> [SetCardStatus] in
            return Decoders.decode(clazz: [SetCardStatus].self, source: source)
        }
        // Decoder for SetCardStatus
        Decoders.addDecoder(clazz: SetCardStatus.self) { (source: AnyObject) -> SetCardStatus in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = SetCardStatus()
            if let status = sourceDictionary["status"] as? String { 
                instance.status = SetCardStatus.Status(rawValue: (status))
            }
            
            return instance
        }


        // Decoder for [SetNovoCartao]
        Decoders.addDecoder(clazz: [SetNovoCartao].self) { (source: AnyObject) -> [SetNovoCartao] in
            return Decoders.decode(clazz: [SetNovoCartao].self, source: source)
        }
        // Decoder for SetNovoCartao
        Decoders.addDecoder(clazz: SetNovoCartao.self) { (source: AnyObject) -> SetNovoCartao in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = SetNovoCartao()
            instance.cartao = Decoders.decodeOptional(clazz: NovoCartao.self, source: sourceDictionary["cartao"] as AnyObject?)
            return instance
        }


        // Decoder for [SetPagamento]
        Decoders.addDecoder(clazz: [SetPagamento].self) { (source: AnyObject) -> [SetPagamento] in
            return Decoders.decode(clazz: [SetPagamento].self, source: source)
        }
        // Decoder for SetPagamento
        Decoders.addDecoder(clazz: SetPagamento.self) { (source: AnyObject) -> SetPagamento in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = SetPagamento()
            instance.idCartao = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["idCartao"] as AnyObject?)
            instance.senha = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["senha"] as AnyObject?)
            instance.codigoBarras = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["codigoBarras"] as AnyObject?)
            return instance
        }


        // Decoder for [SetSaldo]
        Decoders.addDecoder(clazz: [SetSaldo].self) { (source: AnyObject) -> [SetSaldo] in
            return Decoders.decode(clazz: [SetSaldo].self, source: source)
        }
        // Decoder for SetSaldo
        Decoders.addDecoder(clazz: SetSaldo.self) { (source: AnyObject) -> SetSaldo in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = SetSaldo()
            instance.saldo = Decoders.decodeOptional(clazz: SetSaldoValor.self, source: sourceDictionary["saldo"] as AnyObject?)
            return instance
        }


        // Decoder for [SetSaldoValor]
        Decoders.addDecoder(clazz: [SetSaldoValor].self) { (source: AnyObject) -> [SetSaldoValor] in
            return Decoders.decode(clazz: [SetSaldoValor].self, source: source)
        }
        // Decoder for SetSaldoValor
        Decoders.addDecoder(clazz: SetSaldoValor.self) { (source: AnyObject) -> SetSaldoValor in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = SetSaldoValor()
            instance.valor = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["valor"] as AnyObject?)
            return instance
        }


        // Decoder for [SetTransferencia]
        Decoders.addDecoder(clazz: [SetTransferencia].self) { (source: AnyObject) -> [SetTransferencia] in
            return Decoders.decode(clazz: [SetTransferencia].self, source: source)
        }
        // Decoder for SetTransferencia
        Decoders.addDecoder(clazz: SetTransferencia.self) { (source: AnyObject) -> SetTransferencia in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = SetTransferencia()
            instance.idCartao = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["idCartao"] as AnyObject?)
            instance.idCartaoDestino = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["idCartaoDestino"] as AnyObject?)
            instance.valor = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["valor"] as AnyObject?)
            instance.senha = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["senha"] as AnyObject?)
            return instance
        }


        // Decoder for [StatusCartaoResponse]
        Decoders.addDecoder(clazz: [StatusCartaoResponse].self) { (source: AnyObject) -> [StatusCartaoResponse] in
            return Decoders.decode(clazz: [StatusCartaoResponse].self, source: source)
        }
        // Decoder for StatusCartaoResponse
        Decoders.addDecoder(clazz: StatusCartaoResponse.self) { (source: AnyObject) -> StatusCartaoResponse in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = StatusCartaoResponse()
            instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"] as AnyObject?)
            return instance
        }


        // Decoder for [Transferencia]
        Decoders.addDecoder(clazz: [Transferencia].self) { (source: AnyObject) -> [Transferencia] in
            return Decoders.decode(clazz: [Transferencia].self, source: source)
        }
        // Decoder for Transferencia
        Decoders.addDecoder(clazz: Transferencia.self) { (source: AnyObject) -> Transferencia in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = Transferencia()
            instance.transferencia = Decoders.decodeOptional(clazz: SetTransferencia.self, source: sourceDictionary["transferencia"] as AnyObject?)
            return instance
        }


        // Decoder for [TransferenciaCadastroBenificiario]
        Decoders.addDecoder(clazz: [TransferenciaCadastroBenificiario].self) { (source: AnyObject) -> [TransferenciaCadastroBenificiario] in
            return Decoders.decode(clazz: [TransferenciaCadastroBenificiario].self, source: source)
        }
        // Decoder for TransferenciaCadastroBenificiario
        Decoders.addDecoder(clazz: TransferenciaCadastroBenificiario.self) { (source: AnyObject) -> TransferenciaCadastroBenificiario in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = TransferenciaCadastroBenificiario()
            instance.beneficiario = Decoders.decodeOptional(clazz: CadastroBenificiario.self, source: sourceDictionary["beneficiario"] as AnyObject?)
            return instance
        }


        // Decoder for [Valor]
        Decoders.addDecoder(clazz: [Valor].self) { (source: AnyObject) -> [Valor] in
            return Decoders.decode(clazz: [Valor].self, source: source)
        }
        // Decoder for Valor
        Decoders.addDecoder(clazz: Valor.self) { (source: AnyObject) -> Valor in
            let sourceDictionary = source as! [AnyHashable: Any]
            let instance = Valor()
            instance.valor = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["valor"] as AnyObject?)
            return instance
        }
    }()

    static fileprivate func initialize() {
        _ = Decoders.__once
    }
}