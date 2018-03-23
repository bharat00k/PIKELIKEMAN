//
//  ViewController.swift
//  POKELIKEMAN
//
//  Created by Bharat Khatke on 22/03/18.
//  Copyright © 2018 Bharat Khatke. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var pokemon = [Pokemon]()
    var filterPokemon = [Pokemon]()
    var inSearchMode = false
    var musicPlayer: AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
       searchBar.returnKeyType = UIReturnKeyType.done
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        do {
            musicPlayer = try AVAudioPlayer.init(contentsOf: URL.init(string: path!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError {
            print(err.description)
        }
        
    }
    
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do {
            let csv = try CSV.init(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon.init(name: name, pokedexId: pokeID)
                self.pokemon.append(poke)
            }
            
            //print(rows)
            
        }
        catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return self.filterPokemon.count
        }else {
             return self.pokemon.count;
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let pokeData: Pokemon
            //self.pokemon[indexPath.row]
         
            if inSearchMode {
                pokeData = self.filterPokemon[indexPath.row]
            }else {
                pokeData = self.pokemon[indexPath.row]
            }
            
            cell.ConfigureCell(pokemon: pokeData)
            return cell
        }
        else {
            return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var pokemon: Pokemon!
        if inSearchMode {
           pokemon = self.filterPokemon[indexPath.row]
        }else{
            pokemon = self.pokemon[indexPath.row]
        }
        
      performSegue(withIdentifier: "PokemonDetailSegue", sender: pokemon)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 105, height: 105)
    }
    
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        }else{
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    // SearchbarDelegate method here
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collectionView.reloadData()
        }else{
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            filterPokemon = self.pokemon.filter({$0.name.range(of: lower) != nil })
            
            collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailSegue" {
            if let destController = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    destController.pokemon = poke
                }
            }
        }
    }


}

