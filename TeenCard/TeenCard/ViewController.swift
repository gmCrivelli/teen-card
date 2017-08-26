//
//  ViewController.swift
//  TeenCard
//
//  Created by Gustavo De Mello Crivelli on 26/08/17.
//  Copyright © 2017 Gustavo De Mello Crivelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SwaggerClientAPI.customHeaders = ["client_id" : "6d44965e-5644-31f8-ae3c-47fb3fd9e6b5", "access_token" : "fd8e66f8-176e-39e4-9ef8-c6d2faf58278"]
                
        CartoesAPI.cartoesIdCartaoExtratoGet(idCartao: "3713100019350", dataInicial: Date(), dataFinal: Date()) { (response: ExtratoResponse?, error: Error?) in
            if let lista = response?.extrato {
                for detalhe in lista {
                    print(detalhe.dataHora ?? "VAZIO")
                }
            }
            else {
                print("SEUS BURRO TEM NADA AQUI")
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

