require 'rake'

# Some Globals:
$skip_all = false;
$overwrite_all = false;
$backup_all = false;


def link_dotfiles()
  link_with_check(".", "#{ENV["HOME"]}/dotfiles")

  home = %Q{#{ENV["HOME"]}}
  if !File.exists?("private")
    system %Q{mkdir "private"}
    puts "-- Created:    private/"
  else
    puts "-- Skipped:    private/ already exists"
  end

  linkables = Dir.glob('*{.symlink}')
  linkables.each do |linkable|
    filename = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{filename}"

    link_with_check(linkable, target)
  end

  private_linkables = Dir.glob('private/*{.symlink}')
  private_linkables.each do |linkable|
    filename = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{filename}"

    link_with_check(linkable, target)
  end
end


def link_with_check(source, target)
  skip = false
  overwrite = false
  backup = false

  if (File.exists?(target) || File.symlink?(target)) && !(File.identical? source, target)
    unless $skip_all || $overwrite_all || $backup_all
      puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
      case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 's' then skip = true
        when 'O' then $overwrite_all = true
        when 'B' then $backup_all = true
        when 'S' then $skip_all = true
      end
      puts
    end
    if overwrite || $overwrite_all
      FileUtils.rm_rf(target)
      puts "-- Removed:  #{target}"
    end
    if backup || $backup_all
      system %Q{mv "#{target}" "#{target}.backup"}
      puts "-- Backed up:  #{target}  to  #{target}.backup"
    end
    if skip || $skip_all
      puts "-- Skipped:    #{source}"
      skip = true
    end
  end
  if !skip
    if File.identical? source, target
      puts "-- Identical:  #{source}"
      return
    end

    system %Q{ln -s "$PWD/#{source}" "#{target}"}
    if source == "."
      puts "-- Linked:     dotfiles"
    else
      puts "-- Linked:     #{source}"
    end
  end
end


desc "Dotfiles: Begin linking. Prompt for input when conflicts arise."
task :install do
  link_dotfiles
end


namespace :install do
  desc "Dotfiles: Begin linking. Skip any files that are already in place."
  task :skip do
    $skip_all = true
    link_dotfiles
  end

  desc "Dotfiles: Begin linking. Overwrite any files that are already in place."
  task :overwrite do
    $overwrite_all = true
    link_dotfiles
  end

  desc "Dotfiles: Begin linking. Backup any files that are already in place."
  task :backup do
    $backup_all = true
    link_dotfiles
  end
end


desc "Dotfiles: Remove dotfiles that were managed by this Rakefile."
task :uninstall do
  puts "This will remove any symlinks created, and restore the last backups made. Continue uninstalling? y/n"
  user_input = STDIN.gets.chomp
  return if (user_input.downcase != 'y')
  Dir.glob('**{,/*/**}/*.symlink').each do |linkable|
    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"
    # Remove all symlinks created during installation
    if File.symlink?(target)
      FileUtils.rm(target)
      puts "-- Removed:  #{file}"
    end
    # Replace any backups made during installation
    if File.exists?("#{ENV["HOME"]}/.#{file}.backup")
      system %Q{mv "$HOME/.#{file}.backup" "$HOME/.#{file}"}
      puts "-- Reinstated:  #{file}.backup"
    end
  end

  target = %Q{#{ENV["HOME"]}} + "/dotfiles"
  if File.symlink?(target)
    FileUtils.rm(target)
    puts "-- Removed:  #{target}"
  end
end


task :default => 'install'
