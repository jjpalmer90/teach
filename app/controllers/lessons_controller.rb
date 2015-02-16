class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  class TimeslotContentsBox
    attr_accessor :availability, :clickable, :slotdate, :slottime
  end

  def index
    @lessons = Lesson.all.order("booked_date DESC")
    @lesson = Lesson.new
    @current_day = DateTime.now
    @week_start = ((@current_day+1.day).to_datetime.beginning_of_week(:sunday)).to_date
    @week_end = (@current_day.at_end_of_week(:saturday)).to_date
    @timeslots = Timeslot.all
    create_grid
  end

  def show
  end

  def new
    @lesson = Lesson.new
  end

  def edit
  end

  def create
    @timeslot = Timeslot.find_by("slot =='#{lesson_params[:booked_time]}'")
    @lesson = @timeslot.lessons.build(lesson_params)
      if @lesson.save
       redirect_to lessons_path
      else
        render :index
      end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url, notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    def create_grid
      @timeslot_grid = Array.new
      for x in 0..173
        @tempobj = TimeslotContentsBox.new
        @tempobj.availability = "free_spot"
        ## Sunday
        if x<=28
          @tempobj.slotdate = @week_start
          @tempobj.slottime = @timeslots[x].slot
        end
        ## Monday
        if x>=29 && x<=57
          @tempobj.slotdate = @week_start+1.day
          @tempobj.slottime = @timeslots[x-29].slot
        end
        ## Tuesday
        if x>=58 && x<=86
          @tempobj.slotdate = @week_start+2.day
          @tempobj.slottime = @timeslots[x-58].slot
        end
        ## Wednesday
        if x>=87 && x<=115
          @tempobj.slotdate = @week_start+3.day
          @tempobj.slottime = @timeslots[x-87].slot
        end
        ## Thursday
        if x>=116 && x<=144
          @tempobj.slotdate = @week_start+4.day
          @tempobj.slottime = @timeslots[x-116].slot
        end
        ## Friday
        if x>=145
          @tempobj.slotdate = @week_start+5.day
          @tempobj.slottime = @timeslots[x-145].slot
        end
        ## Clickable?
        if @tempobj.slotdate>@current_day || (@tempobj.slottime.to_datetime>Time.now && @tempobj.slotdate==@current_day)
          @tempobj.clickable = "modal"
        else
          @tempobj.availability = "unavailable"
        end
        @timeslot_grid[x]=@tempobj
      end

      ## Sunday
      @daily_timeslots = Lesson.all.where("booked_date == '#{@week_start.to_s}'")
      @daily_timeslots.each do |dt|
        if @timeslot_grid[(dt.timeslot.id)-1].availability == "free_spot"
          @timeslot_grid[(dt.timeslot.id)-1].availability = "booked_spot"
          @timeslot_grid[(dt.timeslot.id)].availability = "booked_spot"
        end
      end
      ## Monday
      @daily_timeslots = Lesson.all.where("booked_date == '#{(@week_start+1.day).to_s}'")
      @daily_timeslots.each do |dt|
        if @timeslot_grid[(dt.timeslot.id)+28].availability == "free_spot"
          @timeslot_grid[(dt.timeslot.id)+28].availability = "booked_spot"
          @timeslot_grid[(dt.timeslot.id)+29].availability = "booked_spot"
        end
      end
      ## Tuesday
      @daily_timeslots = Lesson.all.where("booked_date == '#{(@week_start+2.day).to_s}'")
      @daily_timeslots.each do |dt|
        if @timeslot_grid[(dt.timeslot.id)+57].availability == "free_spot"
          @timeslot_grid[(dt.timeslot.id)+57].availability = "booked_spot"
          @timeslot_grid[(dt.timeslot.id)+58].availability = "booked_spot"
        end
      end
      ## Wednesday
      @daily_timeslots = Lesson.all.where("booked_date == '#{(@week_start+3.day).to_s}'")
      @daily_timeslots.each do |dt|
        if @timeslot_grid[(dt.timeslot.id)+86].availability == "free_spot"
          @timeslot_grid[(dt.timeslot.id)+86].availability = "booked_spot"
          @timeslot_grid[(dt.timeslot.id)+87].availability = "booked_spot"
        end
      end
      ## Thursday
      @daily_timeslots = Lesson.all.where("booked_date == '#{(@week_start+4.day).to_s}'")
      @daily_timeslots.each do |dt|
        if @timeslot_grid[(dt.timeslot.id)+115].availability == "free_spot"
          @timeslot_grid[(dt.timeslot.id)+115].availability = "booked_spot"
          @timeslot_grid[(dt.timeslot.id)+116].availability = "booked_spot"
        end
      end
      ## Friday
      @daily_timeslots = Lesson.all.where("booked_date == '#{(@week_start+5.day).to_s}'")
      @daily_timeslots.each do |dt|
        if @timeslot_grid[(dt.timeslot.id)+115].availability == "free_spot"
          @timeslot_grid[(dt.timeslot.id)+144].availability = "booked_spot"
          @timeslot_grid[(dt.timeslot.id)+145].availability = "booked_spot"
        end
      end
    end

    def lesson_params
      params.require(:lesson).permit(:booked_date, :booked_time, :lesson_length, :lesson_location)
    end
end
