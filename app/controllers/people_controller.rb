class PeopleController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if params[:name]
      @person = Person.find_by_name(params[:name])
      if @person
        number_array = @person[:numbers].split
        render json: number_array
        return
      else
        render json: {error: "#{params[:name]} not found."}
        return
      end
    else
      render json: Person.all
      return
    end
  end

  def create
    @person = Person.create_slash_update(person_params)
    if @person.save
      number_array = @person[:numbers].split
      render json: number_array
    else
      render json: {error: "post"}
    end
  end

  def destroy
    if params[:name]
      @person = Person.find_by_name(params[:name])
      if @person
        if params[:wantToDelete] == "yes"
          @person.destroy
          render json: {person: "#{params[:name]} has been desroyed"}
          return
        else
          render json: {error: "In order to delete #{params[:name]}, you must include a `wantToDelete: 'yes'` parameter."}
          return
        end
      else
        render json: {error: "#{params[:name]} not found."}
        return
      end
    else
      destroy_all(params)
    end
  end

  def destroy_all(params)
    if params[:yesIReallyWantToDeleteAll] == "finalAnswer"
      Person.all.each do |person|
        person.destroy
      end
      render json: {allPeople: "deleted"}
    else
      render json: {error: "You are attempting to delete ALL PEOPLE.  If you want to do this, you must include a `yesIReallyWantToDeleteAll: 'finalAnswer'` parameter."}
    end
  end

  private
  def person_params
    params.require(:person).permit(:name, :numbers, :wantToDelete, :yesIReallyWantToDeleteAll)
  end
end
