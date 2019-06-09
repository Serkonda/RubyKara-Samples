## World Parser
#   - Copyright: https://github.com/serkonda/rubykara-samples/blob/master/LICENSE.md

## INSTRUCTIONS
#   - Help: https://github.com/Serkonda/rubykara-samples/wiki/WorldParser.rb


#-- VARIABLES --#
$worldCode = ""

#-- METHODS --#
def parseWorld
    # Get the world size
    sizeX = @world.getSizeX
    sizeY = @world.getSizeY
    $worldCode = "world.clearAll; world.setSize(#{sizeX}, #{sizeY}); "

    # Iterate over world and get world objects
    for x in 0...sizeX
        for y in 0...sizeY
            if @world.isLeaf(x, y)
                $worldCode += "world.setLeaf(#{x}, #{y}, true); "
            end
            if @world.isTree(x, y) 
                $worldCode += "world.setTree(#{x}, #{y}, true); "      
            end  
            if @world.isMushroom(x, y)
                $worldCode += "world.setMushroom(#{x}, #{y}, true); "
            end
        end
    end
end

# Create a script file and write all code to it
def createFile
    worldGenFile = File.open("parsedWorld.rb", "w")
    worldGenFile.puts $worldCode
    worldGenFile.close
end

#-- MAIN --#
parseWorld
createFile

# Show a success message
tools.showMessage("World successfully parsed")
