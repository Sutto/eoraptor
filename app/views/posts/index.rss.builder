xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0"  do
  xml.channel do
    xml.title       "Ninjas on a Penny Farthing - All Posts"
    xml.description "The RSS feed to subscribe to for all posts on Ninjas on a Penny Farthing"
    xml.link        root_url
    xml.language    "en-au"
    xml.ttl         40
    @posts.each do |post|
      post_address = post_url(post)
      xml.item do        
        xml.title       post.title
        xml.description summary_with_full_link(post, :rss => true)
        xml.pubDate     post.published_at.to_s(:rfc822)
        xml.link        post_address
        xml.guid        post_address
      end
    end
  end
end