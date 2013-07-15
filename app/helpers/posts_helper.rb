module PostsHelper
	YOUTUBE_REGEX = /^embed:.*youtube\.com\/.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/
	
	def embed_request?(input)
		!!input.match(YOUTUBE_REGEX)
	end

	def video_id(input)
		raise "Invalid input" unless embed_request?(input)
		valid_input.match(YOUTUBE_REGEX)[5]
	end

	def embed_html(input)
		raise "Invalid input" unless embed_request?(input)
		id = video_id(input)
		%Q{<iframe width="560" height="315" src="//www.youtube.com/embed/#{id}" frameborder="0" allowfullscreen></iframe>}
	end
end
