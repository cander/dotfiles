require 'rake'

task :default => 'install'

desc "Install dot files under HOME"
task :install => :submodules do
  src_dir = ENV['PWD']
  dest_dir = ENV['HOME']
  abort "Destination #{dest_dir} does not exist" unless File.directory?(dest_dir)
  src_files = [ 'bash_profile', 'hgrc', 'inputrc', 'screenrc', 'tmux.conf',
                'gitignore_global', 'vimrc', 'vim' ]

  src_files.each do |src_file|
    install_link("#{src_dir}/#{src_file}", dest_dir)
  end
end

desc "Init and update submodules."
task :submodules do
  sh('git submodule update --init')
end

private

def install_link(src_file, dest_dir)
  dest_file = "#{dest_dir}/.#{File.basename(src_file)}"
  puts "install #{src_file} --> #{dest_file}"
  unless File.exists?(src_file)
    puts "** #{src_file} does not exist - skipping"
    return
  end

  if File.exists?(dest_file)
    if File.symlink?(dest_file)
      if File.readlink(dest_file) == src_file
        return
      end
    end

    orig_file = "#{dest_file}.orig"
    puts "  saving #{dest_file} as #{orig_file}"
    File.unlink(orig_file) if File.exists?(orig_file)
    File.rename(dest_file, orig_file)
  end

  abort "** #{dest_file} should not exist" if File.exists?(dest_file)
  File.symlink(src_file, dest_file)
end

# --- original stuff from https://github.com/skwp/dotfiles


def cmd(cmd_line)
    puts " >> #{cmd_line}"
    `#{cmd_line}`
end
desc "Hook our dotfiles into system-standard positions."
# task :install => :submodules do
task :old_install do
  # this has all the linkables from this directory.
  linkables = []
  # linkables += Dir.glob('git/*') if want_to_install?('git')
  # linkables += Dir.glob('irb/*') if want_to_install?('irb/pry')
  # linkables += Dir.glob('ruby/*') if want_to_install?('ruby (gems)')
  # linkables += Dir.glob('{vim,vimrc}') if want_to_install?('vim')
  # linkables += Dir.glob('zsh/zshrc') if want_to_install?('zsh')
  # linkables += Dir.glob('{vimrc}') if want_to_install?('vim')

  skip_all = false
  overwrite_all = false
  backup_all = false

  linkables.each do |linkable|
    file = linkable.split('/').last
    source = "#{ENV["PWD"]}/#{linkable}"
    target = "#{ENV["HOME"]}/.#{file}"

    puts "--------"
    puts "file:   #{file}"
    puts "source: #{source}"
    puts "target: #{target}"

    if File.exists?(target) || File.symlink?(target)
      unless skip_all || overwrite_all || backup_all
        puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all = true
        when 'S' then skip_all = true
        end
      end
      FileUtils.rm_rf(target) if overwrite || overwrite_all
      `mv "$HOME/.#{file}" "$HOME/.#{file}.backup"` if backup || backup_all
    end
    # lame to run shell for this
    cmd "ln -s \"#{source}\" \"#{target}\""
  end
  
  puts "Done - enjoy."
end

def want_to_install? (section)
  puts "Would you like to install configuration files for: #{section}? [y]es, [n]o"
  STDIN.gets.chomp == 'y'
end

