require 'sinatra'
require 'shotgun'


  # Teams are sorted first by the number of wins they have
  # (teams with more wins are ranked higher)
  # and second by the number of losses they have
  # (teams with more losses are ranked lower).
  #winner is Patriots
#   @team_data = [
#     {
#       home_team: "Patriots",
#       away_team: "Broncos",
#       home_score: 7,
#       away_score: 3
#       },
#   {
#     home_team: "Broncos",
#     away_team: "Colts",
#     home_score: 3,
#     away_score: 0
#     },
#   {
#     home_team: "Patriots",
#     away_team: "Colts",
#     home_score: 11,
#     away_score: 7
#     },
#   {
#     home_team: "Steelers",
#     away_team: "Patriots",
#     home_score: 7,
#     away_score: 21
#   }
# ]


# @team_array = []

# @team_data.each do |place|
#   @team_array << place[:home_team]
#   @team_array << place[:away_team]
#   @team_array = @team_array.uniq
# end


# @win_array = []
# @team_data.each do |wins|
#   if wins[:home_score] > wins[:away_score]
#     @win_array << wins[:home_team]
#   elsif wins[:away_score] > wins[:home_score]
#     @win_array << wins[:away_team]
#   end
# end

#   @win_counts = []
#   @team_array.each do |counter|
#     @win_counts << {counter => @win_array.count(counter)}
#     @win_counts = @win_counts.uniq
#   end
#   @win_counts = Hash[*@win_counts.collect{|hash| hash.to_a}.flatten]
#   @win_counts =  Hash[@win_counts.sort_by{|k,v| -v}]


#   @loss_array = []
#   @team_data.each do |losses|
#     if losses[:home_score] < losses[:away_score]
#       @loss_array << losses[:home_team]
#     elsif losses[:away_score] < losses[:home_score]
#       @loss_array << losses[:away_team]
#     end
#   end

# @loss_counts = []
# @team_array.each do |counter|
#   @loss_counts << {counter => @loss_array.count(counter)}
#   @loss_counts = @loss_counts.uniq
# end
# @loss_counts = Hash[*@loss_counts.collect{|hash| hash.to_a}.flatten]
# @loss_counts = Hash[@loss_counts.sort_by{|k,v| -v}]






get '/leaderboard' do
  @team_array = []

  @team_data = [
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


  @team_array = []

  @team_data.each do |place|
    @team_array << place[:home_team]
    @team_array << place[:away_team]
    @team_array = @team_array.uniq
  end

  @win_array = []
  @team_data.each do |wins|
    if wins[:home_score] > wins[:away_score]
      @win_array << wins[:home_team]
    elsif wins[:away_score] > wins[:home_score]
      @win_array << wins[:away_team]
    end
  end

  @win_counts = []
  @team_array.each do |counter|
    @win_counts << {counter => @win_array.count(counter)}
    @win_counts = @win_counts.uniq
  end
  @win_counts = Hash[*@win_counts.collect{|hash| hash.to_a}.flatten]
  @win_counts =  Hash[@win_counts.sort_by{|k,v| -v}]


  @loss_array = []
  @team_data.each do |losses|
    if losses[:home_score] < losses[:away_score]
      @loss_array << losses[:home_team]
    elsif losses[:away_score] < losses[:home_score]
      @loss_array << losses[:away_team]
    end
  end

  @loss_counts = []
  @team_array.each do |counter|
    @loss_counts << {counter => @loss_array.count(counter)}
    @loss_counts = @loss_counts.uniq
  end
  @loss_counts = Hash[*@loss_counts.collect{|hash| hash.to_a}.flatten]
  @loss_counts = Hash[@loss_counts.sort_by{|k,v| -v}]

  @ranking =[]

  @ranking << {Patriots: (@win_counts["Patriots"] - @loss_counts["Patriots"])}
  @ranking << {Broncos: (@win_counts["Broncos"]-@loss_counts["Broncos"])}
  @ranking << {Colts: (@win_counts["Colts"]-@loss_counts["Colts"])}
  @ranking << {Steelers: (@win_counts["Steelers"]-@loss_counts["Steelers"])}
  @ranking = Hash[*@ranking.collect{|hash| hash.to_a}.flatten]
  @ranking = Hash[@ranking.sort_by{|k,v| -v}]

  @final_array = []
  @final_array << {Team: @team_array[0], Overall_Score_Ranking: @ranking[:Patriots], Wins: @win_counts["Patriots"], Losses: @loss_counts["Patriots"]}
  @final_array << {Team: @team_array[1], Overall_Score_Ranking: @ranking[:Broncos], Wins: @win_counts["Broncos"], Losses: @loss_counts["Broncos"]}
  @final_array << {Team: @team_array[3], Overall_Score_Ranking: @ranking[:Steelers], Wins: @win_counts["Steelers"], Losses: @loss_counts["Steelers"]}
  @final_array << {Team: @team_array[2], Overall_Score_Ranking: @ranking[:Colts], Wins: @win_counts["Colts"], Losses: @loss_counts["Colts"]}
  #puts @team_array
   #puts @final_array
  # puts @win_counts
  #puts @ranking
  @page_title = "LEADERBOARD"
  erb :leaderboard
end

get '/team/:team' do
  @team_array = []

  @team_data = [
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
  @game_array = []

  @team_data.each do |find|
    if find[:home_team] || find[:away_team] == params[:team]
      @game_array << find
    end
  end

  @team_array = []

  @team_data.each do |place|
    @team_array << place[:home_team]
    @team_array << place[:away_team]
    @team_array = @team_array.uniq
  end


  @win_array = []
  @team_data.each do |wins|
    if wins[:home_score] > wins[:away_score]
      @win_array << wins[:home_team]
    elsif wins[:away_score] > wins[:home_score]
      @win_array << wins[:away_team]
    end
  end

  @win_counts = []
  @team_array.each do |counter|
    @win_counts << {counter => @win_array.count(counter)}
    @win_counts = @win_counts.uniq
  end
  @win_counts = Hash[*@win_counts.collect{|hash| hash.to_a}.flatten]
  @win_counts =  Hash[@win_counts.sort_by{|k,v| -v}]


  @loss_array = []
  @team_data.each do |losses|
    if losses[:home_score] < losses[:away_score]
      @loss_array << losses[:home_team]
    elsif losses[:away_score] < losses[:home_score]
      @loss_array << losses[:away_team]
    end
  end

  @loss_counts = []
  @team_array.each do |counter|
    @loss_counts << {counter => @loss_array.count(counter)}
    @loss_counts = @loss_counts.uniq
  end
  @loss_counts = Hash[*@loss_counts.collect{|hash| hash.to_a}.flatten]
  @loss_counts = Hash[@loss_counts.sort_by{|k,v| -v}]

  @ranking =[]

  @ranking << {Patriots: (@win_counts["Patriots"] - @loss_counts["Patriots"])}
  @ranking << {Broncos: (@win_counts["Broncos"]-@loss_counts["Broncos"])}
  @ranking << {Colts: (@win_counts["Colts"]-@loss_counts["Colts"])}
  @ranking << {Steelers: (@win_counts["Steelers"]-@loss_counts["Steelers"])}
  @ranking = Hash[*@ranking.collect{|hash| hash.to_a}.flatten]
  @ranking = Hash[@ranking.sort_by{|k,v| -v}]

  @final_array = []
  @final_array << {Team: @team_array[0], Overall_Score_Ranking: @ranking[:Patriots], Wins: @win_counts["Patriots"], Losses: @loss_counts["Patriots"]}
  @final_array << {Team: @team_array[1], Overall_Score_Ranking: @ranking[:Broncos], Wins: @win_counts["Broncos"], Losses: @loss_counts["Broncos"]}
  @final_array << {Team: @team_array[3], Overall_Score_Ranking: @ranking[:Steelers], Wins: @win_counts["Steelers"], Losses: @loss_counts["Steelers"]}
  @final_array << {Team: @team_array[2], Overall_Score_Ranking: @ranking[:Colts], Wins: @win_counts["Colts"], Losses: @loss_counts["Colts"]}

  @single_team_array = []

  @final_array.each do |find|
    if find[:Team] == params[:team]
      @single_team_array << find
    end
  end

  @page_title = params[:team]
  erb :teampages
end

