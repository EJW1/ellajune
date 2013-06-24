class StaticPagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:about]

  def community_guidelines
  end

  def about
  end

  def get_involved
  end

  def staff
  end

  def vision
  end
end
