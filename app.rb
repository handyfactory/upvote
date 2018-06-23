require 'sinatra'
require 'csv'
rewuire 'sinatra/reloader'

get '/'do
    erb :index
end

get '/vote' do
    @name = params[:name]
    @pro = params[:pro]
    
    CSV.open("vote.csv","a+") do |csv|
        csv << [@name, @pro]
    end
    erb :vote
end

get '/result' do
    @total = 0
    @yes = 0
    CSV.foreach("vote.csv") do |v|
        @yes += v[1].to_i
        @total += 1
    end
    
    @cheers = []
    CSV.foreach("cheer.csv") do |row|
        @cheers << row
    end
    
    erb :result
end

get '/cheer' do
    #사용자로부터 응원의 메시지 입력받기
    # cheer.csv에 넣고
    # result 페이지에서 보여주기
    erb :cheer
end


get '/write' do
    @name = params[:name]
    @msg = params[:msg]
    CSV.open("cheer.csv","a+") do |csv|
        csv << [@name, @msg]
    end
    
    
    erb :write
end
