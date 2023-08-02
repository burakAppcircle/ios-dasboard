warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Force rebase

if git.commits.any? { |c| c.message =~ /^Merge branch '#{github.branch_for_base}'/ }
    fail "Please rebase first"
  end

# Fail the PR if they didn't provide a description

if github.pr_body.length < 10
    fail "Please provide a description"
end

# Warn if PR is too big

warn("This pull request is quite big (#{git.lines_of_code} lines changed), please consider splitting it into multiple pull requests.") if git.lines_of_code > 200

# Run Xcov

xcov.report(
  scheme: ENV['AC_SCHEME']
  workspace: ENV['AC_PROJECT_PATH'],
  xccov_file_direct_path: ENV['AC_TEST_RESULT_PATH'],
  only_project_targets: true,
  markdown_report: true,
  html_report: false
)  
