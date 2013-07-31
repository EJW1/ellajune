module PostsHelper
	YOUTUBE_REGEX = /youtube\.com\/.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/
	
	def embed_request?(input)
		!!input.match(YOUTUBE_REGEX)
	end

	def video_id(input)
		embed_request?(input)
		input.match(YOUTUBE_REGEX)[5]
	end

	def embedded_html(input)
		embed_request?(input)
		id = video_id(input)
		%Q{<iframe width="560" height="315" src="http://www.youtube.com/embed/#{id}"></iframe>}
	end
end

