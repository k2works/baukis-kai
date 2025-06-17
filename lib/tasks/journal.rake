namespace :journal do
  desc "Generate journal entries from Git commit logs"
  task :generate => :environment do
    require 'date'
    require 'fileutils'

    # Directory to store journal entries
    journal_dir = Rails.root.join('docs', 'journal')
    FileUtils.mkdir_p(journal_dir) unless Dir.exist?(journal_dir)

    # Get all commit dates
    dates = `git log --format=%ad --date=short`.lines.map(&:strip).uniq

    dates.each do |date_str|
      next if date_str.empty?
      
      # Format date as YYYYMMDD
      date_obj = Date.parse(date_str)
      formatted_date = date_obj.strftime('%Y%m%d')
      
      # File path for this date's journal
      journal_file = journal_dir.join("#{formatted_date}.md")
      
      # Skip if file already exists
      next if File.exist?(journal_file)
      
      # Get commits for this date
      commits = `git log --since="#{date_str} 00:00:00" --until="#{date_str} 23:59:59" --format="%h %s%n%b"`
      
      # Skip if no commits
      next if commits.strip.empty?
      
      # Get detailed changes for each commit on this date
      detailed_commits = []
      commit_hashes = `git log --since="#{date_str} 00:00:00" --until="#{date_str} 23:59:59" --format="%h"`.lines.map(&:strip)
      
      commit_hashes.each do |hash|
        next if hash.empty?
        
        # Get commit details
        commit_message = `git show -s --format="%s%n%b" #{hash}`.strip
        
        # Get files changed
        files_changed = `git show --name-status #{hash}`.lines.map(&:strip).select { |line| line =~ /^[AMDRT]\s/ }
        
        # Get code changes (diff)
        diff = `git show #{hash} --color=never`
        
        detailed_commits << {
          hash: hash,
          message: commit_message,
          files_changed: files_changed,
          diff: diff
        }
      end
      
      # Create journal content
      content = "# 作業履歴 #{date_str}\n\n"
      content += "## 概要\n\n"
      content += "#{date_str}の作業内容をまとめています。\n\n"
      
      # Add each commit
      detailed_commits.each do |commit|
        content += "## コミット: #{commit[:hash]}\n\n"
        content += "### メッセージ\n\n"
        content += "```\n#{commit[:message]}\n```\n\n"
        
        content += "### 変更されたファイル\n\n"
        commit[:files_changed].each do |file|
          content += "- #{file}\n"
        end
        content += "\n"
        
        content += "### 変更内容\n\n"
        content += "```diff\n#{commit[:diff]}\n```\n\n"
        
        # Add PlantUML diagram placeholder if there are significant structural changes
        if commit[:files_changed].any? { |f| f =~ /\.rb$/ && f =~ /model|controller|service/ }
          content += "### 構造変更\n\n"
          content += "```plantuml\n@startuml\n"
          content += "' このコミットによる構造変更を表すダイアグラムをここに追加してください\n"
          content += "' 例:\n"
          content += "' class NewClass\n"
          content += "' class ExistingClass\n"
          content += "' NewClass --> ExistingClass\n"
          content += "@enduml\n```\n\n"
        end
      end
      
      # Write to file
      File.write(journal_file, content)
      puts "Created journal entry for #{date_str} at #{journal_file}"
    end
    
    puts "Journal generation completed."
  end
end