require "crsfml"
require "../src/sqaure"

class Grid
  include SF::Drawable

  def initialize(size : Tuple(Int32, Int32), sqr_size : Int32, @mines : Int32)
    @mines_set = false
    @text = SF::Text.new("", SF::Font.from_file("./src/Roboto-Thin.ttf"), sqr_size * size[1]//8)
    @sqrs = [] of Array(Square)
    @sqrs =
      size[0].times.map do |x|
        size[1].times.map do |y|
          Square.new(sqr_size, {x * sqr_size, y * sqr_size})
        end.to_a
      end.to_a
    set_adj_sqrs(@sqrs)
  end

  # it draws the grid
  def draw(target, states)
    @sqrs.flatten.each { |sqr| target.draw(sqr, states) }
    target.draw(@text)
  end

  def left_click(x, y)
    sqr = @sqrs.flatten.find { |sqr| sqr.within?(x, y) }
    unless sqr.nil?
      set_mines(sqr) unless @mines_set
      sqr.left_click
      check_win_lose
    end
  end

  def right_click(x, y)
    @sqrs.flatten.find { |sqr| sqr.within?(x, y) }.try(&.right_click)
  end

  private def check_win_lose
    if @sqrs.flatten.size - @mines == @sqrs.flatten.count(&.uncovered?)
      @text.style = SF::Text::Bold
      @text.color = SF::Color::Green
      @text.string = "YOU WIN"
    elsif @sqrs.flatten.any? { |s| s.has_mine && s.uncovered? }
      @text.style = SF::Text::Bold
      @text.color = SF::Color::Red
      @text.string = "YOU LOST"
    end
  end

  private def set_mines(sqr)
    @sqrs
      .flatten
      .reject { |s| s == sqr || sqr.adjacent_sqrs.includes?(s) }
      .sample(@mines)
      .each(&.has_mine = true)
    @mines_set = true
  end

  private def set_adj_sqrs(sqrs)
    sqrs.each_with_index do |row, x|
      row.each_with_index do |sqr, y|
        sqr.adjacent_sqrs =
          adjacent_positions({x, y}, sqrs.size, row.size).map { |pos| sqrs[pos[0]][pos[1]] }
      end
    end
  end

  private def adjacent_positions(postion, max_x, max_y)
    [-1, 0, 1].map do |x|
      [-1, 0, 1].map do |y|
        {postion[0] + x, postion[1] + y}
      end
    end.flatten.reject { |pos| pos == postion || ([-1, max_x].includes?(pos[0]) || [-1, max_y].includes?(pos[1])) }
  end
end
