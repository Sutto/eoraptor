Post.blueprint do
  title   { Forgery(:lorem_ipsum).sentence(:random => true) }
  format  "markdown"
  summary { Forgery(:lorem_ipsum).paragraphs(rand(2) + 1, :random => true) }
  content { Forgery(:lorem_ipsum).paragraphs(rand(5) + 2, :random => true) } 
end
