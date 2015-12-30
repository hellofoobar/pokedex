//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by yolo on 2015-12-29.
//  Copyright © 2015 foobar. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var atkLbl: UILabel!
    @IBOutlet weak var defLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
 
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLbl.text = pokemon.name.capitalizedString
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        
        pokemon.downloadPokeonDetails { () -> () in
            //this will be called after download is down
            self.updateUI()
        }
    }

    func updateUI() {
        descLbl.text = pokemon.desc
        typeLbl.text = pokemon.type
        pokedexLbl.text = "\(pokemon.pokedexId)"
        atkLbl.text = pokemon.atk
        defLbl.text = pokemon.def
        weightLbl.text = pokemon.weight
        heightLbl.text = pokemon.height
        if pokemon.nextEvoId != "" {
           nextEvoImg.hidden = false
           nextEvoImg.image = UIImage(named: pokemon.nextEvoId)
            if pokemon.nextEvoLv != "" {
                var str = "Next Evolution: \(pokemon.nextEvoTxt)"
                str += " - LVL \(pokemon.nextEvoLv)"
                evoLbl.text = str
            } else {
                evoLbl.text = ""
            }
        } else {
            evoLbl.text = "No Evolutions"
            nextEvoImg.hidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
