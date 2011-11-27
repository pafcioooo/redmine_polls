require 'redmine'
require 'wiki_poll_macro'
require 'last_polls_hooks'

Redmine::Plugin.register :redmine_polls do
  name 'Redmine Polls plugin'
  author 'Pavel Vinokurov'
  description 'Polls management. Insert polls and poll results as Wiki macros. Show non-voted polls on Home and on project Overview in a box similar to Latest News'
  version '0.0.1'

  menu :project_menu, :polls, { :controller => 'polls', :action => 'index' }, :caption => :polls, :after => :wiki, :param => :project_id

   project_module :polls do
     permission :edit_polls, {:polls => [:index, :new, :edit, :new_choice, :edit_choice, :delete, :remove_choice]}
     permission :vote_polls, {:polls => [:reset_vote,:vote]}
   end
end
