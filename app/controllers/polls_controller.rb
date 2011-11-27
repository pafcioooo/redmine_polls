class PollsController < ApplicationController
  unloadable

  before_filter :find_project,:authorize

  def index
    @polls = VotingPoll.find_all_by_project_id(@project.id)
  end

  def new
    @poll = VotingPoll.new(:project_id => @project.id)
    if request.post?
      @poll.attributes = params[:poll]
      if @poll.save
        redirect_to :action => 'index', :project_id => @project
      end
    end
  end

  def delete
    @poll = VotingPoll.find(params[:id])
    @poll.destroy
    redirect_to :action => 'index', :project_id => @project
  end

  def edit
    @poll = VotingPoll.find(params[:id])
    if request.post? && @poll.update_attributes(params[:poll])
      redirect_to :action => 'index', :project_id => @project
    end
  end

  def new_choice
    @poll = VotingPoll.find(params[:poll_id])
    if request.post?
      @choice = VotingChoice.new()
      @choice.attributes = params[:choice]
      if @choice.save
        redirect_to :action => 'index', :project_id => @project
      end
    end
  end

  def remove_choice
    @choice = VotingChoice.find(params[:id])
    @choice.destroy
    redirect_to :action => 'index', :project_id => @project
  end

  def edit_choice
    @choice = VotingChoice.find(params[:id])
    @poll = VotingPoll.find(params[:poll_id])
    if request.post?
      if @choice.update_attributes(params[:choice])
        redirect_to :action => 'index', :project_id => @project
      end
    end
  end

  def vote
    choice = VotingChoice.find(params[:choice_id])
    exist_vote = VotingVote.find_by_user_id_and_poll_id(User.current.id, choice.poll.id)
    if !exist_vote or choice.poll.revote
      exist_vote.destroy if exist_vote
      vote = VotingVote.new
      vote.user_id = User.current.id
      vote.poll_id = choice.poll.id;
      vote.choice_id = choice.id;
      vote.save
    end
    back_url = CGI.unescape(params[:back_url].to_s)
    redirect_to back_url
  end

  def reset_vote
    poll = VotingPoll.find(params[:poll_id])
    if poll.revote
      vote = VotingVote.find_by_user_id_and_poll_id(User.current.id, params[:poll_id])
      vote.destroy if vote
    end
    back_url = CGI.unescape(params[:back_url].to_s)
    redirect_to back_url    
  end


  private
  def find_optional_project
    return true unless params[:project_id]
    @project = Project.find(params[:project_id])
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

end
