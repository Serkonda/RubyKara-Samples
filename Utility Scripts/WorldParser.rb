## World Parser
#   - Copyright: https://github.com/serkonda/rubykara-samples/blob/master/LICENSE.md

## INSTRUCTIONS
#   - Help: https://github.com/Serkonda/rubykara-samples/wiki/WorldParser.rb

#-- MAIN --#
# Get the world size
sizeX = world.getSizeX
sizeY = world.getSizeY
worldGenCode = "world.clearAll; world.setSize(#{sizeX}, #{sizeY}); "

# Iterate over world and get world objects
for x in 0...sizeX
    for y in 0...sizeY
        if world.isLeaf(x, y)
            worldGenCode += "world.setLeaf(#{x}, #{y}, true); "
        elsif world.isTree(x, y) 
            worldGenCode += "world.setTree(#{x}, #{y}, true); "        
        elsif world.isMushroom(x, y)
            worldGenCode += "world.setMushroom(#{x}, #{y}, true); "
        end
    end
end

# Create a script file and write all code to it
worldGenFile = File.open("parsedWorld.rb", "w")
worldGenFile.puts worldGenCode
worldGenFile.close
