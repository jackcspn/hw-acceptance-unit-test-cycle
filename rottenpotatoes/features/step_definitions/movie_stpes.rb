Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create! movie
  end
end

Then /the director of "(.*?)" should be "(.*?)"/ do |movie_title, movie_director|
  Movie.where(title: movie_title).first.director.should eq movie_director
end