module ApplicationHelper
 def post_tag_cloud(post_tags, classes)
    max = 0
    post_tags.each do |t|
      if t.count.to_i > max
        max = t.count.to_i
      end 
    end
    post_tags.each do |post_tag|
      index = post_tag.count.to_f / max * (classes.size - 1)
      yield(post_tag, classes[index.round])
    end
  end 
end
