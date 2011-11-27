class LastPollsHooks < Redmine::Hook::ViewListener

  def view_welcome_index_right(context = { })
    if !User.current.projects.any? || !User.current.logged?
      return ''
    end

    block = HomeBlock.find_by_name('polls')
    context[:controller].send(:render_to_string, {:locals => {:polls => VotingPoll.unvoted_for_all()}.merge(context), :file => "/polls/polls_box"}) if block
  end

  def view_projects_show_right(context = { })
    if !User.current.logged?
      return ''
    end

    project = context[:project]
    block = OverviewBlock.find_by_project_id_and_name(project,'polls')
    context[:controller].send(:render_to_string, {:locals => {:polls => VotingPoll.unvoted(context[:project].id)}.merge(context), :file => "/polls/polls_box"}) if block
  end

end
