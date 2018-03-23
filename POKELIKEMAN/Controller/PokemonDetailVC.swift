//
//  PokemonDetailVC.swift
//  POKELIKEMAN
//
//  Created by Bharat Khatke on 23/03/18.
//  Copyright © 2018 Bharat Khatke. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    var pokemon: Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // nameLbl.text = pokemon.name

    }

}
