class CreatePolls < ActiveRecord::Migration
  def self.up

    create_table :voting_polls do |t|
      t.column :project_id, :integer, :null => false
      t.column :question, :string, :null =>false
      t.column :created_on, :timestamp, :null =>false
      t.column :revote, :boolean
    end

    add_index :voting_polls, [:project_id], :name => :polls_project_id

    create_table :voting_choices do |t|
      t.column :poll_id, :integer, :null => false
      t.column :text, :string, :null => false
      t.column :created_on, :timestamp, :null => false
      t.column :position, :integer, :default => 1
    end

    add_index :voting_choices, [:poll_id], :name => :choices_poll_id

    create_table :voting_votes do |t|
      t.column :user_id, :integer, :null =>false
      t.column :poll_id, :integer, :null =>false
      t.column :choice_id, :integer, :null =>false
      t.column :created_on, :timestamp, :null => false
    end

    add_index :voting_votes, [:user_id], :name => :votes_user_id
    add_index :voting_votes, [:poll_id], :name => :votes_poll_id
    add_index :voting_votes, [:choice_id], :name => :votes_choice_id
    add_index :voting_votes, [:user_id,:poll_id], :unique => true, :name => :votes_user_poll_unique

  end


  def self.down
    drop_table :voting_polls
    drop_table :voting_choices
    drop_table :voting_votes
  end
end
