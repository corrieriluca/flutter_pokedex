#!/usr/bin/env python
# -*- coding: utf-8 -*-

# This script initializes the SQLite database of Pokemon needed by the Flutter
# Pokédex...

import requests, sqlite3, os, sys


def create_connection(db_file):
    """ 
    create a database connection to the SQLite database
    specified by the db_file
    """
    try:
        conn = sqlite3.connect(db_file)
        print("Connected to database successfully")
        return conn
    except EnvironmentError as e:
        print(e)
 
    return None


def initDB(conn):
    """
    initializes the database, creating the POKEMONS and the MOVES tables
    """
    print("Initializing database...")
    conn.execute('''CREATE TABLE POKEMONS 
        (id INT PRIMARY KEY NOT NULL,
        name TEXT NOT NULL,
        types TEXT NOT NULL,
        abilities TEXT NOT NULL,
        height INT NOT NULL,
        weight INT NOT NULL,
        moves TEXT NOT NULL,
        stats TEXT NOT NULL,
        description TEXT NOT NULL,
        evolution_chain TEXT NOT NULL);''')
    print("Table Pokemon successfully created")
    
    conn.execute('''CREATE TABLE MOVES
        (id INT PRIMARY KEY NOT NULL,
        name TEXT NOT NULL,
        type TEXT NOT NULL);''')
    print("Table Moves successfully created")


def loadMoves(conn):
    """
    loads the moves from the PokeAPI and fills the Moves table accordingly
    """
    moveNumber = 20 # default is 746
    print("MOVE : Loading data for {0} moves...".format(moveNumber))
    url = "https://pokeapi.co/api/v2/move/?offset=0&limit={0}".format(moveNumber)
    r = requests.get(url)
    movesJSON = r.json()
    for move in movesJSON["results"]:
        addMove(conn, move)


def addMove(conn, move):
    """
    adds the move to the database from the given URL
    """
    r = requests.get(move["url"])
    moveJSON = r.json()

    moveID = moveJSON["id"]
    name = moveJSON["name"]
    moveType = moveJSON["type"]["name"]

    command = "INSERT INTO MOVES (id, name, type) VALUES({0}, '{1}', '{2}')".format(moveID, name, moveType)
    conn.execute(command)
    conn.commit()
    print("MOVE : {0} successfully added".format(name))



def loadPokemons(conn):
    """
    Fetches the JSON files from the PokeAPI and fills the Pokemon table
    accordingly
    """
    pokemonNumber = 20
    print("POKEMON : Loading data for {0} pokemons...".format(pokemonNumber))
    for i in range(1, pokemonNumber + 1):
        url = "https://pokeapi.co/api/v2/pokemon/{0}/".format(i)
        r = requests.get(url)
        jsonPokemon = r.json()
        addPokemon(conn, jsonPokemon)


def addPokemon(conn, jsonPokemon):
    """
    add the pokemon from the json into the database
    """
    print("POKEMON : Adding {0} into the database".format(jsonPokemon["name"]))

    pokeID = jsonPokemon["id"]
    name = jsonPokemon["name"]
    types = formatTypes(jsonPokemon["types"])
    abilities = formatAbilities(jsonPokemon["abilities"])
    height = jsonPokemon["height"]
    weight = jsonPokemon["weight"]
    moves = formatMoves(jsonPokemon["moves"])
    stats = formatStats(jsonPokemon["stats"])
    (description, evolutionChain) = getDescAndEvolution(pokeID)
    
    command = "INSERT INTO POKEMONS (id, name, types, abilities, height, weight, moves, stats, description, evolution_chain) \
        VALUES ({0}, '{1}', '{2}', '{3}', {4}, {5}, '{6}', '{7}', '{8}', '{9}')".format(pokeID, name, types, abilities, height, weight, moves, stats, description, evolutionChain)
    
    conn.execute(command)
    conn.commit()
    print("POKEMON : {0} successfully inserted into the database".format(name))


def formatTypes(types):
    """
    returns a string "type1;type2;" for the database
    """
    res = ""
    for i in range (len(types) - 1, -1, -1):
        res += types[i]["type"]["name"] + ";"
    return res


def formatAbilities(abilities):
    """
    same as formatTypes but for abilities
    """
    res = ""
    for i in range (len(abilities) - 1, -1, -1):
        res += abilities[i]["ability"]["name"] + ";"
    return res


def formatMoves(moves):
    """
    same as formatTypes but for moves
    """
    res = ""
    for i in range (len(moves) - 1, -1, -1):
        res += moves[i]["move"]["name"] + ";"
    return res


def formatStats(stats):
    """
    same as formatTypes but for stats
    """
    res = ""
    for i in range (len(stats) - 1, -1, -1):
        res += str(stats[i]["base_stat"]) + ";"
    return res


def getDescAndEvolution(pokeID):
    """
    returns a tuple<str,str> (description, evolutionChain) for the given pokemonID
    """
    description = ""
    evolutionChain = ""
    
    descURL = "https://pokeapi.co/api/v2/pokemon-species/{0}/".format(pokeID)
    r = requests.get(descURL)
    jsonFile = r.json()
    
    # retrieves the first english description
    for entry in jsonFile["flavor_text_entries"]:
        if entry["language"]["name"] == "en":
            description = entry["flavor_text"]
            break

    r = requests.get(jsonFile["evolution_chain"]["url"])
    jsonFile = r.json()

    # makes a string 'elt1;elt2;' for the evolution chain
    evolutionChain += jsonFile["chain"]["species"]["name"] + ";"
    for entry in jsonFile["chain"]["evolves_to"]:
        evolutionChain += entry["species"]["name"] + ";"
        if entry["evolves_to"]:
            for deeperEntry in entry["evolves_to"]:
                evolutionChain += deeperEntry["species"]["name"] + ";"

    return (description, evolutionChain)


def main():
    database = '../assets/pokemonDatabase.db'

    # is the database already exists, erases it.
    if os.path.isfile(database):
        os.remove(database)
        print("{0} removed before re-creating".format(database))
    
    conn = create_connection(database)
    with conn:
        initDB(conn)
        loadPokemons(conn)
        loadMoves(conn)
    
    conn.close()
    print("End.")
    

if __name__ == '__main__':
    main()