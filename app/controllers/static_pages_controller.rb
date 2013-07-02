class StaticPagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:about]

  def community_guidelines
  end

  def mission
  end

  def get_involved
  end

  def contact
  end

  def vision
  end
end
