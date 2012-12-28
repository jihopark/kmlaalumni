class EducationsController < ApplicationController


  # *** PUBLIC METHODS *** #
  
  
  # Method: create
  # --------------------------------------------
  # 
  def create
    @school = School.where('LOWER(name) = ?', params[:school_name].downcase.strip).first

    if @school.blank?
      @school = School.new(name: params[:school_name].strip)
      @school.save
    end

    @education = @school.errors.blank? ? Education.create(user: current_user, school: @school) : nil
    
    respond_to do |format|
      format.js
    end
  end
  
  # Method: destroy
  # --------------------------------------------
  #
  def destroy
  end
  
  # Method: update
  # --------------------------------------------
  #
  def update
    @education = Education.find(params[:id])
    @education.update_attributes(params[:education])
    respond_to do |format|
      format.js
    end
  end
  
  # Method: get_school_suggestions
  # --------------------------------------------
  #
  def get_school_suggestions
    if params[:term]
      query = params[:term].downcase.strip
      @schools = School.where('LOWER(name) LIKE ?', "%#{query}%").limit(5)
    else
      @schools = School.limit(5)
    end

    respond_to do |format|  
      format.json { render json: @schools }
    end
  end
  
end
