require "spec"
require "../src/sqaure"

class FakeWindow
  def draw(a, b)
  end
end

FAKE_WINDOW = FakeWindow.new
FAKE_STATES = nil

def create_test_sqr
  Square.new(10, {0, 0})
end

describe Square do
  it "exists" do
    create_test_sqr
  end

  it "can tell if a position is within it" do
    sqr = create_test_sqr
    sqr.within?(5, 5).should be_true
    sqr.within?(50, 50).should be_false
  end

  it "can be drawn when given a window and states" do
    create_test_sqr.draw(FAKE_WINDOW, FAKE_STATES)
  end

  it "becomes uncovered when left clicked" do
    sqr = create_test_sqr
    sqr.uncovered?.should be_false
    sqr.left_click
    sqr.uncovered?.should be_true
  end

  it "becomes flagged when right clicked" do
    sqr = create_test_sqr
    sqr.flagged?.should be_false
    sqr.right_click
    sqr.flagged?.should be_true
  end

  it "is not uncovered when it is flagged" do
    sqr = create_test_sqr
    sqr.right_click
    sqr.flagged?.should be_true
    sqr.left_click
    sqr.uncovered?.should be_false
  end
end
