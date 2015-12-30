//
//  Pokemon.swift
//  pokedex
//
//  Created by yolo on 2015-12-28.
//  Copyright © 2015 foobar. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _desc: String!
    private var _type: String!
    private var _def: String!
    private var _weight: String!
    private var _height: String!
    private var _nextEvoTxt: String!
    private var _currentEvo: String!
    private var _nextEvoId: String!
    private var _nextEvoLv: String!
    private var _atk: String!
    private var _pokemonUrl: String!

    var name: String {
        return _name ?? ""
    }
    var pokedexId: Int {
        return _pokedexId
    }
    var desc: String {
        return _desc ?? ""
    }
    var type: String {
        return _type ?? ""
    }
    var def: String {
        return _def ?? ""
    }
    var weight: String {
        return _weight ?? ""
    }
    var height: String {
        return _height ?? ""
    }
    var nextEvoLv: String {
        return _nextEvoLv ?? ""
    }
    var nextEvoTxt: String {
        return _nextEvoTxt ?? ""
    }
    var nextEvoId: String {
           return _nextEvoId ?? ""
    }
    var atk: String {
        return _atk ?? ""
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
    }
    
    func downloadPokeonDetails(completed: DownloadComplete) {
        let url = NSURL(string: _pokemonUrl)!
            Alamofire.request(.GET, url).responseJSON { (Response) -> Void in
//               print(Response.result)//sucess
//               if let JSON = Response.result.value {
//                   print("JSON: \(JSON)") //prints the value of the result
                if let dict = Response.result.value as? Dictionary<String, AnyObject> {
                    if let weight = dict["weight"] as? String {
                        self._weight = weight
                    }
                    if let height = dict["height"] as? String {
                        self._height = height
                    }
                    if let atk = dict["attack"] as? Int {
                        self._atk = "\(atk)"
                    }
                    if let def = dict["defense"] as? Int {
                        self._def = "\(def)"
                    }
                    if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                        if let name = types[0] ["name"]?.uppercaseString {
                            self._type = name
                        }
                        if types.count > 1 {
                            for var i = 1 ; i < types.count; i++ {
                                if let name = types[i] ["name"]?.uppercaseString {
                                    self._type! += "/\(name)"
                                }
                            }
                        }
                    } else {
                        self._type = ""
                    }
                    if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0{
                        if let to = evolutions[0] ["to"] as? String {
                            //Mega evo not supported
                            if to.rangeOfString("mega") == nil {
                                if let uri = evolutions[0] ["resource_uri"] as? String {
                                    let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                    let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                    
                                    self._nextEvoId = num
                                    self._nextEvoTxt = to
                                    
                                    if let lv = evolutions[0] ["level"] as? Int {
                                        self._nextEvoLv = "\(lv)"
                                    }
                                    print(self._nextEvoId)
                                    print(self._nextEvoTxt)
                                    print(" Lv:  \(self._nextEvoLv)")
                                }
                            }
                        }
                    } else {
                        
                    }
                    if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                        if let url = descArr[0] ["resource_uri"] {
                            let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                            Alamofire.request(.GET, nsurl).responseJSON { response in
                                if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                    if let desc = descDict["description"] as? String {
                                        self._desc = desc
                                        print(self._desc)
                                    }
                                }
                                completed()
                            }
                        }
                    } else {
                        self._desc = ""
                    }
                    //print("before request")
                    print(self._height)
                    print(self._weight)
                    print(self._atk)
                    print(self._def)
                    print(self._type)
                    ///print(self._desc)
                }
            //} 
                completed()
        }
        ///print("before request")
    }
}