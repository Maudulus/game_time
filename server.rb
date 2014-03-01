# require 'sinatra'
# require 'shotgun'


  # Teams are sorted first by the number of wins they have
  # (teams with more wins are ranked higher)
  # and second by the number of losses they have
  # (teams with more losses are ranked lower).
  #winner is Patriots
  team_data = [
    {
      home_team: "Patriots",
      away_team: "Broncos",
      home_score: 7,
      away_score: 3
      },
  #winner is Broncos
  {
    home_team: "Broncos",
    away_team: "Colts",
    home_score: 3,
    away_score: 0
    },
  #winner is Patriots
  {
    home_team: "Patriots",
    away_team: "Colts",
    home_score: 11,
    away_score: 7
    },
  #winner is Patriots
  {
    home_team: "Steelers",
    away_team: "Patriots",
    home_score: 7,
    away_score: 21
  }
]


team_array = []

team_data.each do |place|
  team_array << place[:home_team]
  team_array << place[:away_team]
  team_array = team_array.uniq
end
puts team_array

# array = [{:team=>"Patriots"},
# {:team=>"Broncos"},
# {:team=>"Colts"},
# {:team=>"Steelers"}]

win_array = []
team_data.each do |wins|
  if wins[:home_score] > wins[:away_score]
    win_array << wins[:home_team]
  elsif wins[:away_score] > wins[:home_score]
    win_array << wins[:away_team]
  end
end
  #puts win_array

  win_counts = []
  team_array.each do |counter|
    win_counts << {counter => win_array.count(counter)}
    win_counts = win_counts.uniq
  end
  win_counts = Hash[*win_counts.collect{|hash| hash.to_a}.flatten]
  win_counts =  Hash[win_counts.sort_by{|k,v| -v}]
  print win_counts
  puts ""

  loss_array = []
  team_data.each do |losses|
    if losses[:home_score] < losses[:away_score]
      loss_array << losses[:home_team]
    elsif losses[:away_score] < losses[:home_score]
      loss_array << losses[:away_team]
    end
  end
#puts loss_array

loss_counts = []
team_array.each do |counter|
  loss_counts << {counter => loss_array.count(counter)}
  loss_counts = loss_counts.uniq
end
loss_counts = Hash[*loss_counts.collect{|hash| hash.to_a}.flatten]
loss_counts = Hash[loss_counts.sort_by{|k,v| -v}]
puts loss_counts

ranking =[]

ranking << {Patriots: (win_counts["Patriots"] - loss_counts["Patriots"])}
ranking << {Broncos: (win_counts["Broncos"]-loss_counts["Broncos"])}
ranking << {Colts: (win_counts["Colts"]-loss_counts["Colts"])}
ranking << {Steelers: (win_counts["Steelers"]-loss_counts["Steelers"])}
ranking = Hash[*ranking.collect{|hash| hash.to_a}.flatten]
ranking = Hash[ranking.sort_by{|k,v| -v}]
print ranking
# ranking <<  win_counts[1]["Broncos"] - loss_counts[1]["Broncos"]
# ranking <<  win_counts[2]["Colts"] - loss_counts[2]["Colts"]
# ranking <<  win_counts[3]["Steelers"] - loss_counts[3]["Steelers"]
# print ranking
# puts loss_counts[1].merge(win_counts[1])
# puts loss_counts[2].merge(win_counts[2])

loss_counts.each do |hash|
  hash.each do |key,value|
    win_counts.each do |hashes|
      hashes.each do |keyz, valuez|

         # puts keyz

       end
     end
   end
 end



# loss_counts[0]["Patriots"]

# team_data.each do |wins|
#   if wins[:home_score] > wins[:away_score]
#     team_array.each do |pull|
#       if pull[:home_team] == team_array[:team]

#puts team_array

# i=0
# team_data.each do |pull|
# if pull[:home_score] > pull[:away_score]
#   team_array <<
# else



get '/leaderboard' do


 @page_title = "LEADERBOARD"

 erb :leaderboard

end

get '/team/:team' do

 @page_title = params[:home_team]

 erb :teampages
end

