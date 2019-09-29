## Snake
#   - Version: 1.0.0 - development

## INSTRUCTIONS
#   - Put the speed slider to the max right
#
#   - Controls:
#       - "turnLeft" and "turnRight" buttons in the editor

#-- CONSTANTS --#
FRAME_DELAY = 500

#-- GLOBALS --#
$treePlaced = false
$treePos = nil

#-- METHODS --#
def setup
    @world.clearAll
    @world.setSize(15, 15)

    @kara.setPosition(@tools.random(14), @tools.random(14))
end

def placeTreeRandom
    x = @tools.random(14)
    y = @tools.random(14)

    @world.setTree(x, y, true)
    $treePlaced = true
    $treePos = [x, y]
end

def moveKara
    @kara.move
end

#-- MAIN --#
setup

while true
    tools.sleep(FRAME_DELAY)

    if !$treePlaced
        placeTreeRandom
    end

    moveKara
end
