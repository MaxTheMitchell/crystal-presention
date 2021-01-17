require "crsfml"
require "../src/grid"

SQUARE_SIZE = 50
GRID_SIZE   = {20, 10}
MINES       = 20

grid = Grid.new(GRID_SIZE, SQUARE_SIZE, MINES)
window = SF::RenderWindow.new(SF::VideoMode.new(GRID_SIZE[0] * SQUARE_SIZE, GRID_SIZE[1] * SQUARE_SIZE), "Mine Sweeper")
states = SF::RenderStates.new(
  transform: SF::Transform.new
    .scale(1, 1)         # Allow all operations to use 1 as the size of the grid
    .translate(0.5, 0.5) # Move the reference point to centers of grid squares
)

while window.open?
  while event = window.poll_event
    if event.is_a? SF::Event::Closed || (event.is_a?(SF::Event::KeyPressed) && event.code.escape?)
      window.close
    elsif event.is_a? SF::Event::MouseButtonPressed
      if event.button.left?
        grid.left_click(event.x, event.y)
      elsif event.button.right?
        grid.right_click(event.x, event.y)
      end
    end
  end
  window.clear SF::Color::White
  window.draw(grid, states)
  window.display
end
