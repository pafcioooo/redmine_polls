class VotingChoice < ActiveRecord::Base
  belongs_to :poll, :class_name => 'VotingPoll', :foreign_key => 'poll_id'
  has_many :votes,  :class_name => 'VotingVote', :foreign_key => 'choice_id', :dependent => :delete_all,
           :order => "#{VotingVote.table_name}.created_on"
  validates_presence_of :text
  validates_length_of :text, :maximum => 100
end
