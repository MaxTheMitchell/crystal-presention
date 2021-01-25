require "crsfml"

class Square
  include SF::Drawable

  setter adjacent_sqrs, has_mine
  getter adjacent_sqrs, has_mine

  FLAG_STR = "#"

  def initialize(@size : Int32, @position : Tuple(Int32, Int32))
    @display = SF::RectangleShape.new(SF.vector2(@size, @size))
    @display.fill_color = SF.color(100, 100, 200)
    @display.outline_thickness = (@size * 0.1).to_i
    @display.outline_color = SF::Color::Black
    @display.position = @position
    @adjacent_sqrs = [] of Square
    @text = SF::Text.new("", SF::Font.from_file("./src/Roboto-Thin.ttf"), (@size * 0.9).to_i)
    @text.position = {@position[0] + (@size * 0.2).to_i, @position[1] - (@size * 0.1)}
    @has_mine = false
  end

  def draw(target, states)
    target.draw(@display, states)
    target.draw(@text, states)
  end

  def left_click(clicked = [] of Square)
    unless flagged?
      @display.fill_color = SF.color(200, 100, 100)
      @text.string = has_mine ? "*" : adjacent_mines.to_s
      if text_str == "0"
        @adjacent_sqrs
          .reject { |s| clicked.includes?(s) }
          .each(&.left_click(clicked << self))
      end
    end
  end

  def right_click
    unless uncovered?
      @text.string = @text.string == FLAG_STR ? "" : FLAG_STR
    end
  end

  def within?(x, y)
    within_x_axis?(x) && within_y_axis?(y)
  end

  def uncovered?
    !(flagged? || text_str == "")
  end

  def flagged?
    text_str == FLAG_STR
  end

  private def adjacent_mines
    @adjacent_sqrs.count(&.has_mine)
  end

  private def within_x_axis?(x)
    x >= @position[0] && x <= @position[0] + @size
  end

  private def within_y_axis?(y)
    y >= @position[1] && y <= @position[1] + @size
  end

  private def text_str
    @text.string
  end
end
