//
//  Pokemon.swift
//  POKELIKEMAN
//
//  Created by Bharat Khatke on 22/03/18.
//  Copyright © 2018 Bharat Khatke. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokedexID: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexID = pokedexId
    }
}
