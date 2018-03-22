//
//  PokeCell.swift
//  POKELIKEMAN
//
//  Created by Bharat Khatke on 22/03/18.
//  Copyright © 2018 Bharat Khatke. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func ConfigureCell(pokemon: Pokemon)  {
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalized
        thumbImage.image = UIImage.init(named: "\(self.pokemon.pokedexID)")
    }
    
}
