## World Parser 
#   - Version: 1.1.0 - 2019/06/10
#   - Copyright: https://github.com/serkonda/rubykara-samples/blob/master/LICENSE.md

## INSTRUCTIONS
#   - Help: https://github.com/Serkonda/rubykara-samples/wiki/WorldParser.rb


#-- METHODS --#
def chooseFilename (msg = nil)
    $filename = @tools.stringInput(msg || "Choose a filename:")
    
    # Validate the filename
    if $filename.nil?  # Stop execution if 'Abbrechen' was clicked
        @tools.showMessage("World parsing canceled")
        exit!
    elsif $filename.strip.empty?  # Get a new name if it is empty or only has spaces
        chooseFilename("Error: Filename cannot be empty!\r\nPlease choose a new name:")
    end

    # Add the .rb file extension if not present
    if $filename.split(".").last != "rb"
        $filename += ".rb"
    end
end

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
    worldGenFile = File.open($filename, "w")
    worldGenFile.puts $worldCode
    worldGenFile.close
end

#-- MAIN --#
chooseFilename
parseWorld
createFile

# Show a success message
tools.showMessage("World successfully parsed to #{$filename}")
