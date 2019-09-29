## Snake
#   - Version: 1.0.0 - development

## INSTRUCTIONS
#   - Put the speed slider to the max right
#
#   - Controls:
#       - "turnLeft" and "turnRight" buttons in the editor

#-- CONSTANTS --#
FRAME_DELAY = 400

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
    else
        if !$trailPositions.empty?
            updateTrail
        end
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

def updateTrail
    @world.setLeaf($trailPositions.first[0], $trailPositions.first[1], false)
    $trailPositions.shift

    @world.setLeaf($karaLastPos[0], $karaLastPos[1], true)
    $trailPositions.push($karaLastPos)
end

#-- MAIN --#
setup

while !kara.onLeaf
    tools.sleep(FRAME_DELAY)

    if !$treePlaced
        placeTreeRandom
    end

    moveKara
end

tools.showMessage("Game over!")
