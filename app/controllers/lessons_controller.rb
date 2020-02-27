class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :users_authorized_to_view_lessons, only: [:show]

  def show
  end

  private

  def users_authorized_to_view_lessons
    current_course = current_lesson.section.course
    if !current_user.enrolled_in?(current_course)      
      redirect_to course_path(current_course), alert: 'Unauthorized'

    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
