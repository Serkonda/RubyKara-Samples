## Snake
#   - Version: 1.0.0 - 2019/10/01

## INSTRUCTIONS
#   - Put the speed slider to the max right
#   - Controls:
#       - "turnLeft" and "turnRight" buttons in the editor

#-- CONSTANTS --#
FRAME_DELAY = 400  # Time between two moves

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

    # Set Kara's position at random
    $karaPos = [@tools.random(14), @tools.random(14)]
    @kara.setPosition($karaPos[0], $karaPos[1])
end

def placeTreeRandom
    x = @tools.random(14)
    y = @tools.random(14)

    # Generate new x and y if these are already blocked
    while !@world.isEmpty(x,y)
        x = @tools.random(14)
        y = @tools.random(14)
    end

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
    # Remove the frontal tree
    @world.setTree($treePos[0], $treePos[1], false)
    $treePlaced = false

    # Add new leaf to the trail
    $trailPositions.push($karaLastPos)
    @world.setLeaf($karaLastPos[0], $karaLastPos[1], true)
end

def updateTrail
    # Remove the last leaf
    @world.setLeaf($trailPositions.first[0], $trailPositions.first[1], false)
    $trailPositions.shift

    # Add a new leaf behind Kara
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
