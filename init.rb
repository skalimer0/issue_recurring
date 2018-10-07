require_dependency 'issue_recurring/issue_recurrences_view_listener'

ActionDispatch::Reloader.to_prepare do
  Issue.include IssueRecurring::IssuePatch
  IssuesController.include IssueRecurring::IssuesControllerPatch
  IssuesHelper.include IssueRecurring::IssuesHelperPatch
end

Redmine::Plugin.register :issue_recurring do
  name 'Issue recurring plugin'
  author 'cryptogopher'
  description 'Schedule Redmine issue recurrence based on multiple conditions'
  version '0.0.1'
  url 'https://github.com/cryptogopher/issue_recurring'
  author_url 'https://github.com/cryptogopher'

  project_module :issue_tracking do
    permission :view_issue_recurrences, {:issue_recurrences => [:index]},
      read: true
    permission :manage_issue_recurrences, {:issue_recurrences => [:create, :destroy]},
      require: :loggedin
  end
end
