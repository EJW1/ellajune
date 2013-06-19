module ApplicationHelper
  def post_tag_cloud(post_tags, classes)
    max = post_tags.sort_by(&:count).last
    post_tags.each do |post_tag|
      index = post_tag.count.to_f / max.count * (classes.size - 1)
      yield(post_tag, classes[index.round])
    end
  end
end
