require 'redmine'

module PollWikiMacro
  Redmine::WikiFormatting::Macros.register do
    desc "Polls"
    macro :poll do |obj, args|
      id = args[0]

      return '' unless User.current.allowed_to?(:vote_polls, @project )

      begin
        poll = VotingPoll.find(id.to_i)
      rescue ActiveRecord::RecordNotFound
        return Redmine::WikiFormatting.to_html(Setting.text_formatting, "*[Not found poll with  id '" << id << "']*")
      end
      vote = VotingVote.find_by_user_id_and_poll_id(User.current.id, poll.id)
      render :file => '/polls/macro/poll', :locals => { :poll => poll, :vote =>vote}
    end
  end

  Redmine::WikiFormatting::Macros.register do
    desc "Polls result"
    macro :poll_result do |obj, args|
      id = args[0]

      return '' unless User.current.allowed_to?( :vote_polls, @project )

      begin
        poll = VotingPoll.find(id.to_i)
      rescue ActiveRecord::RecordNotFound
        return Redmine::WikiFormatting.to_html(Setting.text_formatting, "*[Not found poll with  id '" << id << "']*")
      end
      render :file => '/polls/macro/poll_result', :locals => { :poll => poll}

    end
  end
end