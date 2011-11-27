class VotingPoll < ActiveRecord::Base
  belongs_to :project
  has_many :choices, :class_name => 'VotingChoice', :foreign_key => 'poll_id', :dependent => :delete_all, :order => "#{VotingChoice.table_name}.created_on"


  validates_presence_of :question
  validates_length_of :question, :maximum => 255

  def vote(answer)
    increment(answer == 'yes'? :yes : :no)
  end

  def VotingPoll.unvoted_for_all
    return [] unless User.current.projects.any?
    polls = VotingPoll.find(:all, :limit => 5, :order => "#{VotingPoll.table_name}.created_on DESC",
                            :conditions => "#{VotingPoll.table_name}.project_id in (#{User.current.projects.collect{|m| m.id}.join(',')}) and vv.id is null",
                            :joins =>"LEFT JOIN #{VotingVote.table_name} vv
                                           ON #{VotingPoll.table_name}.id = vv.poll_id
                                           and vv.user_id = #{User.current.id}")
    return polls;
  end

  def VotingPoll.unvoted project_id
    polls = VotingPoll.find(:all, :limit => 5, :order => "#{VotingPoll.table_name}.created_on DESC",
                            :conditions => "#{VotingPoll.table_name}.project_id = (#{project_id}) and vv.id is null",
                            :joins =>"LEFT JOIN #{VotingVote.table_name} vv
                                           ON #{VotingPoll.table_name}.id = vv.poll_id
                                              and vv.user_id = #{User.current.id} ")
    return polls;
  end

end
