class HomeController < ApplicationController
  def index
    @ships = Ship.all
    @people = Person.all
  end
  
 def up
    session[:id] = true
    ship = Ship.find(params[:id])
    if !session.has_key? :id
        ship.votes += 1
        ship.save
    end
    @dict = {"id" => ship.id, "count" => ship.votes}
    render :json => @dict

 end
 
 def down
    session[:id] = true
    ship = Ship.find(params[:id])
    if !session.has_key? :id
        ship.votes -= 1
        ship.save
    end
    @dict = {"id" => ship.id, "count" => ship.votes}
    render :json => @dict
 end


 def new_ship
    ships = Ship.where("person1 = :a or person2 = :a or person1 = :b or person2 = :b", 
                       {:a => params[:name1], :b => params[:name2]}
                      )
    p1 = params[:name1]
    p2 = params[:name2]
    ships.each do |ship|
        if (ship.person1.to_s == p1 and ship.person2.to_s == p2) or 
           (ship.person1.to_s == p2 and ship.person2.to_s == p1)
            redirect_to "/#exists"
            return
        end
    end

    ship = Ship.new()
    ship.person1 = p1
    ship.person2 = p2
    ship.votes = 1
    ship.save
    
    redirect_to "/#new"
  end
end
