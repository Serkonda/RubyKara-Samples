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
$karaPos = nil
$karaLastPos = nil

$trailPositions = []

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
    $karaLastPos = $karaPos
    
    if @kara.treeFront
        addTrailElement
    end

    @kara.move

    $karaPos = [@kara.getPosition.getX, @kara.getPosition.getY]
end

def addTrailElement
    @world.setTree($treePos[0], $treePos[1], false)
    $treePlaced = false

    $trailPositions.push($karaLastPos)
    @world.setLeaf($karaLastPos[0], $karaLastPos[1], true)
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
