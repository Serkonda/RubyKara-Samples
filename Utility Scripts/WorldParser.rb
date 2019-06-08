## World Parser
#   - MIT License

#-- MAIN --#
sizeX = world.getSizeX
sizeY = world.getSizeY

worldGenCode = "world.clearAll; world.setSize(#{sizeX}, #{sizeY}); "

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

worldGenFile = File.open("parsedWorld.rb", "w")
worldGenFile.puts worldGenCode
worldGenFile.close
