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

#-- METHODS --#
def setup
    @world.clearAll
    @world.setSize(15, 15)

    @kara.setPosition(@tools.random(14), @tools.random(14))
end

def moveKara
    @kara.move
end

#-- MAIN --#
setup

while true
    tools.sleep(FRAME_DELAY)

    moveKara
end
