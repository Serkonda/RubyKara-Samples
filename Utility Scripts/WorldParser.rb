## World Parser 
#   - Version: 1.2.0 - 2019/06/12
#   - Copyright: https://github.com/serkonda/rubykara-samples/blob/master/LICENSE.md

## INSTRUCTIONS
#   - Help: https://github.com/Serkonda/rubykara-samples/wiki/WorldParser.rb


#-- GLOBALS --#
$filename = ""
$worldCode = ""
$codeToKeep = ""

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

def getCodeToKeep
    # No exisitng file, no existing code
    return if !File.exist?($filename)

    currentCode = ""
    
    # Read the file content
    file = File.open($filename, "r")
    file.each_line{ |line|
        currentCode += line
    }
    file.close
end

def parseWorld
    # Get the world size
    sizeX = @world.getSizeX
    sizeY = @world.getSizeY
    parsedCode = "@world.clearAll; @world.setSize(#{sizeX}, #{sizeY}); "

    # Iterate over world and get world objects
    for x in 0...sizeX
        for y in 0...sizeY
            if @world.isLeaf(x, y)
                parsedCode += "@world.setLeaf(#{x}, #{y}, true); "
            end
            if @world.isTree(x, y) 
                parsedCode += "@world.setTree(#{x}, #{y}, true); "      
            end  
            if @world.isMushroom(x, y)
                parsedCode += "@world.setMushroom(#{x}, #{y}, true); "
            end
        end
    end
 
    # Parse position of Kara
    begin  # Prevent programm from breaking if Kara is not in the world
        karaX = @kara.getPosition.getX
        karaY = @kara.getPosition.getY 

        parsedCode += "@kara.setPosition(#{karaX}, #{karaY}); "
    rescue     
    end

    $worldCode = "def setupWorld; #{parsedCode}end\r\n\r\n"  # Write the code as a method
    $worldCode += "setupWorld\r\n"  # Add the method call
end

# Create a script file and write all code to it
def createFile
    worldGenFile = File.open($filename, "w")
    worldGenFile.puts ($worldCode + $codeToKeep)
    worldGenFile.close
end

#-- MAIN --#
chooseFilename

getCodeToKeep
parseWorld

createFile

# Show a success message
tools.showMessage("World successfully parsed to #{$filename}")
