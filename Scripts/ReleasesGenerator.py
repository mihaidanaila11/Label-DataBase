import random

def generateFile(inputFilePath, outputFilePath):

    artists = {}
    releases = {}


    # Urmatorul ID valabil pentru artisti in baza de date
    artistId = 7

    # Urmatorul ID valabil pentru lansari in baza de date
    releaseId = 6

    # Urmatorul ID valabil pentru coperte in baza de date
    artworkId = 6

    # Urmatorul ID valabil pentru melodii in baza de date
    songId = 6

    # Genul melodiilor din Input
    idGen = 3

    inputFile = open(inputFilePath, 'r')
    outputFile = open(outputFilePath, 'w')

    inputLines = inputFile.readlines()
    inputFile.close()

    for song in inputLines:
        # Track name,Artist name,Album,Playlist name,Type,ISRC,Spotify - id
        songData = song.strip().replace("\"","").replace("'","''").split(',')

        trackName = songData[0]
        artistName = songData[1]
        albumName = songData[2]

        if artistName not in artists:

            artists[artistName] = artistId
            outputFile.write("INSERT INTO artisti (id_artist, nume_scena, id_gen)\n"+
                             f"VALUES ({artistId}, '{artistName}', {idGen});\n\n")
            artistId += 1

        if albumName not in releases:
            releases[albumName] = {
                "id": releaseId,
                "artworkId" : artworkId
            }
            outputFile.write("INSERT INTO coperte\n"+
                             f"VALUES ({artworkId}, 1000, 1000, PNG);\n\n")
            
            outputFile.write("INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)\n"+
                             f"VALUES ({releaseId}, '{albumName}', 1, {idGen}, {artworkId});\n\n")

            outputFile.write(f"INSERT INTO asoc_lansari VALUES ({artists[artistName]}, {releaseId});\n\n")
            
            releaseId += 1
            artworkId += 1
        
        outputFile.write("INSERT INTO melodii\n"+
                         f"VALUES ({songId}, '{trackName}', {random.randint(100000,500000)}, "+ 
                         f"{releases[albumName]["id"]}, {idGen});\n\n")
        songId += 1
        
    outputFile.close()
        
generateFile("Scripts/input.csv", "Scripts/output.sql")