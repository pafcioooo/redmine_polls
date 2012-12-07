if Rails::VERSION::MAJOR >= 3
  RedmineApp::Application.routes.draw do
    match 'projects/:project_id/polls' => 'polls#index'
    match 'projects/:project_id/polls/new' => 'polls#new'
    match 'projects/:project_id/polls/:id/edit' => 'polls#edit'
    match 'projects/:project_id/polls/:id/delete' => 'polls#delete'
    match 'projects/:project_id/polls/vote' => 'polls#vote'
    match 'projects/:project_id/polls/new_choice' => 'polls#new_choice'
    match 'projects/:project_id/polls/:poll_id/edit_choice/:id' => 'polls#edit_choice'
    match 'projects/:project_id/polls/remove_choice/:id' => 'polls#remove_choice'
  end
end
