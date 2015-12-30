//
//  PokeCell.swift
//  pokedex
//
//  Created by yolo on 2015-12-28.
//  Copyright © 2015 foobar. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var spriteImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalizedString
        spriteImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
