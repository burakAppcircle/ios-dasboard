# dangerfile.rb

message("PR başlığından 'PR' kelimesi geçiyor.") if danger.github.pr.title&.include?("PR")
